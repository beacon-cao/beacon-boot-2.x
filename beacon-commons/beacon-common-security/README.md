# beacon-common-security 模块说明

## 一、模块概述

`beacon-common-security` 是基于 **Spring Security** 框架封装的安全认证模块，为整个 Beacon Boot 平台提供统一的请求安全控制能力。模块采用 **无状态 Token 认证** 机制（基于 OAuth2.0 访问令牌），结合 Spring Security 的过滤器链和 AOP 切面，实现从请求入口到方法级别的多层次安全防护。

### 核心能力

| 能力 | 说明 |
|------|------|
| Token 认证 | 基于 Bearer Token 的无状态身份认证 |
| URL 级别鉴权 | 基于 Spring Security 过滤器链的请求 URL 白名单和权限控制 |
| 方法级别鉴权 | 基于 `@PreAuthenticated` 注解和 `@PreAuthorize` 表达式的细粒度权限校验 |
| 异步上下文传递 | 使用 `TransmittableThreadLocal` 确保异步场景下安全上下文的正确传递 |
| Mock 模式 | 开发调试场景下的模拟登录功能 |
| 可扩展授权 | 提供 `AuthorizeRequestsCustomizer` 抽象类，支持各业务模块自定义 URL 授权规则 |

---

## 二、模块依赖

```
beacon-common-security
├── beacon-common              (公共组件：异常、工具类等)
├── beacon-common-web          (Web层配置：GlobalExceptionHandler、WebProperties等)
├── beacon-business-system-api (业务系统API：OAuth2TokenApi、PermissionApi)
├── spring-boot-starter-security (Spring Security)
├── spring-boot-starter-aop     (AOP支持，用于@PreAuthenticated切面)
├── guava                       (Google工具库)
└── TTL (TransmittableThreadLocal) (阿里巴巴开源，线程上下文传递)
```

---

## 三、核心架构

```
                              ┌─────────────────────────────────────┐
                              │      HTTP Request                   │
                              └─────────────────┬───────────────────┘
                                                │
                                                ▼
                              ┌─────────────────────────────────────┐
                              │   TokenAuthenticationFilter         │
                              │   ┌─────────────────────────────┐   │
                              │   │ 1. 提取Header中的Bearer Token│   │
                              │   │ 2. 调用OAuth2TokenApi校验    │   │
                              │   │ 3. Mock模式判断（开发环境）   │   │
                              │   │ 4. 设置LoginUser到上下文      │   │
                              │   └─────────────────────────────┘   │
                              └─────────────────┬───────────────────┘
                                                │
                                                ▼
                              ┌─────────────────────────────────────┐
                              │   Spring Security Filter Chain      │
                              │   ┌─────────────────────────────┐   │
                              │   │ URL 鉴权规则（按优先级）：    │   │
                              │   │ ① 静态资源          permitAll│   │
                              │   │ ② @PermitAll注解    permitAll│   │
                              │   │ ③ 配置文件白名单    permitAll│   │
                              │   │ ④ App API          permitAll│   │
                              │   │ ⑤ 自定义规则        按模块   │   │
                              │   │ ⑥ 兜底规则         authenticated│
                              │   └─────────────────────────────┘   │
                              └─────────────────┬───────────────────┘
                                                │
                                                ▼
                              ┌─────────────────────────────────────┐
                              │   Method Level Security             │
                              │   ┌─────────────────────────────┐   │
                              │   │ @PreAuthenticated (AOP切面)  │   │
                              │   │ @PreAuthorize("@ss.hasPerm") │   │
                              │   └─────────────────────────────┘   │
                              └─────────────────┬───────────────────┘
                                                │
                                                ▼
                              ┌─────────────────────────────────────┐
                              │   异常处理                           │
                              │   ┌─────────────────────────────┐   │
                              │   │ 未登录 → 401 (UNAUTHORIZED)  │   │
                              │   │ 无权限 → 403 (FORBIDDEN)     │   │
                              │   └─────────────────────────────┘   │
                              └─────────────────────────────────────┘
```

