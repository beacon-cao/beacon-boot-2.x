# GlobalResponseBodyHandler 设计说明

## 概述

`GlobalResponseBodyHandler` 位于 `beacon-common-web` 模块，是一个全局响应体处理器，实现了 Spring MVC 的 `ResponseBodyAdvice` 接口。

与网上常见的自动包装返回值的做法不同，本项目的 Controller 在返回时主动自行包装 `CommonResult`，`GlobalResponseBodyHandler` 不改变返回的数据结构，仅用于记录 Controller 的返回结果，方便 `ApiAccessLogFilter` 记录访问日志。

## 核心代码解析

### supports — 过滤拦截目标

```java
@Override
public boolean supports(MethodParameter returnType, Class converterType) {
    if (returnType.getMethod() == null) {
        return false;
    }
    // 只拦截返回结果为 CommonResult 类型的方法
    return returnType.getMethod().getReturnType() == CommonResult.class;
}
```

只有 Controller 方法的返回类型是 `CommonResult` 时，才会进入 `beforeBodyWrite`，保证后续强转安全。

### beforeBodyWrite — 记录响应对象

```java
@Override
public Object beforeBodyWrite(Object body, MethodParameter returnType,
        MediaType selectedContentType, Class selectedConverterType,
        ServerHttpRequest request, ServerHttpResponse response) {
    // 将 Controller 返回的对象存入 Request Attribute
    WebFrameworkUtils.setCommonResult(
        ((ServletServerHttpRequest) request).getServletRequest(),
        (CommonResult<?>) body
    );
    // 原样返回，不修改响应体
    return body;
}
```

将 `body` 以 `"common_result"` 为 key 存入当前请求的 Attribute 中，供下游 Filter 读取。

## 为什么需要 ResponseBodyAdvice 做桥梁？

### Filter 能拿到什么？

Filter 位于 Servlet 容器层，持有 `HttpServletRequest` 和 `HttpServletResponse`，因此可以获取：

- 响应状态码（`response.getStatus()`）
- 响应头（`response.getHeader(...)`）
- 响应体的原始字节流（可通过 `ContentCachingResponseWrapper` 截获）

### Filter 拿不到什么？

Filter **拿不到 Controller 方法返回的 Java 对象本身**。Controller 的返回值由 Spring MVC 的 `DispatcherServlet` 内部处理，到达 Filter 时响应体已是序列化后的 JSON 字节流，而非结构化的 `CommonResult` 对象。

### 执行顺序与桥梁作用

```
Controller 返回 CommonResult 对象
        ↓
ResponseBodyAdvice.beforeBodyWrite()   ← body 仍是 Java 对象，存入 Request Attribute
        ↓
序列化为 JSON 写入 Response 输出流
        ↓
Filter 链继续执行（通过 WebFrameworkUtils.getCommonResult(request) 从 Attribute 读取对象）
```

若不使用此桥梁，Filter 想获取 `CommonResult` 的 `code`、`msg` 等字段，只能将响应体的 JSON 字节流读出并反序列化，存在以下问题：

1. **性能差** — 额外的 IO 操作和 JSON 解析开销
2. **实现复杂** — 需要用 `ContentCachingResponseWrapper` 包装 response，且需处理流只能读一次的限制

通过 `ResponseBodyAdvice` 在对象未序列化时暂存至 Attribute，是更优雅、更高效的方案。

## 相关类

| 类 | 位置 | 职责 |
|---|---|---|
| `GlobalResponseBodyHandler` | `beacon-common-web` | 拦截 Controller 返回值，存入 Request Attribute |
| `WebFrameworkUtils` | `beacon-common-web` | 提供 `setCommonResult` / `getCommonResult` 等 Attribute 存取工具方法 |
| `ApiAccessLogFilter` | `beacon-common-web` | 消费 Attribute 中的 `CommonResult`，记录 API 访问日志 |
| `CommonResult` | `beacon-common` | 统一响应结构体 |
