DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS` (
                                    `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `JOB_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `JOB_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `DESCRIPTION` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                    `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `IS_DURABLE` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `JOB_DATA` blob,
                                    PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
                                    KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`) USING BTREE,
                                    KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS` (
                                 `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `TRIGGER_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `JOB_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `JOB_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `DESCRIPTION` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                 `NEXT_FIRE_TIME` bigint DEFAULT NULL,
                                 `PREV_FIRE_TIME` bigint DEFAULT NULL,
                                 `PRIORITY` int DEFAULT NULL,
                                 `TRIGGER_STATE` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `START_TIME` bigint NOT NULL,
                                 `END_TIME` bigint DEFAULT NULL,
                                 `CALENDAR_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                 `MISFIRE_INSTR` smallint DEFAULT NULL,
                                 `JOB_DATA` blob,
                                 PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
                                 KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
                                 KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE,
                                 KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`) USING BTREE,
                                 KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE,
                                 KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`) USING BTREE,
                                 KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
                                 KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
                                 KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`) USING BTREE,
                                 KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`) USING BTREE,
                                 KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`) USING BTREE,
                                 KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`) USING BTREE,
                                 KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
                                 CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
                                      `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `TRIGGER_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `BLOB_DATA` blob,
                                      PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
                                      KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
                                      CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS` (
                                  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                  `CALENDAR_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                  `CALENDAR` blob NOT NULL,
                                  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
                                      `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `TRIGGER_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                      PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
                                      CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
                                       `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                       `ENTRY_ID` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                       `TRIGGER_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                       `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                       `INSTANCE_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                       `FIRED_TIME` bigint NOT NULL,
                                       `SCHED_TIME` bigint NOT NULL,
                                       `PRIORITY` int NOT NULL,
                                       `STATE` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                       `JOB_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                       `JOB_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                       `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                       `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                       PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`) USING BTREE,
                                       KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`) USING BTREE,
                                       KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`) USING BTREE,
                                       KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
                                       KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE,
                                       KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
                                       KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS` (
                              `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                              `LOCK_NAME` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                              PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `QRTZ_LOCKS` VALUES ('schedulerName','STATE_ACCESS'),('schedulerName','TRIGGER_ACCESS');

DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
                                            `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                            `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                            PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
                                        `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                        `INSTANCE_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                        `LAST_CHECKIN_TIME` bigint NOT NULL,
                                        `CHECKIN_INTERVAL` bigint NOT NULL,
                                        PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
                                        `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                        `TRIGGER_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                        `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                        `REPEAT_COUNT` bigint NOT NULL,
                                        `REPEAT_INTERVAL` bigint NOT NULL,
                                        `TIMES_TRIGGERED` bigint NOT NULL,
                                        PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
                                        CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
                                         `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                         `TRIGGER_NAME` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                         `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                         `STR_PROP_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                         `STR_PROP_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                         `STR_PROP_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                         `INT_PROP_1` int DEFAULT NULL,
                                         `INT_PROP_2` int DEFAULT NULL,
                                         `LONG_PROP_1` bigint DEFAULT NULL,
                                         `LONG_PROP_2` bigint DEFAULT NULL,
                                         `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
                                         `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
                                         `BOOL_PROP_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                         `BOOL_PROP_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                         PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
                                         CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



DROP TABLE IF EXISTS `infra_api_access_log`;
CREATE TABLE `infra_api_access_log` (
                                        `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
                                        `trace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '链路追踪编号',
                                        `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户编号',
                                        `user_type` tinyint NOT NULL DEFAULT '0' COMMENT '用户类型',
                                        `application_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
                                        `request_method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '请求方法名',
                                        `request_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '请求地址',
                                        `request_params` varchar(8000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '请求参数',
                                        `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户 IP',
                                        `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '浏览器 UA',
                                        `begin_time` datetime NOT NULL COMMENT '开始请求时间',
                                        `end_time` datetime NOT NULL COMMENT '结束请求时间',
                                        `duration` int NOT NULL COMMENT '执行时长',
                                        `result_code` int NOT NULL DEFAULT '0' COMMENT '结果码',
                                        `result_msg` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '结果提示',
                                        `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                        `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                        `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                        `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                        `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                        PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35843 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='API 访问日志表';

DROP TABLE IF EXISTS `infra_api_error_log`;
CREATE TABLE `infra_api_error_log` (
                                       `id` int NOT NULL AUTO_INCREMENT COMMENT '编号',
                                       `trace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '链路追踪编号\n     *\n     * 一般来说，通过链路追踪编号，可以将访问日志，错误日志，链路追踪日志，logger 打印日志等，结合在一起，从而进行排错。',
                                       `user_id` int NOT NULL DEFAULT '0' COMMENT '用户编号',
                                       `user_type` tinyint NOT NULL DEFAULT '0' COMMENT '用户类型',
                                       `application_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名\n     *\n     * 目前读取 spring.application.name',
                                       `request_method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求方法名',
                                       `request_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求地址',
                                       `request_params` varchar(8000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求参数',
                                       `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户 IP',
                                       `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '浏览器 UA',
                                       `exception_time` datetime NOT NULL COMMENT '异常发生时间',
                                       `exception_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '异常名\n     *\n     * {@link Throwable#getClass()} 的类全名',
                                       `exception_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常导致的消息',
                                       `exception_root_cause_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常导致的根消息',
                                       `exception_stack_trace` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常的栈轨迹',
                                       `exception_class_name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常发生的类全名\n     *\n     * {@link StackTraceElement#getClassName()}',
                                       `exception_file_name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常发生的类文件\n     *\n     * {@link StackTraceElement#getFileName()}',
                                       `exception_method_name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常发生的方法名\n     *\n     * {@link StackTraceElement#getMethodName()}',
                                       `exception_line_number` int NOT NULL COMMENT '异常发生的方法所在行\n     *\n     * {@link StackTraceElement#getLineNumber()}',
                                       `process_status` tinyint NOT NULL COMMENT '处理状态',
                                       `process_time` datetime DEFAULT NULL COMMENT '处理时间',
                                       `process_user_id` int DEFAULT '0' COMMENT '处理用户编号',
                                       `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                       `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                       `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                       `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                       `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1035 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统异常日志';

DROP TABLE IF EXISTS `infra_config`;
CREATE TABLE `infra_config` (
                                `id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
                                `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数分组',
                                `type` tinyint NOT NULL COMMENT '参数类型',
                                `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数名称',
                                `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数键名',
                                `value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数键值',
                                `visible` bit(1) NOT NULL COMMENT '是否可见',
                                `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='参数配置表';

INSERT INTO `infra_config` VALUES (1,'ui',1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue',_binary '\0','蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow','admin','2021-01-05 17:03:48','1','2023-06-26 14:18:04',_binary '\0'),(2,'biz',1,'用户管理-账号初始密码','sys.user.init-password','123456',_binary '\0','初始化密码 123456','admin','2021-01-05 17:03:48','1','2022-03-20 02:25:51',_binary '\0'),(3,'ui',1,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark',_binary '\0','深色主题theme-dark，浅色主题theme-light','admin','2021-01-05 17:03:48','','2021-01-19 03:05:21',_binary '\0'),(4,'1',2,'xxx','demo.test','10',_binary '\0','5','','2021-01-19 03:10:26','','2021-01-20 09:25:55',_binary '\0');

DROP TABLE IF EXISTS `infra_data_source_config`;
CREATE TABLE `infra_data_source_config` (
                                            `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键编号',
                                            `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数名称',
                                            `url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据源连接',
                                            `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
                                            `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
                                            `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                            `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                            `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                            `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                            `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                            PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据源配置表';

DROP TABLE IF EXISTS `infra_file`;
CREATE TABLE `infra_file` (
                              `id` bigint NOT NULL AUTO_INCREMENT COMMENT '文件编号',
                              `config_id` bigint DEFAULT NULL COMMENT '配置编号',
                              `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件名',
                              `path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件路径',
                              `url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件 URL',
                              `type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件类型',
                              `size` int NOT NULL COMMENT '文件大小',
                              `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                              `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                              `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                              `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                              `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                              PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=915 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文件表';

INSERT INTO `infra_file` VALUES (914,18,'1700099887716.jpg','2378b327a64c48f8c67ae61fa2bb3ad5f82ed4d629322276f5c8a249989001c1.jpg','http://localhost/admin-api/infra/file/18/get/2378b327a64c48f8c67ae61fa2bb3ad5f82ed4d629322276f5c8a249989001c1.jpg','image/png',408421,'1','2023-11-16 09:58:27','1','2023-11-16 09:58:27',_binary '\0');

DROP TABLE IF EXISTS `infra_file_config`;
CREATE TABLE `infra_file_config` (
                                     `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                                     `name` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置名',
                                     `storage` tinyint NOT NULL COMMENT '存储器',
                                     `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                     `master` bit(1) NOT NULL COMMENT '是否为主配置',
                                     `config` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '存储配置',
                                     `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                     `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                     `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                     `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                     `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                     PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文件配置表';

INSERT INTO `infra_file_config` VALUES (18,'database',1,NULL,_binary '','{\"@class\":\"com.beacon.framework.file.core.client.db.DBFileClientConfig\",\"domain\":\"http://localhost:7525\"}','1','2023-06-30 17:24:01','1','2023-11-16 10:01:58',_binary '\0');

DROP TABLE IF EXISTS `infra_file_content`;
CREATE TABLE `infra_file_content` (
                                      `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                                      `config_id` bigint NOT NULL COMMENT '配置编号',
                                      `path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件路径',
                                      `content` mediumblob NOT NULL COMMENT '文件内容',
                                      `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                      `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                      `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                      `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                      `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文件表';

DROP TABLE IF EXISTS `infra_job`;
CREATE TABLE `infra_job` (
                             `id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务编号',
                             `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务名称',
                             `status` tinyint NOT NULL COMMENT '任务状态',
                             `handler_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '处理器的名字',
                             `handler_param` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '处理器的参数',
                             `cron_expression` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'CRON 表达式',
                             `retry_count` int NOT NULL DEFAULT '0' COMMENT '重试次数',
                             `retry_interval` int NOT NULL DEFAULT '0' COMMENT '重试间隔',
                             `monitor_timeout` int NOT NULL DEFAULT '0' COMMENT '监控超时时间',
                             `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                             `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                             `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                             `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                             `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='定时任务表';

DROP TABLE IF EXISTS `infra_job_log`;
CREATE TABLE `infra_job_log` (
                                 `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志编号',
                                 `job_id` bigint NOT NULL COMMENT '任务编号',
                                 `handler_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '处理器的名字',
                                 `handler_param` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '处理器的参数',
                                 `execute_index` tinyint NOT NULL DEFAULT '1' COMMENT '第几次执行',
                                 `begin_time` datetime NOT NULL COMMENT '开始执行时间',
                                 `end_time` datetime DEFAULT NULL COMMENT '结束执行时间',
                                 `duration` int DEFAULT NULL COMMENT '执行时长',
                                 `status` tinyint NOT NULL COMMENT '任务状态',
                                 `result` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '结果数据',
                                 `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                 `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                 `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=60489 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='定时任务日志表';

DROP TABLE IF EXISTS `infra_test_demo`;
CREATE TABLE `infra_test_demo` (
                                   `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                                   `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名字',
                                   `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态',
                                   `type` tinyint NOT NULL COMMENT '类型',
                                   `category` tinyint NOT NULL COMMENT '分类',
                                   `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                   `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                   `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                   `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                   `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                   `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='字典类型表';

DROP TABLE IF EXISTS `system_dept`;
CREATE TABLE `system_dept` (
                               `id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
                               `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '部门名称',
                               `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父部门id',
                               `sort` int NOT NULL DEFAULT '0' COMMENT '显示顺序',
                               `leader_user_id` bigint DEFAULT NULL COMMENT '负责人',
                               `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
                               `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
                               `status` tinyint NOT NULL COMMENT '部门状态（0正常 1停用）',
                               `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                               `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                               `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                               `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='部门表';

INSERT INTO `system_dept` VALUES (100,'一级部门',0,0,1,'18888888888','xxx@beacon.com',0,'admin','2021-01-05 17:03:47','1','2026-06-29 22:50:08',_binary '\0'),(113,'二级部门',100,1,NULL,NULL,NULL,0,'1','2023-06-25 16:56:01','1','2026-06-29 22:50:15',_binary '\0');

DROP TABLE IF EXISTS `system_dict_data`;
CREATE TABLE `system_dict_data` (
                                    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
                                    `sort` int NOT NULL DEFAULT '0' COMMENT '字典排序',
                                    `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典标签',
                                    `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典键值',
                                    `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典类型',
                                    `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
                                    `color_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '颜色类型',
                                    `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'css 样式',
                                    `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                    `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1229 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='字典数据表';

INSERT INTO `system_dict_data` VALUES (1,1,'男','1','system_user_sex',0,'default','A','性别男','admin','2021-01-05 17:03:48','1','2022-03-29 00:14:39',_binary '\0'),(2,2,'女','2','system_user_sex',0,'success','','性别女','admin','2021-01-05 17:03:48','1','2023-06-25 17:06:02',_binary '\0'),(8,1,'正常','1','infra_job_status',0,'success','','正常状态','admin','2021-01-05 17:03:48','1','2022-02-16 19:33:38',_binary '\0'),(9,2,'暂停','2','infra_job_status',0,'danger','','停用状态','admin','2021-01-05 17:03:48','1','2022-02-16 19:33:45',_binary '\0'),(12,1,'系统内置','1','infra_config_type',0,'danger','','参数类型 - 系统内置','admin','2021-01-05 17:03:48','1','2022-02-16 19:06:02',_binary '\0'),(13,2,'自定义','2','infra_config_type',0,'primary','','参数类型 - 自定义','admin','2021-01-05 17:03:48','1','2022-02-16 19:06:07',_binary '\0'),(14,1,'通知','1','system_notice_type',0,'success','','通知','admin','2021-01-05 17:03:48','1','2022-02-16 13:05:57',_binary '\0'),(15,2,'公告','2','system_notice_type',0,'info','','公告','admin','2021-01-05 17:03:48','1','2022-02-16 13:06:01',_binary '\0'),(16,0,'其它','0','system_operate_type',0,'default','','其它操作','admin','2021-01-05 17:03:48','1','2022-02-16 09:32:46',_binary '\0'),(17,1,'查询','1','system_operate_type',0,'info','','查询操作','admin','2021-01-05 17:03:48','1','2022-02-16 09:33:16',_binary '\0'),(18,2,'新增','2','system_operate_type',0,'primary','','新增操作','admin','2021-01-05 17:03:48','1','2022-02-16 09:33:13',_binary '\0'),(19,3,'修改','3','system_operate_type',0,'warning','','修改操作','admin','2021-01-05 17:03:48','1','2022-02-16 09:33:22',_binary '\0'),(20,4,'删除','4','system_operate_type',0,'danger','','删除操作','admin','2021-01-05 17:03:48','1','2022-02-16 09:33:27',_binary '\0'),(22,5,'导出','5','system_operate_type',0,'default','','导出操作','admin','2021-01-05 17:03:48','1','2022-02-16 09:33:32',_binary '\0'),(23,6,'导入','6','system_operate_type',0,'default','','导入操作','admin','2021-01-05 17:03:48','1','2022-02-16 09:33:35',_binary '\0'),(27,1,'开启','0','common_status',0,'primary','','开启状态','admin','2021-01-05 17:03:48','1','2022-02-16 08:00:39',_binary '\0'),(28,2,'关闭','1','common_status',0,'info','','关闭状态','admin','2021-01-05 17:03:48','1','2022-02-16 08:00:44',_binary '\0'),(29,1,'目录','1','system_menu_type',0,'','','目录','admin','2021-01-05 17:03:48','','2022-02-01 16:43:45',_binary '\0'),(30,2,'菜单','2','system_menu_type',0,'','','菜单','admin','2021-01-05 17:03:48','','2022-02-01 16:43:41',_binary '\0'),(31,3,'按钮','3','system_menu_type',0,'','','按钮','admin','2021-01-05 17:03:48','','2022-02-01 16:43:39',_binary '\0'),(32,1,'内置','1','system_role_type',0,'danger','','内置角色','admin','2021-01-05 17:03:48','1','2022-02-16 13:02:08',_binary '\0'),(33,2,'自定义','2','system_role_type',0,'primary','','自定义角色','admin','2021-01-05 17:03:48','1','2022-02-16 13:02:12',_binary '\0'),(34,1,'全部数据权限','1','system_data_scope',0,'','','全部数据权限','admin','2021-01-05 17:03:48','','2022-02-01 16:47:17',_binary '\0'),(35,2,'指定部门数据权限','2','system_data_scope',0,'','','指定部门数据权限','admin','2021-01-05 17:03:48','','2022-02-01 16:47:18',_binary '\0'),(36,3,'本部门数据权限','3','system_data_scope',0,'','','本部门数据权限','admin','2021-01-05 17:03:48','','2022-02-01 16:47:16',_binary '\0'),(37,4,'本部门及以下数据权限','4','system_data_scope',0,'','','本部门及以下数据权限','admin','2021-01-05 17:03:48','','2022-02-01 16:47:21',_binary '\0'),(38,5,'仅本人数据权限','5','system_data_scope',0,'','','仅本人数据权限','admin','2021-01-05 17:03:48','','2022-02-01 16:47:23',_binary '\0'),(39,0,'成功','0','system_login_result',0,'success','','登陆结果 - 成功','','2021-01-18 06:17:36','1','2022-02-16 13:23:49',_binary '\0'),(40,10,'账号或密码不正确','10','system_login_result',0,'primary','','登陆结果 - 账号或密码不正确','','2021-01-18 06:17:54','1','2022-02-16 13:24:27',_binary '\0'),(41,20,'用户被禁用','20','system_login_result',0,'warning','','登陆结果 - 用户被禁用','','2021-01-18 06:17:54','1','2022-02-16 13:23:57',_binary '\0'),(42,30,'验证码不存在','30','system_login_result',0,'info','','登陆结果 - 验证码不存在','','2021-01-18 06:17:54','1','2022-02-16 13:24:07',_binary '\0'),(43,31,'验证码不正确','31','system_login_result',0,'info','','登陆结果 - 验证码不正确','','2021-01-18 06:17:54','1','2022-02-16 13:24:11',_binary '\0'),(44,100,'未知异常','100','system_login_result',0,'danger','','登陆结果 - 未知异常','','2021-01-18 06:17:54','1','2022-02-16 13:24:23',_binary '\0'),(45,1,'是','true','infra_boolean_string',0,'danger','','Boolean 是否类型 - 是','','2021-01-19 03:20:55','1','2022-03-15 23:01:45',_binary '\0'),(46,1,'否','false','infra_boolean_string',0,'info','','Boolean 是否类型 - 否','','2021-01-19 03:20:55','1','2022-03-15 23:09:45',_binary '\0'),(47,1,'永不超时','1','infra_redis_timeout_type',0,'primary','','Redis 未设置超时的情况','','2021-01-26 00:53:17','1','2022-02-16 19:03:35',_binary '\0'),(48,1,'动态超时','2','infra_redis_timeout_type',0,'info','','程序里动态传入超时时间，无法固定','','2021-01-26 00:55:00','1','2022-02-16 19:03:41',_binary '\0'),(49,3,'固定超时','3','infra_redis_timeout_type',0,'success','','Redis 设置了过期时间','','2021-01-26 00:55:26','1','2022-02-16 19:03:45',_binary '\0'),(50,1,'单表（增删改查）','1','infra_codegen_template_type',0,'','',NULL,'','2021-02-05 07:09:06','','2022-03-10 16:33:15',_binary '\0'),(51,2,'树表（增删改查）','2','infra_codegen_template_type',0,'','',NULL,'','2021-02-05 07:14:46','','2022-03-10 16:33:19',_binary '\0'),(53,0,'初始化中','0','infra_job_status',0,'primary','',NULL,'','2021-02-07 07:46:49','1','2022-02-16 19:33:29',_binary '\0'),(57,0,'运行中','0','infra_job_log_status',0,'primary','','RUNNING','','2021-02-08 10:04:24','1','2022-02-16 19:07:48',_binary '\0'),(58,1,'成功','1','infra_job_log_status',0,'success','',NULL,'','2021-02-08 10:06:57','1','2022-02-16 19:07:52',_binary '\0'),(59,2,'失败','2','infra_job_log_status',0,'warning','','失败','','2021-02-08 10:07:38','1','2022-02-16 19:07:56',_binary '\0'),(60,1,'会员','1','user_type',0,'primary','',NULL,'','2021-02-26 00:16:27','1','2022-02-16 10:22:19',_binary '\0'),(61,2,'管理员','2','user_type',0,'success','',NULL,'','2021-02-26 00:16:34','1','2022-02-16 10:22:22',_binary '\0'),(62,0,'未处理','0','infra_api_error_log_process_status',0,'primary','',NULL,'','2021-02-26 07:07:19','1','2022-02-16 20:14:17',_binary '\0'),(63,1,'已处理','1','infra_api_error_log_process_status',0,'success','',NULL,'','2021-02-26 07:07:26','1','2022-02-16 20:14:08',_binary '\0'),(64,2,'已忽略','2','infra_api_error_log_process_status',0,'danger','',NULL,'','2021-02-26 07:07:34','1','2022-02-16 20:14:14',_binary '\0'),(78,1,'自动生成','1','system_error_code_type',0,'warning','',NULL,'1','2021-04-21 00:06:48','1','2022-02-16 13:57:20',_binary '\0'),(79,2,'手动编辑','2','system_error_code_type',0,'primary','',NULL,'1','2021-04-21 00:07:14','1','2022-02-16 13:57:24',_binary '\0'),(80,100,'账号登录','100','system_login_type',0,'primary','','账号登录','1','2021-10-06 00:52:02','1','2022-02-16 13:11:34',_binary '\0'),(81,101,'社交登录','101','system_login_type',0,'info','','社交登录','1','2021-10-06 00:52:17','1','2022-02-16 13:11:40',_binary '\0'),(83,200,'主动登出','200','system_login_type',0,'primary','','主动登出','1','2021-10-06 00:52:58','1','2022-02-16 13:11:49',_binary '\0'),(85,202,'强制登出','202','system_login_type',0,'danger','','强制退出','1','2021-10-06 00:53:41','1','2022-02-16 13:11:57',_binary '\0'),(1145,1,'管理后台','1','infra_codegen_scene',0,'','','代码生成的场景枚举 - 管理后台','1','2022-02-02 13:15:06','1','2022-03-10 16:32:59',_binary '\0'),(1146,2,'用户 APP','2','infra_codegen_scene',0,'','','代码生成的场景枚举 - 用户 APP','1','2022-02-02 13:15:19','1','2022-03-10 16:33:03',_binary '\0'),(1150,1,'数据库','1','infra_file_storage',0,'default','',NULL,'1','2022-03-15 00:25:28','1','2022-03-15 00:25:28',_binary '\0'),(1151,10,'本地磁盘','10','infra_file_storage',0,'default','',NULL,'1','2022-03-15 00:25:41','1','2022-03-15 00:25:56',_binary '\0'),(1152,11,'FTP 服务器','11','infra_file_storage',0,'default','',NULL,'1','2022-03-15 00:26:06','1','2022-03-15 00:26:10',_binary '\0'),(1153,12,'SFTP 服务器','12','infra_file_storage',0,'default','',NULL,'1','2022-03-15 00:26:22','1','2022-03-15 00:26:22',_binary '\0'),(1154,20,'S3 对象存储','20','infra_file_storage',0,'default','',NULL,'1','2022-03-15 00:26:31','1','2022-03-15 00:26:45',_binary '\0'),(1155,103,'短信登录','103','system_login_type',0,'default','',NULL,'1','2022-05-09 23:57:58','1','2022-05-09 23:58:09',_binary '\0'),(1156,1,'password','password','system_oauth2_grant_type',0,'default','','密码模式','1','2022-05-12 00:22:05','1','2022-05-11 16:26:01',_binary '\0'),(1157,2,'authorization_code','authorization_code','system_oauth2_grant_type',0,'primary','','授权码模式','1','2022-05-12 00:22:59','1','2022-05-11 16:26:02',_binary '\0'),(1158,3,'implicit','implicit','system_oauth2_grant_type',0,'success','','简化模式','1','2022-05-12 00:23:40','1','2022-05-11 16:26:05',_binary '\0'),(1159,4,'client_credentials','client_credentials','system_oauth2_grant_type',0,'default','','客户端模式','1','2022-05-12 00:23:51','1','2022-05-11 16:26:08',_binary '\0'),(1160,5,'refresh_token','refresh_token','system_oauth2_grant_type',0,'info','','刷新模式','1','2022-05-12 00:24:02','1','2022-05-11 16:26:11',_binary '\0'),(1194,10,'微信小程序','10','terminal',0,'default','','终端 - 微信小程序','1','2022-12-10 10:51:11','1','2022-12-10 10:51:57',_binary '\0'),(1195,20,'H5 网页','20','terminal',0,'default','','终端 - H5 网页','1','2022-12-10 10:51:30','1','2022-12-10 10:51:59',_binary '\0'),(1196,11,'微信公众号','11','terminal',0,'default','','终端 - 微信公众号','1','2022-12-10 10:54:16','1','2022-12-10 10:52:01',_binary '\0'),(1197,31,'苹果 App','31','terminal',0,'default','','终端 - 苹果 App','1','2022-12-10 10:54:42','1','2022-12-10 10:52:18',_binary '\0'),(1198,32,'安卓 App','32','terminal',0,'default','','终端 - 安卓 App','1','2022-12-10 10:55:02','1','2022-12-10 10:59:17',_binary '\0'),(1227,1,'通知公告','1','system_notify_template_type',0,'primary','','站内信模版的类型 - 通知公告','1','2023-01-28 10:35:59','1','2023-01-28 10:35:59',_binary '\0'),(1228,2,'系统消息','2','system_notify_template_type',0,'success','','站内信模版的类型 - 系统消息','1','2023-01-28 10:36:20','1','2023-01-28 10:36:25',_binary '\0');

DROP TABLE IF EXISTS `system_dict_type`;
CREATE TABLE `system_dict_type` (
                                    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
                                    `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典名称',
                                    `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典类型',
                                    `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
                                    `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                    `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                    `deleted_time` datetime DEFAULT NULL COMMENT '删除时间',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    UNIQUE KEY `dict_type` (`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='字典类型表';

INSERT INTO `system_dict_type` VALUES (1,'用户性别','system_user_sex',0,NULL,'admin','2021-01-05 17:03:48','1','2022-05-16 20:29:32',_binary '\0',NULL),(6,'参数类型','infra_config_type',0,NULL,'admin','2021-01-05 17:03:48','','2022-02-01 16:36:54',_binary '\0',NULL),(7,'通知类型','system_notice_type',0,NULL,'admin','2021-01-05 17:03:48','','2022-02-01 16:35:26',_binary '\0',NULL),(9,'操作类型','system_operate_type',0,NULL,'admin','2021-01-05 17:03:48','1','2022-02-16 09:32:21',_binary '\0',NULL),(10,'系统状态','common_status',0,NULL,'admin','2021-01-05 17:03:48','','2022-02-01 16:21:28',_binary '\0',NULL),(11,'Boolean 是否类型','infra_boolean_string',0,'boolean 转是否','','2021-01-19 03:20:08','','2022-02-01 16:37:10',_binary '\0',NULL),(104,'登陆结果','system_login_result',0,'登陆结果','','2021-01-18 06:17:11','','2022-02-01 16:36:00',_binary '\0',NULL),(105,'Redis 超时类型','infra_redis_timeout_type',0,'RedisKeyDefine.TimeoutTypeEnum','','2021-01-26 00:52:50','','2022-02-01 16:50:29',_binary '\0',NULL),(106,'代码生成模板类型','infra_codegen_template_type',0,NULL,'','2021-02-05 07:08:06','1','2022-05-16 20:26:50',_binary '\0',NULL),(107,'定时任务状态','infra_job_status',0,NULL,'','2021-02-07 07:44:16','','2022-02-01 16:51:11',_binary '\0',NULL),(108,'定时任务日志状态','infra_job_log_status',0,NULL,'','2021-02-08 10:03:51','','2022-02-01 16:50:43',_binary '\0',NULL),(109,'用户类型','user_type',0,NULL,'','2021-02-26 00:15:51','','2021-02-26 00:15:51',_binary '\0',NULL),(110,'API 异常数据的处理状态','infra_api_error_log_process_status',0,NULL,'','2021-02-26 07:07:01','','2022-02-01 16:50:53',_binary '\0',NULL),(115,'错误码的类型','system_error_code_type',0,NULL,'1','2021-04-21 00:06:30','1','2022-02-01 16:36:49',_binary '\0',NULL),(116,'登陆日志的类型','system_login_type',0,'登陆日志的类型','1','2021-10-06 00:50:46','1','2022-02-01 16:35:56',_binary '\0',NULL),(144,'代码生成的场景枚举','infra_codegen_scene',0,'代码生成的场景枚举','1','2022-02-02 13:14:45','1','2022-03-10 16:33:46',_binary '\0',NULL),(145,'角色类型','system_role_type',0,'角色类型','1','2022-02-16 13:01:46','1','2022-02-16 13:01:46',_binary '\0',NULL),(146,'文件存储器','infra_file_storage',0,'文件存储器','1','2022-03-15 00:24:38','1','2022-03-15 00:24:38',_binary '\0',NULL),(147,'OAuth 2.0 授权类型','system_oauth2_grant_type',0,'OAuth 2.0 授权类型（模式）','1','2022-05-12 00:20:52','1','2022-05-11 16:25:49',_binary '\0',NULL),(160,'终端','terminal',0,'终端','1','2022-12-10 10:50:50','1','2022-12-10 10:53:11',_binary '\0',NULL),(167,'站内信模版的类型','system_notify_template_type',0,'站内信模版的类型','1','2023-01-28 10:35:10','1','2023-01-28 10:35:10',_binary '\0','1970-01-01 00:00:00');

DROP TABLE IF EXISTS `system_error_code`;
CREATE TABLE `system_error_code` (
                                     `id` bigint NOT NULL AUTO_INCREMENT COMMENT '错误码编号',
                                     `type` tinyint NOT NULL DEFAULT '0' COMMENT '错误码类型',
                                     `application_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
                                     `code` int NOT NULL DEFAULT '0' COMMENT '错误码编码',
                                     `message` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '错误码错误提示',
                                     `memo` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注',
                                     `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                     `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                     `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                     `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                     `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                     PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5833 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='错误码表';

DROP TABLE IF EXISTS `system_login_log`;
CREATE TABLE `system_login_log` (
                                    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
                                    `log_type` bigint NOT NULL COMMENT '日志类型',
                                    `trace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '链路追踪编号',
                                    `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户编号',
                                    `user_type` tinyint NOT NULL DEFAULT '0' COMMENT '用户类型',
                                    `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户账号',
                                    `result` tinyint NOT NULL COMMENT '登陆结果',
                                    `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户 IP',
                                    `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '浏览器 UA',
                                    `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2071607051230310403 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统访问记录';

DROP TABLE IF EXISTS `system_menu`;
CREATE TABLE `system_menu` (
                               `id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
                               `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单名称',
                               `permission` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '权限标识',
                               `type` tinyint NOT NULL COMMENT '菜单类型',
                               `sort` int NOT NULL DEFAULT '0' COMMENT '显示顺序',
                               `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父菜单ID',
                               `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '路由地址',
                               `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '#' COMMENT '菜单图标',
                               `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组件路径',
                               `component_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组件名',
                               `status` tinyint NOT NULL DEFAULT '0' COMMENT '菜单状态',
                               `visible` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否可见',
                               `keep_alive` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否缓存',
                               `always_show` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否总是显示',
                               `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                               `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                               `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                               `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2161 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜单权限表';

INSERT INTO `system_menu` VALUES (1,'系统管理','',1,10,0,'/system','system',NULL,NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(2,'基础设施','',1,20,0,'/infra','monitor',NULL,NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(100,'用户管理','system:user:list',2,1,1,'user','user','system/user/index','User',0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2023-02-10 13:50:21',_binary '\0'),(101,'角色管理','',2,2,1,'role','peoples','system/role/index',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(102,'菜单管理','',2,3,1,'menu','tree-table','system/menu/index',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2023-07-19 16:49:51',_binary '\0'),(103,'部门管理','',2,4,1,'dept','tree','system/dept/index',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(104,'岗位管理','',2,5,1,'post','post','system/post/index',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(105,'字典管理','',2,6,1,'dict','dict','system/dict/index',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(106,'配置管理','',2,6,2,'config','edit','infra/config/index',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(107,'通知公告','',2,8,1,'notice','message','system/notice/index',NULL,1,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2023-06-26 18:53:01',_binary '\0'),(108,'审计日志','',1,9,1,'log','log','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(109,'令牌管理','',2,2,1261,'token','online','system/oauth2/token/index',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-05-11 23:31:42',_binary '\0'),(110,'定时任务','',2,12,2,'job','job','infra/job/index',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(111,'MySQL 监控','',2,9,2,'druid','druid','infra/druid/index',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(112,'Java 监控','',2,11,2,'admin-server','server','infra/server/index',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(113,'Redis 监控','',2,10,2,'redis','redis','infra/redis/index',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(114,'表单构建','infra:build:list',2,2,2,'build','build','infra/build/index',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(116,'系统接口','infra:swagger:list',2,3,2,'swagger','swagger','infra/swagger/index',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(500,'操作日志','',2,1,108,'operate-log','form','system/operatelog/index',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(501,'登录日志','',2,2,108,'login-log','logininfor','system/loginlog/index',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1001,'用户查询','system:user:query',3,1,100,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1002,'用户新增','system:user:create',3,2,100,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1003,'用户修改','system:user:update',3,3,100,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1004,'用户删除','system:user:delete',3,4,100,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1005,'用户导出','system:user:export',3,5,100,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1006,'用户导入','system:user:import',3,6,100,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1007,'重置密码','system:user:update-password',3,7,100,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1008,'角色查询','system:role:query',3,1,101,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1009,'角色新增','system:role:create',3,2,101,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1010,'角色修改','system:role:update',3,3,101,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1011,'角色删除','system:role:delete',3,4,101,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1012,'角色导出','system:role:export',3,5,101,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1013,'菜单查询','system:menu:query',3,1,102,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1014,'菜单新增','system:menu:create',3,2,102,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1015,'菜单修改','system:menu:update',3,3,102,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1016,'菜单删除','system:menu:delete',3,4,102,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1017,'部门查询','system:dept:query',3,1,103,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1018,'部门新增','system:dept:create',3,2,103,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1019,'部门修改','system:dept:update',3,3,103,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1020,'部门删除','system:dept:delete',3,4,103,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1021,'岗位查询','system:post:query',3,1,104,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1022,'岗位新增','system:post:create',3,2,104,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1023,'岗位修改','system:post:update',3,3,104,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1024,'岗位删除','system:post:delete',3,4,104,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1025,'岗位导出','system:post:export',3,5,104,'','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1026,'字典查询','system:dict:query',3,1,105,'#','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1027,'字典新增','system:dict:create',3,2,105,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1028,'字典修改','system:dict:update',3,3,105,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1029,'字典删除','system:dict:delete',3,4,105,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1030,'字典导出','system:dict:export',3,5,105,'#','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1031,'配置查询','infra:config:query',3,1,106,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1032,'配置新增','infra:config:create',3,2,106,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1033,'配置修改','infra:config:update',3,3,106,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1034,'配置删除','infra:config:delete',3,4,106,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1035,'配置导出','infra:config:export',3,5,106,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1036,'公告查询','system:notice:query',3,1,107,'#','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1037,'公告新增','system:notice:create',3,2,107,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1038,'公告修改','system:notice:update',3,3,107,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1039,'公告删除','system:notice:delete',3,4,107,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-04-20 17:03:10',_binary '\0'),(1040,'操作查询','system:operate-log:query',3,1,500,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1042,'日志导出','system:operate-log:export',3,2,500,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1043,'登录查询','system:login-log:query',3,1,501,'#','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1045,'日志导出','system:login-log:export',3,3,501,'#','#','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1046,'令牌列表','system:oauth2-token:page',3,1,109,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-05-09 23:54:42',_binary '\0'),(1048,'令牌删除','system:oauth2-token:delete',3,2,109,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','1','2022-05-09 23:54:53',_binary '\0'),(1050,'任务新增','infra:job:create',3,2,110,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1051,'任务修改','infra:job:update',3,3,110,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1052,'任务删除','infra:job:delete',3,4,110,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1053,'状态修改','infra:job:update',3,5,110,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1054,'任务导出','infra:job:export',3,7,110,'','','',NULL,0,_binary '',_binary '',_binary '','admin','2021-01-05 17:03:48','','2022-04-20 17:03:10',_binary '\0'),(1063,'设置角色菜单权限','system:permission:assign-role-menu',3,6,101,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-01-06 17:53:44','','2022-04-20 17:03:10',_binary '\0'),(1064,'设置角色数据权限','system:permission:assign-role-data-scope',3,7,101,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-01-06 17:56:31','','2022-04-20 17:03:10',_binary '\0'),(1065,'设置用户角色','system:permission:assign-user-role',3,8,101,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-01-07 10:23:28','','2022-04-20 17:03:10',_binary '\0'),(1066,'获得 Redis 监控信息','infra:redis:get-monitor-info',3,1,113,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-01-26 01:02:31','','2022-04-20 17:03:10',_binary '\0'),(1067,'获得 Redis Key 列表','infra:redis:get-key-list',3,2,113,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-01-26 01:02:52','','2022-04-20 17:03:10',_binary '\0'),(1075,'任务触发','infra:job:trigger',3,8,110,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-02-07 13:03:10','','2022-04-20 17:03:10',_binary '\0'),(1076,'数据库文档','',2,4,2,'db-doc','table','infra/dbDoc/index',NULL,0,_binary '',_binary '',_binary '','','2021-02-08 01:41:47','1','2022-04-20 17:03:10',_binary '\0'),(1078,'访问日志','',2,1,1083,'api-access-log','log','infra/apiAccessLog/index',NULL,0,_binary '',_binary '',_binary '','','2021-02-26 01:32:59','1','2022-04-20 17:03:10',_binary '\0'),(1082,'日志导出','infra:api-access-log:export',3,2,1078,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-02-26 01:32:59','1','2022-04-20 17:03:10',_binary '\0'),(1083,'API 日志','',2,8,2,'log','log',NULL,NULL,0,_binary '',_binary '',_binary '','','2021-02-26 02:18:24','1','2022-04-20 17:03:10',_binary '\0'),(1084,'错误日志','infra:api-error-log:query',2,2,1083,'api-error-log','log','infra/apiErrorLog/index',NULL,0,_binary '',_binary '',_binary '','','2021-02-26 07:53:20','','2022-04-20 17:03:10',_binary '\0'),(1085,'日志处理','infra:api-error-log:update-status',3,2,1084,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-02-26 07:53:20','1','2022-04-20 17:03:10',_binary '\0'),(1086,'日志导出','infra:api-error-log:export',3,3,1084,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-02-26 07:53:20','1','2022-04-20 17:03:10',_binary '\0'),(1087,'任务查询','infra:job:query',3,1,110,'','','',NULL,0,_binary '',_binary '',_binary '','1','2021-03-10 01:26:19','1','2022-04-20 17:03:10',_binary '\0'),(1088,'日志查询','infra:api-access-log:query',3,1,1078,'','','',NULL,0,_binary '',_binary '',_binary '','1','2021-03-10 01:28:04','1','2022-04-20 17:03:10',_binary '\0'),(1089,'日志查询','infra:api-error-log:query',3,1,1084,'','','',NULL,0,_binary '',_binary '',_binary '','1','2021-03-10 01:29:09','1','2022-04-20 17:03:10',_binary '\0'),(1090,'文件列表','',2,5,1243,'file','upload','infra/file/index',NULL,0,_binary '',_binary '',_binary '','','2021-03-12 20:16:20','1','2022-04-20 17:03:10',_binary '\0'),(1091,'文件查询','infra:file:query',3,1,1090,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-03-12 20:16:20','','2022-04-20 17:03:10',_binary '\0'),(1092,'文件删除','infra:file:delete',3,4,1090,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-03-12 20:16:20','','2022-04-20 17:03:10',_binary '\0'),(1110,'错误码管理','',2,12,1,'error-code','code','system/errorCode/index',NULL,0,_binary '',_binary '',_binary '','','2021-04-13 21:46:42','1','2022-04-20 17:03:10',_binary '\0'),(1111,'错误码查询','system:error-code:query',3,1,1110,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-13 21:46:42','','2022-04-20 17:03:10',_binary '\0'),(1112,'错误码创建','system:error-code:create',3,2,1110,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-13 21:46:42','','2022-04-20 17:03:10',_binary '\0'),(1113,'错误码更新','system:error-code:update',3,3,1110,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-13 21:46:42','','2022-04-20 17:03:10',_binary '\0'),(1114,'错误码删除','system:error-code:delete',3,4,1110,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-13 21:46:42','','2022-04-20 17:03:10',_binary '\0'),(1115,'错误码导出','system:error-code:export',3,5,1110,'','','',NULL,0,_binary '',_binary '',_binary '','','2021-04-13 21:46:42','','2022-04-20 17:03:10',_binary '\0'),(1237,'文件配置','',2,0,1243,'file-config','config','infra/fileConfig/index',NULL,0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','1','2022-04-20 17:03:10',_binary '\0'),(1238,'文件配置查询','infra:file-config:query',3,1,1237,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','','2022-04-20 17:03:10',_binary '\0'),(1239,'文件配置创建','infra:file-config:create',3,2,1237,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','','2022-04-20 17:03:10',_binary '\0'),(1240,'文件配置更新','infra:file-config:update',3,3,1237,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','','2022-04-20 17:03:10',_binary '\0'),(1241,'文件配置删除','infra:file-config:delete',3,4,1237,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','','2022-04-20 17:03:10',_binary '\0'),(1242,'文件配置导出','infra:file-config:export',3,5,1237,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-03-15 14:35:28','','2022-04-20 17:03:10',_binary '\0'),(1243,'文件管理','',2,5,2,'file','download',NULL,'',0,_binary '',_binary '',_binary '','1','2022-03-16 23:47:40','1','2023-02-10 13:47:46',_binary '\0'),(1247,'敏感词管理','',2,13,1,'sensitive-word','education','system/sensitiveWord/index',NULL,0,_binary '',_binary '',_binary '','','2022-04-07 16:55:03','1','2022-04-20 17:03:10',_binary '\0'),(1248,'敏感词查询','system:sensitive-word:query',3,1,1247,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-07 16:55:03','','2022-04-20 17:03:10',_binary '\0'),(1249,'敏感词创建','system:sensitive-word:create',3,2,1247,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-07 16:55:03','','2022-04-20 17:03:10',_binary '\0'),(1250,'敏感词更新','system:sensitive-word:update',3,3,1247,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-07 16:55:03','','2022-04-20 17:03:10',_binary '\0'),(1251,'敏感词删除','system:sensitive-word:delete',3,4,1247,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-07 16:55:03','','2022-04-20 17:03:10',_binary '\0'),(1252,'敏感词导出','system:sensitive-word:export',3,5,1247,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-07 16:55:03','','2022-04-20 17:03:10',_binary '\0'),(1255,'数据源配置','',2,1,2,'data-source-config','rate','infra/dataSourceConfig/index',NULL,0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','1','2022-04-27 22:42:06',_binary '\0'),(1256,'数据源配置查询','infra:data-source-config:query',3,1,1255,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','','2022-04-27 14:37:32',_binary '\0'),(1257,'数据源配置创建','infra:data-source-config:create',3,2,1255,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','','2022-04-27 14:37:32',_binary '\0'),(1258,'数据源配置更新','infra:data-source-config:update',3,3,1255,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','','2022-04-27 14:37:32',_binary '\0'),(1259,'数据源配置删除','infra:data-source-config:delete',3,4,1255,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','','2022-04-27 14:37:32',_binary '\0'),(1260,'数据源配置导出','infra:data-source-config:export',3,5,1255,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-04-27 14:37:32','','2022-04-27 14:37:32',_binary '\0'),(1261,'OAuth 2.0','',1,14,1,'oauth2','people',NULL,NULL,0,_binary '',_binary '',_binary '','1','2022-05-09 23:38:17','1','2023-06-25 15:29:34',_binary '\0'),(1263,'应用管理','',2,0,1261,'oauth2/application','tool','system/oauth2/client/index',NULL,0,_binary '',_binary '',_binary '','','2022-05-10 16:26:33','1','2022-05-11 23:31:36',_binary '\0'),(1264,'客户端查询','system:oauth2-client:query',3,1,1263,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-05-10 16:26:33','1','2022-05-11 00:31:06',_binary '\0'),(1265,'客户端创建','system:oauth2-client:create',3,2,1263,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-05-10 16:26:33','1','2022-05-11 00:31:23',_binary '\0'),(1266,'客户端更新','system:oauth2-client:update',3,3,1263,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-05-10 16:26:33','1','2022-05-11 00:31:28',_binary '\0'),(1267,'客户端删除','system:oauth2-client:delete',3,4,1263,'','','',NULL,0,_binary '',_binary '',_binary '','','2022-05-10 16:26:33','1','2022-05-11 00:31:33',_binary '\0'),(2144,'站内信管理','',1,11,1,'notify','message',NULL,NULL,0,_binary '',_binary '',_binary '','1','2023-01-28 10:25:18','1','2023-01-28 10:25:46',_binary '\0'),(2145,'模板管理','',2,0,2144,'notify-template','education','system/notify/template/index',NULL,0,_binary '',_binary '',_binary '','','2023-01-28 02:26:42','1','2023-01-28 10:27:47',_binary '\0'),(2146,'站内信模板查询','system:notify-template:query',3,1,2145,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-28 02:26:42','','2023-01-28 02:26:42',_binary '\0'),(2147,'站内信模板创建','system:notify-template:create',3,2,2145,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-28 02:26:42','','2023-01-28 02:26:42',_binary '\0'),(2148,'站内信模板更新','system:notify-template:update',3,3,2145,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-28 02:26:42','','2023-01-28 02:26:42',_binary '\0'),(2149,'站内信模板删除','system:notify-template:delete',3,4,2145,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-28 02:26:42','','2023-01-28 02:26:42',_binary '\0'),(2150,'发送测试站内信','system:notify-template:send-notify',3,5,2145,'','','',NULL,0,_binary '',_binary '',_binary '','1','2023-01-28 10:54:43','1','2023-01-28 10:54:43',_binary '\0'),(2151,'消息记录','',2,0,2144,'notify-message','edit','system/notify/message/index',NULL,0,_binary '',_binary '',_binary '','','2023-01-28 04:28:22','1','2023-01-28 20:59:53',_binary '\0'),(2152,'站内信消息查询','system:notify-message:query',3,1,2151,'','','',NULL,0,_binary '',_binary '',_binary '','','2023-01-28 04:28:22','','2023-01-28 04:28:22',_binary '\0');

DROP TABLE IF EXISTS `system_notice`;
CREATE TABLE `system_notice` (
                                 `id` bigint NOT NULL AUTO_INCREMENT COMMENT '公告ID',
                                 `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告标题',
                                 `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告内容',
                                 `type` tinyint NOT NULL COMMENT '公告类型（1通知 2公告）',
                                 `status` tinyint NOT NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
                                 `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                 `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                 `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通知公告表';

INSERT INTO `system_notice` VALUES (5,'测试公告','<p><strong>Helloworld</strong></p>',1,0,'1','2023-06-26 18:06:46','1','2023-06-26 18:45:00',_binary '\0');

DROP TABLE IF EXISTS `system_notify_message`;
CREATE TABLE `system_notify_message` (
                                         `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
                                         `user_id` bigint NOT NULL COMMENT '用户id',
                                         `user_type` tinyint NOT NULL COMMENT '用户类型',
                                         `template_id` bigint NOT NULL COMMENT '模版编号',
                                         `template_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
                                         `template_nickname` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版发送人名称',
                                         `template_content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版内容',
                                         `template_type` int NOT NULL COMMENT '模版类型',
                                         `template_params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版参数',
                                         `read_status` bit(1) NOT NULL COMMENT '是否已读',
                                         `read_time` datetime DEFAULT NULL COMMENT '阅读时间',
                                         `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                         `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                         `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                         `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                         `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                         PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站内信消息表';

INSERT INTO `system_notify_message` VALUES (9,1,2,4,'001','张三','helloworld',2,'{}',_binary '','2023-06-26 18:40:31','1','2023-06-26 18:36:36','1','2023-06-26 18:40:31',_binary '\0');

DROP TABLE IF EXISTS `system_notify_template`;
CREATE TABLE `system_notify_template` (
                                          `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
                                          `name` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板名称',
                                          `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版编码',
                                          `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发送人名称',
                                          `content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版内容',
                                          `type` tinyint NOT NULL COMMENT '类型',
                                          `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数数组',
                                          `status` tinyint NOT NULL COMMENT '状态',
                                          `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                          `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                          `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                          `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                          `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                          `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                          PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站内信模板表';

INSERT INTO `system_notify_template` VALUES (4,'测试模板','001','张三','helloworld',2,'[]',0,NULL,'1','2023-06-26 18:36:23','1','2023-06-26 18:36:23',_binary '\0');

DROP TABLE IF EXISTS `system_oauth2_access_token`;
CREATE TABLE `system_oauth2_access_token` (
                                              `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                                              `user_id` bigint NOT NULL COMMENT '用户编号',
                                              `user_type` tinyint NOT NULL COMMENT '用户类型',
                                              `access_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '访问令牌',
                                              `refresh_token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '刷新令牌',
                                              `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
                                              `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '授权范围',
                                              `expires_time` datetime NOT NULL COMMENT '过期时间',
                                              `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                              `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                              `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                              `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                              `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                              PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2071607051599409154 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 访问令牌';

INSERT INTO `system_oauth2_access_token` VALUES (1584,1,2,'4ab0fe77876246a4a57c3597647f74e7','5dec04e06a8b4fd485b9c19044041db5','default',NULL,'2023-11-16 14:53:07',NULL,'2023-11-16 14:23:07',NULL,'2023-11-16 14:23:07',_binary '\0'),(1585,1,2,'8dbb07e4315e4d8bb1fcc7aa5ee7ad35','10390670a86d4a918d6a43f324fbbcb2','default',NULL,'2023-11-16 16:12:26',NULL,'2023-11-16 15:42:26',NULL,'2023-11-16 15:42:26',_binary '\0'),(2071607051599409153,1,2,'1e5321472c5d4b1d99f633ecae485946','ea6f9bdba584435a82dd4f1f7594bccd','default',NULL,'2026-06-29 23:19:44',NULL,'2026-06-29 22:49:44',NULL,'2026-06-29 22:49:44',_binary '\0');

DROP TABLE IF EXISTS `system_oauth2_approve`;
CREATE TABLE `system_oauth2_approve` (
                                         `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                                         `user_id` bigint NOT NULL COMMENT '用户编号',
                                         `user_type` tinyint NOT NULL COMMENT '用户类型',
                                         `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
                                         `scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '授权范围',
                                         `approved` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否接受',
                                         `expires_time` datetime NOT NULL COMMENT '过期时间',
                                         `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                         `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                         `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                         `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                         `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                         PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 批准表';

DROP TABLE IF EXISTS `system_oauth2_client`;
CREATE TABLE `system_oauth2_client` (
                                        `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                                        `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
                                        `secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端密钥',
                                        `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
                                        `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用图标',
                                        `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '应用描述',
                                        `status` tinyint NOT NULL COMMENT '状态',
                                        `access_token_validity_seconds` int NOT NULL COMMENT '访问令牌的有效期',
                                        `refresh_token_validity_seconds` int NOT NULL COMMENT '刷新令牌的有效期',
                                        `redirect_uris` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '可重定向的 URI 地址',
                                        `authorized_grant_types` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '授权类型',
                                        `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '授权范围',
                                        `auto_approve_scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自动通过的授权范围',
                                        `authorities` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '权限',
                                        `resource_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '资源',
                                        `additional_information` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附加信息',
                                        `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                        `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                        `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                        `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                        `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                        PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 客户端表';

INSERT INTO `system_oauth2_client` VALUES (1,'default','default','default','','我是描述',0,1800,43200,'[\"https://www.beacon.cn\",\"https://doc.beacon.cn\"]','[\"password\",\"authorization_code\",\"implicit\",\"refresh_token\"]','[\"user.read\",\"user.write\"]','[]','[\"user.read\",\"user.write\"]','[]','{}','1','2022-05-11 21:47:12','1','2023-07-12 17:04:20',_binary '\0');

DROP TABLE IF EXISTS `system_oauth2_code`;
CREATE TABLE `system_oauth2_code` (
                                      `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                                      `user_id` bigint NOT NULL COMMENT '用户编号',
                                      `user_type` tinyint NOT NULL COMMENT '用户类型',
                                      `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '授权码',
                                      `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
                                      `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '授权范围',
                                      `expires_time` datetime NOT NULL COMMENT '过期时间',
                                      `redirect_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '可重定向的 URI 地址',
                                      `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '状态',
                                      `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                      `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                      `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                      `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                      `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 授权码表';

DROP TABLE IF EXISTS `system_oauth2_refresh_token`;
CREATE TABLE `system_oauth2_refresh_token` (
                                               `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                                               `user_id` bigint NOT NULL COMMENT '用户编号',
                                               `refresh_token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '刷新令牌',
                                               `user_type` tinyint NOT NULL COMMENT '用户类型',
                                               `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
                                               `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '授权范围',
                                               `expires_time` datetime NOT NULL COMMENT '过期时间',
                                               `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                               `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                               `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                               `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                               `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                               PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2071607051549077506 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OAuth2 刷新令牌';

INSERT INTO `system_oauth2_refresh_token` VALUES (713,1,'5dec04e06a8b4fd485b9c19044041db5',2,'default',NULL,'2023-11-17 02:23:07',NULL,'2023-11-16 14:23:07',NULL,'2023-11-16 14:23:07',_binary '\0'),(714,1,'10390670a86d4a918d6a43f324fbbcb2',2,'default',NULL,'2023-11-17 03:42:26',NULL,'2023-11-16 15:42:26',NULL,'2023-11-16 15:42:26',_binary '\0'),(2071607051549077505,1,'ea6f9bdba584435a82dd4f1f7594bccd',2,'default',NULL,'2026-06-30 10:49:44',NULL,'2026-06-29 22:49:44',NULL,'2026-06-29 22:49:44',_binary '\0');

DROP TABLE IF EXISTS `system_operate_log`;
CREATE TABLE `system_operate_log` (
                                      `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
                                      `trace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '链路追踪编号',
                                      `user_id` bigint NOT NULL COMMENT '用户编号',
                                      `user_type` tinyint NOT NULL DEFAULT '0' COMMENT '用户类型',
                                      `module` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模块标题',
                                      `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作名',
                                      `type` bigint NOT NULL DEFAULT '0' COMMENT '操作分类',
                                      `content` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作内容',
                                      `exts` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '拓展字段',
                                      `request_method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '请求方法名',
                                      `request_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '请求地址',
                                      `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户 IP',
                                      `user_agent` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '浏览器 UA',
                                      `java_method` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Java 方法名',
                                      `java_method_args` varchar(8000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'Java 方法的参数',
                                      `start_time` datetime NOT NULL COMMENT '操作时间',
                                      `duration` int NOT NULL COMMENT '执行时长',
                                      `result_code` int NOT NULL DEFAULT '0' COMMENT '结果码',
                                      `result_msg` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '结果提示',
                                      `result_data` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '结果数据',
                                      `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                      `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                      `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                      `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                      `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2071607451769565186 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作日志记录';

DROP TABLE IF EXISTS `system_post`;
CREATE TABLE `system_post` (
                               `id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
                               `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位编码',
                               `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位名称',
                               `sort` int NOT NULL COMMENT '显示顺序',
                               `status` tinyint NOT NULL COMMENT '状态（0正常 1停用）',
                               `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                               `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                               `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                               `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                               `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='岗位信息表';

INSERT INTO `system_post` VALUES (5,'qdgcs','前端工程师',1,0,'','1','2023-06-25 17:03:24','1','2023-06-25 17:03:24',_binary '\0'),(6,'javagcs','Java工程师',2,0,NULL,'1','2023-06-25 17:03:55','1','2023-06-25 17:03:55',_binary '\0');

DROP TABLE IF EXISTS `system_role`;
CREATE TABLE `system_role` (
                               `id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
                               `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
                               `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色权限字符串',
                               `sort` int NOT NULL COMMENT '显示顺序',
                               `data_scope` tinyint NOT NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
                               `data_scope_dept_ids` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据范围(指定部门数组)',
                               `status` tinyint NOT NULL COMMENT '角色状态（0正常 1停用）',
                               `type` tinyint NOT NULL COMMENT '角色类型',
                               `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                               `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                               `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                               `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                               `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色信息表';

INSERT INTO `system_role` VALUES (1,'超级管理员','super_admin',1,1,'',0,1,'超级管理员','admin','2021-01-05 17:03:48','','2022-02-22 05:08:21',_binary '\0'),(2,'普通角色','common',2,2,'',0,1,'普通角色','admin','2021-01-05 17:03:48','','2022-02-22 05:08:20',_binary '\0');

DROP TABLE IF EXISTS `system_role_menu`;
CREATE TABLE `system_role_menu` (
                                    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增编号',
                                    `role_id` bigint NOT NULL COMMENT '角色ID',
                                    `menu_id` bigint NOT NULL COMMENT '菜单ID',
                                    `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2313 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色和菜单关联表';

INSERT INTO `system_role_menu` VALUES (263,109,1,'1','2022-02-22 00:56:14','1','2022-02-22 00:56:14',_binary '\0'),(434,2,1,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0'),(470,2,1110,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0'),(477,2,100,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0'),(478,2,101,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0'),(479,2,102,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0'),(481,2,103,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0'),(483,2,104,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0'),(485,2,105,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0'),(490,2,108,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0'),(492,2,109,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0'),(541,2,500,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0'),(543,2,501,'1','2022-02-22 13:09:12','1','2022-02-22 13:09:12',_binary '\0'),(675,2,2,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0'),(690,2,1078,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0'),(692,2,1083,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0'),(693,2,1084,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0'),(699,2,1090,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0'),(703,2,106,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0'),(704,2,110,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0'),(705,2,111,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0'),(706,2,112,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0'),(707,2,113,'1','2022-02-22 13:16:57','1','2022-02-22 13:16:57',_binary '\0'),(1489,1,1,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1490,1,2,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1495,1,1078,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1496,1,1083,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1497,1,1084,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1498,1,1090,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1503,1,1110,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1506,1,100,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1507,1,101,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1508,1,102,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1510,1,103,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1511,1,104,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1512,1,105,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1513,1,106,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1514,1,107,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1515,1,108,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1516,1,109,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1517,1,110,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1518,1,111,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1519,1,112,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1520,1,113,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1527,1,500,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1528,1,501,'1','2022-02-23 20:03:57','1','2022-02-23 20:03:57',_binary '\0'),(1578,111,1,'1','2022-03-07 21:37:58','1','2022-03-07 21:37:58',_binary '\0'),(1712,113,1024,'1','2022-05-17 10:07:10','1','2022-05-17 10:07:10',_binary '\0'),(1713,113,1025,'1','2022-05-17 10:07:10','1','2022-05-17 10:07:10',_binary '\0'),(1714,113,1,'1','2022-05-17 10:07:10','1','2022-05-17 10:07:10',_binary '\0'),(1715,113,102,'1','2022-05-17 10:07:10','1','2022-05-17 10:07:10',_binary '\0'),(1716,113,103,'1','2022-05-17 10:07:10','1','2022-05-17 10:07:10',_binary '\0'),(1717,113,104,'1','2022-05-17 10:07:10','1','2022-05-17 10:07:10',_binary '\0'),(1718,113,1013,'1','2022-05-17 10:07:10','1','2022-05-17 10:07:10',_binary '\0'),(1719,113,1014,'1','2022-05-17 10:07:10','1','2022-05-17 10:07:10',_binary '\0'),(1720,113,1015,'1','2022-05-17 10:07:10','1','2022-05-17 10:07:10',_binary '\0'),(1721,113,1016,'1','2022-05-17 10:07:10','1','2022-05-17 10:07:10',_binary '\0'),(1722,113,1017,'1','2022-05-17 10:07:10','1','2022-05-17 10:07:10',_binary '\0'),(1723,113,1018,'1','2022-05-17 10:07:10','1','2022-05-17 10:07:10',_binary '\0'),(1724,113,1019,'1','2022-05-17 10:07:10','1','2022-05-17 10:07:10',_binary '\0'),(1725,113,1020,'1','2022-05-17 10:07:10','1','2022-05-17 10:07:10',_binary '\0'),(1726,113,1021,'1','2022-05-17 10:07:10','1','2022-05-17 10:07:10',_binary '\0'),(1727,113,1022,'1','2022-05-17 10:07:10','1','2022-05-17 10:07:10',_binary '\0'),(1728,113,1023,'1','2022-05-17 10:07:10','1','2022-05-17 10:07:10',_binary '\0'),(1729,109,100,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0'),(1730,109,101,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0'),(1731,109,1063,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0'),(1732,109,1064,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0'),(1733,109,1001,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0'),(1734,109,1065,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0'),(1735,109,1002,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0'),(1736,109,1003,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0'),(1737,109,1004,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0'),(1738,109,1005,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0'),(1739,109,1006,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0'),(1740,109,1007,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0'),(1741,109,1008,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0'),(1742,109,1009,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0'),(1743,109,1010,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0'),(1744,109,1011,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0'),(1745,109,1012,'1','2022-09-21 22:08:51','1','2022-09-21 22:08:51',_binary '\0'),(1746,111,100,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0'),(1747,111,101,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0'),(1748,111,1063,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0'),(1749,111,1064,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0'),(1750,111,1001,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0'),(1751,111,1065,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0'),(1752,111,1002,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0'),(1753,111,1003,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0'),(1754,111,1004,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0'),(1755,111,1005,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0'),(1756,111,1006,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0'),(1757,111,1007,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0'),(1758,111,1008,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0'),(1759,111,1009,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0'),(1760,111,1010,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0'),(1761,111,1011,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0'),(1762,111,1012,'1','2022-09-21 22:08:52','1','2022-09-21 22:08:52',_binary '\0'),(1763,109,100,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0'),(1764,109,101,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0'),(1765,109,1063,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0'),(1766,109,1064,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0'),(1767,109,1001,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0'),(1768,109,1065,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0'),(1769,109,1002,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0'),(1770,109,1003,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0'),(1771,109,1004,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0'),(1772,109,1005,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0'),(1773,109,1006,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0'),(1774,109,1007,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0'),(1775,109,1008,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0'),(1776,109,1009,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0'),(1777,109,1010,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0'),(1778,109,1011,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0'),(1779,109,1012,'1','2022-09-21 22:08:53','1','2022-09-21 22:08:53',_binary '\0'),(1780,111,100,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0'),(1781,111,101,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0'),(1782,111,1063,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0'),(1783,111,1064,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0'),(1784,111,1001,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0'),(1785,111,1065,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0'),(1786,111,1002,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0'),(1787,111,1003,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0'),(1788,111,1004,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0'),(1789,111,1005,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0'),(1790,111,1006,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0'),(1791,111,1007,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0'),(1792,111,1008,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0'),(1793,111,1009,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0'),(1794,111,1010,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0'),(1795,111,1011,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0'),(1796,111,1012,'1','2022-09-21 22:08:54','1','2022-09-21 22:08:54',_binary '\0'),(1797,109,100,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0'),(1798,109,101,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0'),(1799,109,1063,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0'),(1800,109,1064,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0'),(1801,109,1001,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0'),(1802,109,1065,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0'),(1803,109,1002,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0'),(1804,109,1003,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0'),(1805,109,1004,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0'),(1806,109,1005,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0'),(1807,109,1006,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0'),(1808,109,1007,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0'),(1809,109,1008,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0'),(1810,109,1009,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0'),(1811,109,1010,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0'),(1812,109,1011,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0'),(1813,109,1012,'1','2022-09-21 22:08:55','1','2022-09-21 22:08:55',_binary '\0'),(1814,111,100,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0'),(1815,111,101,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0'),(1816,111,1063,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0'),(1817,111,1064,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0'),(1818,111,1001,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0'),(1819,111,1065,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0'),(1820,111,1002,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0'),(1821,111,1003,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0'),(1822,111,1004,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0'),(1823,111,1005,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0'),(1824,111,1006,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0'),(1825,111,1007,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0'),(1826,111,1008,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0'),(1827,111,1009,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0'),(1828,111,1010,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0'),(1829,111,1011,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0'),(1830,111,1012,'1','2022-09-21 22:08:56','1','2022-09-21 22:08:56',_binary '\0'),(1831,109,103,'1','2022-09-21 22:43:23','1','2022-09-21 22:43:23',_binary '\0'),(1832,109,1017,'1','2022-09-21 22:43:23','1','2022-09-21 22:43:23',_binary '\0'),(1833,109,1018,'1','2022-09-21 22:43:23','1','2022-09-21 22:43:23',_binary '\0'),(1834,109,1019,'1','2022-09-21 22:43:23','1','2022-09-21 22:43:23',_binary '\0'),(1835,109,1020,'1','2022-09-21 22:43:23','1','2022-09-21 22:43:23',_binary '\0'),(1836,111,103,'1','2022-09-21 22:43:24','1','2022-09-21 22:43:24',_binary '\0'),(1837,111,1017,'1','2022-09-21 22:43:24','1','2022-09-21 22:43:24',_binary '\0'),(1838,111,1018,'1','2022-09-21 22:43:24','1','2022-09-21 22:43:24',_binary '\0'),(1839,111,1019,'1','2022-09-21 22:43:24','1','2022-09-21 22:43:24',_binary '\0'),(1840,111,1020,'1','2022-09-21 22:43:24','1','2022-09-21 22:43:24',_binary '\0'),(1841,109,1036,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0'),(1842,109,1037,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0'),(1843,109,1038,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0'),(1844,109,1039,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0'),(1845,109,107,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0'),(1846,111,1036,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0'),(1847,111,1037,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0'),(1848,111,1038,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0'),(1849,111,1039,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0'),(1850,111,107,'1','2022-09-21 22:48:13','1','2022-09-21 22:48:13',_binary '\0'),(1851,114,1,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1852,114,1036,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1853,114,1037,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1854,114,1038,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1855,114,1039,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1856,114,100,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1857,114,101,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1858,114,1063,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1859,114,103,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1860,114,1064,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1861,114,1001,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1862,114,1065,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1863,114,1002,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1864,114,1003,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1865,114,107,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1866,114,1004,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1867,114,1005,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1868,114,1006,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1869,114,1007,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1870,114,1008,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1871,114,1009,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1872,114,1010,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1873,114,1011,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1874,114,1012,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1875,114,1017,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1876,114,1018,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1877,114,1019,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1878,114,1020,'1','2022-12-30 11:32:03','1','2022-12-30 11:32:03',_binary '\0'),(1879,115,1,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1880,115,1036,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1881,115,1037,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1882,115,1038,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1883,115,1039,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1884,115,100,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1885,115,101,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1886,115,1063,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1887,115,103,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1888,115,1064,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1889,115,1001,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1890,115,1065,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1891,115,1002,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1892,115,1003,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1893,115,107,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1894,115,1004,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1895,115,1005,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1896,115,1006,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1897,115,1007,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1898,115,1008,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1899,115,1009,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1900,115,1010,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1901,115,1011,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1902,115,1012,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1903,115,1017,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1904,115,1018,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1905,115,1019,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1906,115,1020,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(1907,116,1,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1908,116,1036,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1909,116,1037,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1910,116,1038,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1911,116,1039,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1912,116,100,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1913,116,101,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1914,116,1063,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1915,116,103,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1916,116,1064,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1917,116,1001,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1918,116,1065,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1919,116,1002,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1920,116,1003,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1921,116,107,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1922,116,1004,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1923,116,1005,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1924,116,1006,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1925,116,1007,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1926,116,1008,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1927,116,1009,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1928,116,1010,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1929,116,1011,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1930,116,1012,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1931,116,1017,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1932,116,1018,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1933,116,1019,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1934,116,1020,'1','2022-12-30 11:33:48','1','2022-12-30 11:33:48',_binary '\0'),(1963,118,1,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1964,118,1036,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1965,118,1037,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1966,118,1038,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1967,118,1039,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1968,118,100,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1969,118,101,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1970,118,1063,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1971,118,103,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1972,118,1064,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1973,118,1001,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1974,118,1065,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1975,118,1002,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1976,118,1003,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1977,118,107,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1978,118,1004,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1979,118,1005,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1980,118,1006,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1981,118,1007,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1982,118,1008,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1983,118,1009,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1984,118,1010,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1985,118,1011,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1986,118,1012,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1987,118,1017,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1988,118,1018,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1989,118,1019,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1990,118,1020,'1','2022-12-30 11:47:52','1','2022-12-30 11:47:52',_binary '\0'),(1991,2,1024,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(1992,2,1025,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(1993,2,1026,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(1994,2,1027,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(1995,2,1028,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(1996,2,1029,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(1997,2,1030,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(1998,2,1031,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(1999,2,1032,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2000,2,1033,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2001,2,1034,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2002,2,1035,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2007,2,1040,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2008,2,1042,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2009,2,1043,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2010,2,1045,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2011,2,1046,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2012,2,1048,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2013,2,1050,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2014,2,1051,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2015,2,1052,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2016,2,1053,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2017,2,1054,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2024,2,1063,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2025,2,1064,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2026,2,1065,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2027,2,1066,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2028,2,1067,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2034,2,1075,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2035,2,1076,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2036,2,1082,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2037,2,1085,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2038,2,1086,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2039,2,1087,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2040,2,1088,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2041,2,1089,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2042,2,1091,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2043,2,1092,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2056,2,1111,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2057,2,1112,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2058,2,1113,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2059,2,1114,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2060,2,1115,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2072,2,114,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2076,2,116,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2103,2,1237,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2104,2,1238,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2105,2,1239,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2106,2,1240,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2107,2,1241,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2108,2,1242,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2109,2,1243,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2110,2,1247,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2111,2,1248,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2112,2,1249,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2113,2,1250,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2114,2,1251,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2115,2,1252,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2117,2,1255,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2118,2,1256,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2119,2,1257,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2120,2,1258,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2121,2,1259,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2122,2,1260,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2123,2,1261,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2124,2,1263,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2125,2,1264,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2126,2,1265,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2127,2,1266,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2128,2,1267,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2129,2,1001,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2132,2,1004,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2133,2,1005,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2134,2,1006,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2135,2,1007,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2136,2,1008,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2137,2,1009,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2138,2,1010,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2139,2,1011,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2140,2,1012,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2141,2,1013,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2142,2,1014,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2143,2,1015,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2144,2,1016,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2145,2,1017,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2146,2,1018,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2147,2,1019,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2148,2,1020,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2149,2,1021,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2150,2,1022,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0'),(2151,2,1023,'1','2023-01-25 08:42:52','1','2023-01-25 08:42:52',_binary '\0');

DROP TABLE IF EXISTS `system_sensitive_word`;
CREATE TABLE `system_sensitive_word` (
                                         `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                                         `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '敏感词',
                                         `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
                                         `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标签数组',
                                         `status` tinyint NOT NULL COMMENT '状态',
                                         `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                         `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                         `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                         `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                         `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                         PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='敏感词';

INSERT INTO `system_sensitive_word` VALUES (1,'白痴','测试敏感词','测试',0,'1','2022-12-31 19:08:25','1','2023-06-26 14:28:36',_binary '\0');

DROP TABLE IF EXISTS `system_user_post`;
CREATE TABLE `system_user_post` (
                                    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
                                    `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户ID',
                                    `post_id` bigint NOT NULL DEFAULT '0' COMMENT '岗位ID',
                                    `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                    `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户岗位表';

INSERT INTO `system_user_post` VALUES (120,1,5,'1','2023-06-25 17:05:02','1','2023-06-25 17:05:02',_binary '\0'),(121,1,6,'1','2023-06-25 17:05:02','1','2023-06-25 17:05:02',_binary '\0');

DROP TABLE IF EXISTS `system_user_role`;
CREATE TABLE `system_user_role` (
                                    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增编号',
                                    `user_id` bigint NOT NULL COMMENT '用户ID',
                                    `role_id` bigint NOT NULL COMMENT '角色ID',
                                    `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                    `deleted` bit(1) DEFAULT b'0' COMMENT '是否删除',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户和角色关联表';

INSERT INTO `system_user_role` VALUES (1,1,1,'','2022-01-11 13:19:45','','2022-05-12 12:35:17',_binary '\0'),(2,2,2,'','2022-01-11 13:19:45','','2022-05-12 12:35:13',_binary '\0'),(23,119,114,'1','2022-12-30 11:32:04','1','2022-12-30 11:32:04',_binary '\0'),(24,120,115,'1','2022-12-30 11:33:42','1','2022-12-30 11:33:42',_binary '\0'),(25,121,116,'1','2022-12-30 11:33:49','1','2022-12-30 11:33:49',_binary '\0'),(26,122,118,'1','2022-12-30 11:47:53','1','2022-12-30 11:47:53',_binary '\0'),(28,123,2,'1','2023-06-28 16:06:24','1','2023-06-28 16:06:24',_binary '\0');

DROP TABLE IF EXISTS `system_user_session`;
CREATE TABLE `system_user_session` (
                                       `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                                       `token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '会话编号',
                                       `user_id` bigint NOT NULL COMMENT '用户编号',
                                       `user_type` tinyint NOT NULL DEFAULT '0' COMMENT '用户类型',
                                       `session_timeout` datetime NOT NULL COMMENT '会话超时时间',
                                       `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户账号',
                                       `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户 IP',
                                       `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '浏览器 UA',
                                       `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                       `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                       `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                       `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                       `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户在线 Session';

DROP TABLE IF EXISTS `system_users`;
CREATE TABLE `system_users` (
                                `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
                                `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户账号',
                                `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
                                `nickname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户昵称',
                                `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
                                `post_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '岗位编号数组',
                                `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '用户邮箱',
                                `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '手机号码',
                                `sex` tinyint DEFAULT '0' COMMENT '用户性别',
                                `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '头像地址',
                                `status` tinyint NOT NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
                                `login_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '最后登录IP',
                                `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
                                `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
                                `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
                                `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
                                PRIMARY KEY (`id`) USING BTREE,
                                UNIQUE KEY `idx_username` (`username`,`update_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息表';

INSERT INTO `system_users` VALUES (1,'admin','$2a$10$zucG3ejGtYR3usu3DJMnruRTE5yb9J8MxSjq8vyozx.x/jZrQjh0m','Admin','系统管理员',100,'[5,6]','xxx@beacon.com','18888888889',1,'',0,'0:0:0:0:0:0:0:1','2026-06-29 22:49:44','admin','2021-01-05 17:03:47','1','2026-06-29 22:50:38',_binary '\0'),(123,'common','$2a$10$rTlx73/OagZdige6VrUbtOVAZUDmQMUAob/gLcV2Y92n4UWySIqUS','Common',NULL,100,'[]','','',1,'',0,'127.0.0.1','2023-06-28 16:06:39','1','2023-06-28 16:05:30','1','2026-06-29 22:50:35',_binary '\0');