---

## 四、请求安全控制流程详解

### 4.1 整体时序

```
客户端                    TokenAuthenticationFilter        OAuth2TokenApi       SecurityContext        Controller
  │                              │                              │                    │                     │
  │  GET /api/user/list          │                              │                    │                     │
  │  Authorization: Bearer xxx   │                              │                    │                     │
  │─────────────────────────────>│                              │                    │                     │
  │                              │                              │                    │                     │
  │                              │  提取 "Bearer xxx" Token     │                    │                     │
  │                              │                              │                    │                     │
  │                              │  checkAccessToken("xxx")     │                    │                     │
  │                              │─────────────────────────────>│                    │                     │
  │                              │                              │                    │                     │
  │                              │  OAuth2AccessTokenCheckResp   │                    │                     │
  │                              │  {userId, userType, scopes}  │                    │                     │
  │                              │<─────────────────────────────│                    │                     │
  │                              │                              │                    │                     │
  │                              │  构建 LoginUser               │                    │                     │
  │                              │  setLoginUser(user, request)  │                    │                     │
  │                              │──────────────────────────────────────────────────>│                     │
  │                              │                              │                    │                     │
  │                              │  chain.doFilter()            │                    │                     │
  │                              │                              │                    │                     │
  │                              │                              │    URL鉴权通过      │                     │
  │                              │                              │────────────────────────────────────────>│
  │                              │                              │                    │                     │
  │                              │                              │                    │   @PreAuthenticated  │
  │                              │                              │                    │   检查LoginUser存在  │
  │                              │                              │                    │   @PreAuthorize      │
  │                              │                              │                    │   检查权限/角色      │
  │                              │                              │                    │                     │
  │                              │                              │                    │   <-- 200 OK --      │
```

### 4.2 认证流程（Token 验证）

`TokenAuthenticationFilter` 是请求安全控制的核心入口，它继承自 `OncePerRequestFilter`，确保每个请求只执行一次。

**处理逻辑：**

1. **提取 Token**：从请求 Header 中获取 Authorization 值，解析出 `Bearer ` 前缀后的 Token 字符串
2. **Token 校验**：调用 `OAuth2TokenApi.checkAccessToken(token)` 远程校验 Token 有效性，返回用户信息（userId、userType、scopes）
3. **用户类型校验**：对比请求头中的 `userType` 与 Token 中的 `userType`，不匹配则抛出 `AccessDeniedException`
4. **Mock 模式**：若 Token 校验失败且开启了 Mock 模式，尝试以 `mockSecret + userId` 的格式解析模拟用户（仅开发环境）
5. **上下文设置**：将构建的 `LoginUser` 对象设置到 `SecurityContextHolder` 和 `HttpServletRequest` 属性中
6. **异常兜底**：Token 不合法或过期时返回 `null`，不阻断过滤器链（允许访问免登录接口）

### 4.3 URL 级别鉴权

`WebSecurityConfigurerAdapter` 配置了完整的 Spring Security 过滤器链，URL 鉴权规则按以下优先级执行：

```
┌──────────────────────────────────────────────────────┐
│ 优先级 │        规则               │    说明          │
├──────────────────────────────────────────────────────┤
│   1   │ 静态资源 (*.html/*.css/*.js) │  GET 请求允许匿名  │
│   2   │ @PermitAll 注解标记的接口    │  扫描所有Controller │
│   3   │ 配置文件白名单               │  framework.security │
│       │                            │  .permit-all-urls   │
│   4   │ App API (/app-api/**)       │  前端App接口免认证   │
│   5   │ Admin API (/admin-api/**)   │  后端管理接口需认证  │
│   6   │ 各模块自定义规则             │  AuthorizeRequests  │
│       │                            │  Customizer扩展点   │
│   7   │ 兜底规则                    │  所有请求必须认证    │
└──────────────────────────────────────────────────────┘
```

