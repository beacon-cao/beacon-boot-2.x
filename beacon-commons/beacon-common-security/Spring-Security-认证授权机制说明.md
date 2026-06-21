# Spring Security 认证授权机制说明

本文档梳理了本项目中 Spring Security 的工作原理，帮助阅读源码的开发者快速理解整体设计。

---

## 一、整体架构概览

本项目采用 **基于 Token 的无状态认证架构**，Spring Security 在其中扮演"框架实现者"的角色：

- **OAuth 2.0** 是协议标准（规定了 Token 的颁发和验证流程）
- **Spring Security** 是框架（提供了过滤器链机制来实现该协议）

本项目同时扮演 OAuth 2.0 中的两个角色：
- **授权服务器**：登录时颁发 Token（`OAuth2AccessTokenService`）
- **资源服务器**：请求时验证 Token（`TokenAuthenticationFilter`）

---

## 二、过滤器链执行流程

Spring Security 的核心设计是一套**有序的过滤器链**，每个 Filter 各司其职。本项目涉及的核心流程如下：

```
请求进入
  │
  ▼
TokenAuthenticationFilter              → 解析 Token，建立 SecurityContext（只解析不拦截）
  │
  ▼
UsernamePasswordAuthenticationFilter   → 只处理登录请求（POST /login），其他请求跳过
  │
  ▼
FilterSecurityInterceptor（默认自动添加）→ 第一层：URL 权限校验（authorizeRequests 规则）
  │
  ▼
MethodSecurityInterceptor（AOP）        → 第二层：@PreAuthorize 方法权限校验（需显式开启）
  │
  ▼
Controller 方法执行
```

### 各组件职责说明

| 组件 | 职责 | 是否会拒绝请求 |
|---|---|---|
| `TokenAuthenticationFilter` | 从请求头解析 Token，验证有效性，将用户信息放入 `SecurityContext` | 否，只解析不拦截 |
| `UsernamePasswordAuthenticationFilter` | 处理表单登录请求 | 仅登录请求时可能拒绝 |
| `FilterSecurityInterceptor` | 读取 `authorizeRequests()` 规则，校验当前用户是否有权访问该 URL | 是，真正的守门人 |
| `MethodSecurityInterceptor` | 读取 `@PreAuthorize` 等注解，校验当前用户是否有权调用该方法 | 是，方法级权限校验 |

---

## 三、核心类说明

### 3.1 安全配置类

**文件**：`beacon-common-security/.../config/WebSecurityConfigurerAdapter.java`

```java
@AutoConfiguration
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class WebSecurityConfigurerAdapter {
    // ...
}
```

关键配置说明：

| 配置项 | 作用 |
|---|---|
| `.cors()` | 开启跨域支持 |
| `.csrf().disable()` | 关闭 CSRF，无状态 Token 架构不需要 |
| `.sessionCreationPolicy(STATELESS)` | 不使用 Session，每次请求靠 Token 认证 |
| `.authorizeRequests()` | 配置 URL 权限规则，触发 `FilterSecurityInterceptor` 自动生效 |
| `@EnableGlobalMethodSecurity(prePostEnabled = true)` | 开启 `@PreAuthorize` 等方法级权限注解 |
| `addFilterBefore(authenticationTokenFilter, UsernamePasswordAuthenticationFilter.class)` | 将 Token 过滤器插入到登录过滤器之前 |

> **注意**：`addFilterBefore` 声明的是过滤器的相对位置关系，调用时机不影响最终构建结果，真正的过滤器链在 `httpSecurity.build()` 时才完成构建。

### 3.2 Token 认证过滤器

**文件**：`beacon-common-security/.../core/filter/TokenAuthenticationFilter.java`

核心逻辑：
1. 从请求头中获取 Token
2. 调用 `oauth2TokenApi.checkAccessToken(token)` 验证 Token 有效性
3. 验证通过 → 构建 `LoginUser`，放入 `SecurityContext`
4. **无论成功失败，都调用 `chain.doFilter()` 继续执行后续过滤器**

> `TokenAuthenticationFilter` 从不拒绝请求，它只负责"你是谁"，不负责"你能不能进"。

---

## 四、权限校验分层机制

本项目采用**两层权限校验**的设计：

