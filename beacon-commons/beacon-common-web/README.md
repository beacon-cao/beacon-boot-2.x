# beacon-common-web

Web 通用模块，提供 Web 层的通用能力，涵盖全局异常处理、API 访问日志、Jackson 序列化配置、Swagger 接口文档、XSS 防护等功能。

## 功能模块

### 1. Web 框架 (`web`)

核心 Web 自动配置，提供 Web 层的基础能力。

| 功能 | 说明 |
|------|------|
| **API 前缀** | 支持为 `app-api` 和 `admin-api` 分别配置统一的前缀，通过 `WebProperties` 配置 |
| **跨域支持** | 内置 `CorsFilter`，默认允许所有来源、请求头和方法 |
| **请求体缓存** | `CacheRequestBodyFilter` 支持请求体的重复读取 |
| **演示模式** | `DemoFilter`，通过 `framework.demo=true` 开启，用于演示环境 |
| **全局异常处理** | `GlobalExceptionHandler` 统一处理各类异常并返回 `CommonResult` |
| **全局响应处理** | `GlobalResponseBodyHandler` 拦截 `CommonResult` 返回值，配合访问日志记录 |

#### 配置属性

```yaml
framework:
  web:
    app-api:
      prefix: /app-api
      controller: "**.controller.app.**"
    admin-api:
      prefix: /admin-api
      controller: "**.controller.admin.**"
    admin-ui:
      url: http://localhost:8080
  demo: false  # 是否开启演示模式
```

#### 全局异常处理覆盖范围

- `MissingServletRequestParameterException` — 请求参数缺失
- `MethodArgumentTypeMismatchException` — 参数类型错误
- `MethodArgumentNotValidException` — 参数校验不通过
- `BindException` — 参数绑定异常
- `ConstraintViolationException` — Validator 校验异常
- `ValidationException` — 本地参数校验异常
- `NoHandlerFoundException` — 请求地址不存在
- `HttpRequestMethodNotSupportedException` — 请求方法不正确
- `RequestNotPermitted` — Resilience4j 限流
- `AccessDeniedException` — Spring Security 权限不足
- `ServiceException` — 业务异常
- `Exception` — 兜底系统异常（同时记录错误日志）

### 2. API 日志 (`apilog`)

自动记录 API 访问日志和错误日志。

| 功能 | 说明 |
|------|------|
| **访问日志** | `ApiAccessLogFilter` 拦截请求，记录每次 API 调用的访问日志 |
| **错误日志** | `GlobalExceptionHandler` 捕获异常时自动记录错误详情（异常名称、堆栈、请求参数等） |

#### 配置属性

```yaml
framework:
  access-log:
    enable: true  # 默认开启，设置为 false 可禁用访问日志
```

### 3. Jackson 序列化 (`jackson`)

自动配置 Jackson 序列化规则，解决常见的数据交互问题。

| 功能 | 说明 |
|------|------|
| **Long 精度处理** | `Long` 类型自动序列化为字符串，避免 JS 中超过 `2^53-1` 的数值精度丢失 |
| **LocalDateTime 序列化** | 统一 `LocalDateTime` 的序列化和反序列化格式 |
| **JsonUtils 初始化** | 将配置好的 `ObjectMapper` 注入到 `JsonUtils` 工具类中 |

### 4. Swagger 接口文档 (`swagger`)

基于 Springdoc OpenAPI + Knife4j 的接口文档自动配置。

| 功能 | 说明 |
|------|------|
| **OpenAPI 信息** | 自动生成 API 标题、描述、版本、作者等元信息 |
| **安全认证** | 通过请求头 `Authorization` 传递 Token |
| **API 分组** | 内置 `all` 分组，支持按模块创建独立分组 |
| **Knife4j 集成** | 集成 Knife4j 增强 UI |

#### 配置属性

```yaml
framework:
  swagger:
    title: 项目接口文档
    description: 项目接口文档描述
    author: Beacon
    version: 1.0.0
    url: https://www.example.com
    email: beacon@example.com
    license: MIT
    license-url: https://opensource.org/licenses/MIT
```

#### 创建 API 分组

```java
@Bean
public GroupedOpenApi systemGroupedOpenApi() {
    return SwaggerAutoConfiguration.buildGroupedOpenApi("system");
}
```

### 5. XSS 防护 (`xss`)

基于 Jsoup 的 XSS 攻击防护，支持请求参数和 JSON 请求体的过滤。

| 功能 | 说明 |
|------|------|
| **请求过滤** | `XssFilter` 对请求参数进行 XSS 清洗 |
| **JSON 反序列化** | `XssStringJsonDeserializer` 在 Jackson 反序列化时过滤 XSS |
| **可扩展** | 通过 `XssCleaner` 接口可自定义清洗规则，默认使用 `JsoupXssCleaner` |
| **URL 排除** | 支持配置排除不进行 XSS 过滤的 URL |

#### 配置属性

```yaml
framework:
  xss:
    enable: true       # 是否开启 XSS 过滤，默认 true
    exclude-urls:      # 排除的 URL 列表
      - /admin-api/xxx
```

## 自动装配

模块通过 `AutoConfiguration.imports` 注册了以下自动配置类，会在 Spring Boot 启动时自动加载：

| 自动配置类 | 说明 |
|-----------|------|
| `ApiLogAutoConfiguration` | API 日志自动配置 |
| `JacksonAutoConfiguration` | Jackson 序列化自动配置 |
| `Knife4jAutoConfiguration` | Knife4j UI 自动配置 |
| `SwaggerAutoConfiguration` | Swagger/OpenAPI 自动配置 |
| `WebAutoConfiguration` | Web 核心自动配置 |
| `XssAutoConfiguration` | XSS 防护自动配置 |

## 依赖关系

- **beacon-common** — 基础公共模块（`CommonResult`、`JsonUtils`、异常定义等）
- **beacon-business-infra-api** — 基础设施 API（操作日志记录接口）
- **spring-boot-starter-web** — Spring Boot Web 启动器
- **knife4j-openapi3-spring-boot-starter** — Knife4j 接口文档
- **springdoc-openapi-ui** — Springdoc OpenAPI
- **spring-security-core** — Spring Security（provided 作用域，仅异常处理使用）
- **resilience4j-ratelimiter** — 限流
- **jsoup** — XSS 清洗

## 过滤器执行顺序

过滤器按以下优先级依次执行（`WebFilterOrderEnum`）：

1. `CORS_FILTER` — 跨域处理
2. `REQUEST_BODY_CACHE_FILTER` — 请求体缓存
3. `XSS_FILTER` — XSS 过滤
4. `DEMO_FILTER` — 演示模式
5. `API_ACCESS_LOG_FILTER` — API 访问日志