**关键配置：**
- 禁用 CSRF（因为不使用 Session）
- 会话策略设为 `STATELESS`（无状态）
- 禁用 Frame Options（支持 iframe 嵌入）
- Token 过滤器插入到 `UsernamePasswordAuthenticationFilter` 之前

### 4.4 方法级别鉴权

#### @PreAuthenticated（登录校验）

自定义 AOP 注解，用于标记需要用户登录的方法。与 Spring Security 的 `@PreAuthorize` 不同，该注解认证失败时返回 **401（未登录）**，更适合语义化表达。

```java
// 源码实现
@Around("@annotation(preAuthenticated)")
public Object around(ProceedingJoinPoint joinPoint, PreAuthenticated preAuthenticated) throws Throwable {
    if (SecurityFrameworkUtils.getLoginUser() == null) {
        throw exception(UNAUTHORIZED); // 401
    }
    return joinPoint.proceed();
}
```

#### @PreAuthorize（权限校验）

结合 `SecurityFrameworkService`（Bean 名称为 `"security"`，可用 `@ss` 引用）实现权限、角色、授权范围的校验：

```java
// 使用示例
@PreAuthorize("@ss.hasPermission('system:user:create')")     // 任一权限
@PreAuthorize("@ss.hasRole('admin')")                        // 任一角色
@PreAuthorize("@ss.hasScope('user.read')")                   // 任一授权范围
```

`SecurityFrameworkServiceImpl` 通过 `PermissionApi` 远程查询用户的权限和角色，而授权范围（scopes）直接从 `LoginUser` 上下文中获取。

---

## 五、核心组件详解

### 5.1 配置层

#### SecurityProperties — 安全配置属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `framework.security.token-header` | String | `Authorization` | Token 请求头名称 |
| `framework.security.mock-enable` | Boolean | `false` | Mock 模式开关（生产环境必须关闭） |
| `framework.security.mock-secret` | String | `test` | Mock 模式密钥前缀 |
| `framework.security.permit-all-urls` | List\<String\> | `[]` | 免登录 URL 白名单 |

#### SecurityAutoConfiguration — 自动配置类

负责创建安全模块所需的所有 Bean：
- `PreAuthenticatedAspect` — AOP 切面
- `AuthenticationEntryPointImpl` — 未登录处理器
- `AccessDeniedHandlerImpl` — 无权限处理器
- `BCryptPasswordEncoder` — 密码加密器
- `TokenAuthenticationFilter` — Token 认证过滤器
- `SecurityFrameworkServiceImpl` — 权限校验服务（Bean名: `"security"`）
- `TransmittableThreadLocalSecurityContextHolderStrategy` — 安全上下文策略

#### WebSecurityConfigurerAdapter — 安全过滤器链配置

核心配置类，负责构建 `SecurityFilterChain`。关键设计：
- 开启 `@EnableGlobalMethodSecurity(prePostEnabled = true)` 支持方法级注解
- 通过 `ApplicationContext` 获取 `RequestMappingHandlerMapping`，自动扫描 `@PermitAll` 注解
- 收集所有 `AuthorizeRequestsCustomizer` 实现类，支持多模块自定义规则

### 5.2 Token 认证过滤器

**类名：** `TokenAuthenticationFilter`

继承 `OncePerRequestFilter`，核心职责：

1. **Token 提取与校验** — 从请求头提取 Bearer Token，调用 `OAuth2TokenApi.checkAccessToken()` 远程验证
2. **用户类型匹配** — 校验请求头 `userType` 与 Token 中的用户类型是否一致
3. **Mock 登录** — 开发环境支持 `mockSecret + userId` 格式的模拟 Token
4. **认证信息注入** — 将 `LoginUser` 设置到 `SecurityContextHolder` 和 Request 属性中