### 第一层：URL 级别（FilterSecurityInterceptor）

由 `authorizeRequests()` 配置驱动，`FilterSecurityInterceptor` 是 Spring Security 的**默认行为**，只要配置了 `authorizeRequests()` 就会自动在过滤器链末尾生效。

```java
.authorizeRequests()
    .antMatchers(...).permitAll()   // 静态资源、@PermitAll 接口等无需认证
    .anyRequest().authenticated()   // 兜底规则：其余请求必须认证
```

### 第二层：方法级别（MethodSecurityInterceptor）

由 `@EnableGlobalMethodSecurity(prePostEnabled = true)` 开启，通过 `@PreAuthorize` 注解在方法上声明权限。

```java
@PreAuthorize("@ss.hasPermission('system:config:update')")
public CommonResult<Boolean> updateConfig(...) { ... }
```

> **注意**：如果未开启 `@EnableGlobalMethodSecurity` 或 `prePostEnabled = false`，`@PreAuthorize` 注解会被**完全忽略且不报错**，导致权限校验静默失效，这是一个常见的坑。

---

## 五、Spring Security 完整过滤器链参考

Spring Security 预定义了一套标准过滤器，按固定顺序执行，本项目的使用情况如下：

| 序号 | 过滤器 | 作用 | 本项目状态 |
|---|---|---|---|
| 1 | `ChannelProcessingFilter` | 强制 HTTPS/HTTP 协议切换 | 未使用 |
| 2 | `SecurityContextPersistenceFilter` | 从 Session 加载/保存 SecurityContext | STATELESS 下实际无效 |
| 3 | `ConcurrentSessionFilter` | 并发登录控制 | 未使用 |
| 4 | `HeaderWriterFilter` | 写入安全响应头（X-Frame-Options 等） | 启用 |
| 5 | `CorsFilter` | 跨域处理 | 已开启 |
| 6 | `CsrfFilter` | CSRF 防护 | 已关闭 |
| 7 | `LogoutFilter` | 处理 /logout 请求 | 保留 |
| 8 | `TokenAuthenticationFilter` | 【自定义】Token 认证 | **核心** |
| 9 | `UsernamePasswordAuthenticationFilter` | 表单登录认证 | 保留（极少触发） |
| 10 | `BasicAuthenticationFilter` | HTTP Basic 认证 | 未使用 |
| 11 | `AnonymousAuthenticationFilter` | 放入匿名用户 | 启用 |
| 12 | `SessionManagementFilter` | Session 策略管理 | STATELESS 模式 |
| 13 | `ExceptionTranslationFilter` | 捕获认证/授权异常 | 启用 |
| 14 | `FilterSecurityInterceptor` | URL 权限校验（最后一道门） | **核心** |

开发者可根据需要通过 `.disable()` / `.enable()` 开关过滤器，也可以通过 `addFilterBefore`、`addFilterAfter`、`addFilterAt` 将自定义过滤器插入指定位置。

---

## 六、典型请求流程示例

### 场景一：带有效 Token 访问受保护接口

```
请求：GET /api/user  Header: Authorization: Bearer xxx
  │
  ▼ TokenAuthenticationFilter
  解析 Token 成功 → SecurityContext 中设置 LoginUser
  │
  ▼ FilterSecurityInterceptor
  SecurityContext 有认证信息 → anyRequest().authenticated() 通过 → 放行
  │
  ▼ Controller 执行
  返回用户信息
```

### 场景二：无 Token 访问受保护接口

```
请求：GET /api/user  无 Authorization Header
  │
  ▼ TokenAuthenticationFilter
  没有 Token → 跳过，SecurityContext 为空
  │
  ▼ FilterSecurityInterceptor
  SecurityContext 为空 → 抛出 AuthenticationException
  │
  ▼ ExceptionTranslationFilter
  捕获异常 → 调用 authenticationEntryPoint → 返回 401 未认证
```

### 场景三：访问 @PermitAll 接口

```
请求：POST /api/login
  │
  ▼ TokenAuthenticationFilter
  没有 Token → 跳过
  │
  ▼ FilterSecurityInterceptor
  URL 在 permitAll 列表中 → 直接放行
  │
  ▼ Controller 执行登录逻辑
```
