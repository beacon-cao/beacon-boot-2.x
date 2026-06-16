# 🚀 Beacon-Boot

<div align="center">

**一个基于 Spring Boot 2.x 的企业级快速开发脚手架**

开箱即用 · 模块化设计 · 面向业务 · 安全规范

[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-2.7.8-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![JDK](https://img.shields.io/badge/JDK-1.8-blue.svg)](https://openjdk.org/)
[![Maven](https://img.shields.io/badge/Maven-3.8+-blue.svg)](https://maven.apache.org/)
[![MyBatis-Plus](https://img.shields.io/badge/MyBatis--Plus-3.5.3.1-orange.svg)](https://baomidou.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

</div>

---

## 📖 项目简介

Beacon-Boot 是一个面向企业级应用的 **Java 后端快速开发脚手架**，基于 Spring Boot 2.7.8 构建。项目采用**多模块分层架构**，内置了用户管理、权限控制、定时任务、文件存储、消息队列、操作日志、数据脱敏、验证码等常见业务场景的开箱即用解决方案。

> **设计理念**：不重复造轮子，而是将优秀的开源组件以最佳实践的方式整合，让开发者专注于业务逻辑。

---

## ✨ 核心特性

### 🏗️ 基础设施
- **多模块架构**：`commons`（通用组件）+ `business`（业务实现）+ `server`（应用入口），职责清晰
- **自动装配**：每个通用模块均基于 Spring Boot 自动配置，按需引入、即插即用
- **统一响应**：标准化的 `CommonResult<T>` 响应体，全局异常统一处理
- **代码生成**：内置 MyBatis-Plus Generator，一键生成 CRUD 代码

### 🔐 安全与权限
- **Spring Security + OAuth2**：基于 Token 的无状态认证，支持 OAuth2 认证码模式
- **RBAC 权限模型**：用户 → 角色 → 菜单/权限，支持数据权限（部门范围）
- **注解驱动鉴权**：`@PreAuthorize`、`@PermitAll`、`@PreAuthenticated` 声明式权限控制
- **开发友好**：支持 Mock 登录模式，本地开发无需真实认证

### 📊 数据访问
- **MyBatis-Plus**：强大的 CRUD 封装、分页、条件构造器
- **多数据源**：基于 `dynamic-datasource`，运行时动态切换
- **Druid 连接池**：内置 SQL 监控与防火墙
- **Redis 缓存**：Spring Cache + Redisson 分布式锁

### 📁 文件存储
- **多后端支持**：数据库 / 本地磁盘 / FTP / SFTP / S3（MinIO、阿里云 OSS 等）
- **统一的 FileClient API**：切换存储方式无需修改业务代码

### 📬 消息队列
- **Redis Pub/Sub**：适合广播场景（如缓存刷新）
- **Redis Stream**：支持消费者组，适合集群消费
- **拦截器机制**：发送/消费前后可自定义处理逻辑（日志、监控）

### ⏰ 定时任务
- **Quartz 动态调度**：可编程的 Job CRUD，支持暂停、恢复、立即触发
- **异步执行**：`@EnableAsync` + TransmittableThreadLocal 装饰器
- **执行日志**：每次任务执行自动记录日志，支持重试

### 🛡️ 防护与监控
- **XSS 防护**：基于 Jsoup 的请求过滤 + Jackson JSON 反序列化清洗
- **幂等控制**：`@Idempotent` 注解防止重复提交，支持 SpEL 表达式
- **分布式锁**：Lock4j（Redisson）分布式锁，注解声明即可
- **限流**：集成 Resilience4j RateLimiter
- **全链路追踪**：SkyWalking 探针 + OpenTracing，TraceId 全链路传递
- **Spring Boot Admin**：应用健康监控面板

### 🎨 数据脱敏
- **注解式脱敏**：`@MobileDesensitize`、`@EmailDesensitize`、`@BankCardDesensitize` 等
- **Jackson 序列化自动脱敏**：无需手动调用，JSON 输出时自动处理
- **自定义脱敏**：支持 `@RegexDesensitize`（正则）和 `@SliderDesensitize`（滑动窗口）

### 📝 操作审计
- **操作日志**：`@OperateLog` 注解自动记录操作人、参数、结果、耗时
- **API 访问日志**：自动记录每次 API 请求的详细信息
- **API 错误日志**：全局异常自动入库，便于排查

### 📋 业务内置
- **系统管理**：用户、部门、岗位、角色、菜单、字典、错误码
- **通知系统**：站内信通知模板 + 消息发送
- **社交登录**：JustAuth 集成（微信、QQ 等）
- **验证码**：AJ-Captcha 滑块/拼图验证码
- **Excel 导入导出**：EasyExcel + `@DictFormat` 字典自动转换

---

## 🧱 项目结构

```
beacon-boot-2.x
├── beacon-commons/                    # 通用组件层（15 个子模块）
│   ├── beacon-common/                 #   基础：POJO、工具类、枚举、校验
│   ├── beacon-common-web/             #   Web：全局异常、统一响应、Swagger、XSS、CORS
│   ├── beacon-common-security/        #   安全：Spring Security、Token 认证、OAuth2
│   ├── beacon-common-mybatis/         #   ORM：MyBatis-Plus、Druid、多数据源
│   ├── beacon-common-redis/           #   缓存：RedisTemplate、Spring Cache
│   ├── beacon-common-mq/              #   消息：Redis Pub/Sub + Stream
│   ├── beacon-common-schedule/        #   调度：Quartz 动态任务、异步线程池
│   ├── beacon-common-file/            #   文件：DB/Local/FTP/SFTP/S3 文件存储
│   ├── beacon-common-protection/      #   防护：幂等、分布式锁、限流
│   ├── beacon-common-desensitize/     #   脱敏：Jackson 序列化自动脱敏
│   ├── beacon-common-operatelog/      #   日志：操作日志 AOP
│   ├── beacon-common-excel/           #   Excel：EasyExcel + 字典转换
│   ├── beacon-common-dict/            #   字典：缓存式字典数据服务
│   ├── beacon-common-captcha/         #   验证码：AJ-Captcha 集成
│   └── beacon-common-monitor/         #   监控：SkyWalking、Micrometer、Admin
│
├── beacon-business/                   # 业务实现层
│   ├── beacon-business-system/        #   系统业务：用户、角色、菜单、部门、权限
│   │   ├── beacon-business-system-api/    # API 接口定义
│   │   └── beacon-business-system-biz/    # 业务逻辑实现
│   └── beacon-business-infra/         #   基础设施业务
│       ├── beacon-business-infra-api/     # API 接口定义
│       └── beacon-business-infra-biz/     # 业务逻辑实现
│           ├── config/                #     系统配置管理
│           ├── db/                    #     数据源配置管理
│           ├── file/                  #     文件上传/下载/配置
│           ├── job/                   #     定时任务管理
│           ├── logger/                #     API 访问/错误日志
│           ├── redis/                 #     Redis 监控
│           └── websocket/             #     WebSocket 通信
│
├── beacon-server/                     # 应用入口（装配层）
│   └── BeaconServerApplication.java   # @SpringBootApplication 启动类
│
├── script/                            # 脚本
│   ├── sql/                           #   数据库初始化 SQL
│   └── shell/                         #   部署 Shell 脚本
│
├── pom.xml                            # 父 POM：统一依赖与插件管理
└── README.md
```

---

## 🚀 快速开始

### 环境要求

| 组件 | 版本 |
|------|------|
| JDK | 1.8+ |
| Maven | 3.8+ |
| MySQL | 5.7+ / 8.0+ |
| Redis | 5.0+（使用 Stream 需 5.0+） |

### 1. 克隆项目

```bash
git clone https://github.com/your-org/beacon-boot.git
cd beacon-boot-2.x
```

### 2. 初始化数据库

执行 `script/sql/` 目录下的 SQL 脚本，创建数据库和表结构：

```sql
-- 创建数据库
CREATE DATABASE IF NOT EXISTS beacon_boot DEFAULT CHARSET utf8mb4;

-- 导入表结构（按顺序执行 script/sql/ 下的 SQL 文件）
```

### 3. 配置应用

在 `beacon-server/src/main/resources/` 下创建 `application-local.yaml`：

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/beacon_boot?useSSL=false&serverTimezone=Asia/Shanghai
    username: root
    password: your_password
  redis:
    host: localhost
    port: 6379
    password:           # 留空表示无密码

framework:
  security:
    mock-enable: true   # 开发环境开启 Mock 登录
    mock-secret: test   # Mock 密钥
```

### 4. 启动应用

```bash
# 方法一：Maven 命令
cd beacon-server
mvn spring-boot:run

# 方法二：IDE 运行
# 直接运行 beacon-server 模块下的 BeaconServerApplication.main()
```

### 5. 访问

| 地址 | 说明 |
|------|------|
| `http://localhost:8080` | 应用主页 |
| `http://localhost:8080/swagger-ui/index.html` | Swagger API 文档 |
| `http://localhost:8080/doc.html` | Knife4j 增强文档 |
| `http://localhost:8080/druid/` | Druid 监控面板 |

> Mock 登录模式下，设置 Authorization 请求头为 `Bearer test{userId}` 即可模拟任意用户登录。例如：`Bearer test1` 模拟 userId=1 的管理员。

---

## ⚙️ 核心配置说明

```yaml
framework:
  # Web 配置
  web:
    admin-api:
      prefix: /admin-api      # 管理后台 API 前缀
    app-api:
      prefix: /app-api        # 移动端/App API 前缀

  # 安全配置
  security:
    token-header: Authorization   # Token 请求头名称
    mock-enable: false            # Mock 登录开关（生产实例必须关闭）
    mock-secret: test             # Mock 密钥
    permit-all-urls:              # 免登录 URL 白名单
      - /swagger-ui/**
      - /druid/**

  # Swagger 配置
  swagger:
    title: Beacon-Boot API
    description: Beacon-Boot 快速开发脚手架接口文档
    version: 1.0.0
    author: Beacon
    email: admin@example.com

  # XSS 防护
  xss:
    enable: true
    exclude-urls:
      - /admin-api/notify/template/*

  # 访问日志
  access-log:
    enable: true

  # 演示模式（限制写操作）
  demo: false

  # Jackson 配置
  jackson:
    time-zone: Asia/Shanghai
    date-format: yyyy-MM-dd HH:mm:ss
```

---

## 🧩 模块使用指南

### 按需引入

Beacon-Boot 所有通用模块均基于 Spring Boot 自动配置，**不需要手动 `@ComponentScan`**。你只需在 Maven 中引入对应的依赖即可自动激活：

```xml
<!-- 按需引入：仅引入你需要的模块 -->
<dependency>
    <groupId>com.beacon.boot</groupId>
    <artifactId>beacon-common-security</artifactId>
    <!-- 其他通用模块同理 -->
</dependency>
```

### 自定义业务安全规则

在你的业务模块中，继承 `AuthorizeRequestsCustomizer` 即可注册模块专属的 URL 放行规则：

```java
@Component
public class YourSecurityConfiguration extends AuthorizeRequestsCustomizer {
    @Override
    public void customize(ExpressionUrlInterceptRegistry registry) {
        registry.antMatchers(buildAdminApi("/your-open-api/**")).permitAll();
    }
}
```

### 添加新的文件存储后端

实现 `FileClient` 接口并注册到 `FileClientFactory`，即可扩展自定义存储方式。

### 自定义幂等 Key

```java
@Idempotent(
    timeout = 3,
    timeUnit = TimeUnit.SECONDS,
    keyArg = "#order.orderNo",          // SpEL 表达式
    keyResolver = ExpressionIdempotentKeyResolver.class
)
public CommonResult<Long> createOrder(OrderCreateReqVO order) {
    // ...
}
```

---

## 🛠️ 技术选型

| 领域 | 技术栈 |
|------|--------|
| 核心框架 | Spring Boot 2.7.8、Spring Framework 5.3.x |
| 安全认证 | Spring Security、OAuth2 |
| ORM | MyBatis-Plus 3.5.3.1 |
| 数据库连接池 | Druid 1.2.15 |
| 多数据源 | dynamic-datasource 3.6.1 |
| 缓存 | Redis + Redisson 3.18.0 |
| 定时任务 | Quartz Scheduler |
| 消息队列 | Redis Pub/Sub + Redis Stream |
| API 文档 | SpringDoc 1.6.14 + Knife4j 4.0.0 |
| 文件存储 | DB / Local / FTP / SFTP / S3 |
| 分布式锁 | Lock4j 2.2.3（基于 Redisson） |
| 限流降级 | Resilience4j 1.7.1 |
| 链路追踪 | Apache SkyWalking 8.12.0 |
| 监控 | Spring Boot Admin 2.7.10 + Micrometer |
| 对象映射 | MapStruct 1.5.3 |
| JSON | Jackson + FastJSON 1.2.83 |
| Excel | EasyExcel 3.2.0 |
| 工具库 | Hutool 5.8.16、Guava 31.1 |
| 验证码 | AJ-Captcha（点击/滑块） |
| 构建工具 | Maven 3.8+ |

---

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request！

1. Fork 本项目
2. 创建特性分支：`git checkout -b feature/amazing-feature`
3. 提交代码：`git commit -m 'feat: add amazing feature'`
4. 推送分支：`git push origin feature/amazing-feature`
5. 提交 Pull Request

### Commit 规范

推荐使用约定式提交：
- `feat:` 新功能
- `fix:` Bug 修复
- `docs:` 文档更新
- `refactor:` 代码重构
- `perf:` 性能优化
- `test:` 测试相关
- `chore:` 构建/工具链

---

## 📄 开源协议

本项目基于 [MIT License](LICENSE) 开源。

---

## 🙏 致谢

Beacon-Boot 站在以下优秀开源项目的肩膀上：

- [Spring Boot](https://spring.io/projects/spring-boot) — 新一代 Java 开发范式
- [MyBatis-Plus](https://baomidou.com/) — 为简化开发而生
- [Druid](https://github.com/alibaba/druid) — 最好的数据库连接池
- [Redisson](https://redisson.org/) — Redis 分布式服务框架
- [EasyExcel](https://easyexcel.opensource.alibaba.com/) — 简单高效的 Excel 处理
- [Hutool](https://hutool.cn/) — Java 工具类库
- [Knife4j](https://doc.xiaominfo.com/) — Swagger 增强方案
- [AJ-Captcha](https://gitee.com/anji-plus/captcha) — 行为验证码
- [Lock4j](https://gitee.com/baomidou/lock4j) — 分布式锁
- 以及其他所有贡献的开源社区

---

<div align="center">

**⭐ 如果对你有帮助，请给一个 Star！**

</div>