> **设计要点：** Token 校验失败时不阻断请求，而是返回 `null` 后继续过滤器链。这样设计是为了允许同一个应用中同时存在需要登录和无需登录的接口。

### 5.3 安全上下文管理

#### TransmittableThreadLocalSecurityContextHolderStrategy

实现 `SecurityContextHolderStrategy` 接口，使用阿里巴巴开源的 **TransmittableThreadLocal (TTL)** 替代 JDK 原生 `ThreadLocal`。

**解决的问题：** 在使用 `@Async` 异步执行或线程池场景下，原生 `ThreadLocal` 无法将安全上下文传递到子线程，导致异步方法中无法获取当前登录用户。TTL 通过装饰线程池的方式解决了这一问题。

#### SecurityFrameworkUtils — 安全工具类

| 方法 | 说明 |
|------|------|
| `obtainAuthorization(request, header)` | 从请求中提取 Bearer Token |
| `getLoginUser()` | 从 SecurityContext 获取当前登录用户 |
| `getLoginUserId()` | 获取当前登录用户 ID |
| `setLoginUser(loginUser, request)` | 设置当前用户到 SecurityContext 和 Request |

### 5.4 异常处理

| 类 | 触发场景 | 返回码 | 返回信息 |
|-----|----------|--------|----------|
| `AuthenticationEntryPointImpl` | 访问需要认证的URL但未登录 | 401 | "账号未登录" |
| `AccessDeniedHandlerImpl` | 已登录但无访问权限 | 403 | "没有该操作权限" |

两个处理器均通过 `ServletUtils.writeJSON()` 返回 `CommonResult` 格式的 JSON 响应。

### 5.5 扩展点

#### AuthorizeRequestsCustomizer — 自定义 URL 授权规则

抽象类，实现了 `Customizer<ExpressionUrlAuthorizationConfigurer>` 和 `Ordered` 接口。各业务模块可继承此类，实现自己的 URL 鉴权规则：

```java
// 使用示例
@Component
public class MyModuleAuthorizeCustomizer extends AuthorizeRequestsCustomizer {
    @Override
    public void customize(ExpressionUrlAuthorizationConfigurer<HttpSecurity>.ExpressionInterceptUrlRegistry registry) {
        registry
            .antMatchers(buildAdminApi("/my-module/public/**")).permitAll()
            .antMatchers(buildAdminApi("/my-module/admin/**")).hasRole("admin");
    }
}
```

通过 `@Resource` 注入 `WebProperties`，可使用 `buildAdminApi()` 和 `buildAppApi()` 便捷方法拼接 API 前缀。

### 5.6 数据模型

#### LoginUser — 登录用户信息

```java
public class LoginUser {
    private Long id;                // 用户编号
    private Integer userType;       // 用户类型（关联 UserTypeEnum）
    private List<String> scopes;    // OAuth2.0 授权范围
    private Map<String, Object> context; // 临时上下文（不持久化，用于同请求内的临时缓存）
}
```

---

## 六、配置示例

```yaml
framework:
  security:
    # Token 请求头名称
    token-header: Authorization
    # Mock 模式（仅开发环境开启）
    mock-enable: false
    mock-secret: your-secret-key
    # 免登录 URL 白名单
    permit-all-urls:
      - /admin-api/system/captcha/**
      - /admin-api/system/login
  web:
    # App API 配置（前端接口默认免认证）
    app-api:
      prefix: /app-api
      controller: "**.controller.app.**"
    # Admin API 配置（后端接口默认需认证）
    admin-api:
      prefix: /admin-api
      controller: "**.controller.admin.**"
```

---

## 七、使用指南

### 7.1 标记接口需要登录

```java
@RestController
public class UserController {

    @PreAuthenticated
    @GetMapping("/user/info")
    public CommonResult<UserInfoVO> getUserInfo() {
        LoginUser loginUser = SecurityFrameworkUtils.getLoginUser();
        // ...
    }
}
```

### 7.2 标记接口需要特定权限

```java
@RestController
public class UserController {

    @PreAuthorize("@ss.hasPermission('system:user:delete')")
    @DeleteMapping("/user/{id}")
    public CommonResult<Boolean> deleteUser(@PathVariable Long id) {
        // ...
    }
}
```

### 7.3 自定义模块 URL 授权规则

```java
@Component
public class CustomAuthorizeRequestsCustomizer extends AuthorizeRequestsCustomizer {

    @Override
    public void customize(ExpressionUrlAuthorizationConfigurer<HttpSecurity>.ExpressionInterceptUrlRegistry registry) {
        registry
            // 公开接口
            .antMatchers(buildAdminApi("/public/**")).permitAll()
            // 需要特定角色
            .antMatchers(buildAdminApi("/admin/**")).hasRole("super_admin");
    }

    @Override
    public int getOrder() {
        return 100; // 执行顺序，数值越大越靠后
    }
}
```

### 7.4 开发环境 Mock 登录

配置 `framework.security.mock-enable = true` 后，无需真实的登录流程，直接在请求 Header 中传入：

```
Authorization: Bearer {mockSecret}{userId}
```

例如，`mockSecret` 为 `test`，模拟用户 ID 为 `1`：

```
Authorization: Bearer test1
```

---

## 八、设计亮点

| 设计点 | 说明 |
|--------|------|
| **无状态认证** | 基于 Token 的认证机制，不使用 Session，天然支持分布式部署和横向扩展 |
| **职责分离** | Token 认证（Filter）与权限校验（AOP/注解）分离，二者独立工作互不干扰 |
| **异步安全** | 使用 TTL 替代 ThreadLocal，确保异步方法和线程池场景下安全上下文不丢失 |
| **分层鉴权** | URL 级别（粗粒度）+ 方法级别（细粒度）双层鉴权，满足不同场景需求 |
| **可扩展性** | `AuthorizeRequestsCustomizer` 扩展点支持各业务模块自定义规则，`Ordered` 接口控制执行顺序 |
| **失败分离** | 未登录返回 401，无权限返回 403，语义清晰便于前端统一处理 |
| **开发友好** | Mock 模式支持本地开发免登录调试，线上强制关闭保证安全 |

---

## 九、模块结构

```
beacon-common-security/
├── pom.xml
└── src/main/
    ├── java/com/beacon/framework/security/
    │   ├── package-info.java
    │   ├── config/
    │   │   ├── AuthorizeRequestsCustomizer.java      # 自定义URL授权规则扩展点
    │   │   ├── SecurityAutoConfiguration.java        # 自动配置类
    │   │   ├── SecurityProperties.java               # 安全配置属性
    │   │   └── WebSecurityConfigurerAdapter.java     # Spring Security过滤器链配置
    │   └── core/
    │       ├── LoginUser.java                        # 登录用户数据模型
    │       ├── annotations/
    │       │   └── PreAuthenticated.java             # 登录校验注解
    │       ├── aop/
    │       │   └── PreAuthenticatedAspect.java       # 登录校验AOP切面
    │       ├── context/
    │       │   └── TransmittableThreadLocalSecurityContextHolderStrategy.java  # TTL安全上下文策略
    │       ├── filter/
    │       │   └── TokenAuthenticationFilter.java    # Token认证过滤器
    │       ├── handler/
    │       │   ├── AccessDeniedHandlerImpl.java      # 403无权限处理器
    │       │   └── AuthenticationEntryPointImpl.java # 401未登录处理器
    │       ├── service/
    │       │   ├── SecurityFrameworkService.java     # 权限校验服务接口
    │       │   └── SecurityFrameworkServiceImpl.java # 权限校验服务实现
    │       └── util/
    │           └── SecurityFrameworkUtils.java       # 安全工具类
    └── resources/META-INF/spring/
        └── org.springframework.boot.autoconfigure.AutoConfiguration.imports  # Spring自动配置注册
```
