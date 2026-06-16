CREATE TABLE dual (
);
COMMENT ON TABLE dual IS '虚拟表，用于验证数据库服务是否存在';

CREATE TABLE infra_api_access_log (
                                                    id bigint NOT NULL,
                                                    trace_id character varying(64) NOT NULL,
                                                    user_id bigint DEFAULT 0 NOT NULL,
                                                    user_type smallint DEFAULT 0 NOT NULL,
                                                    application_name character varying(50) NOT NULL,
                                                    request_method character varying(16) NOT NULL,
                                                    request_url character varying(255) NOT NULL,
                                                    request_params character varying(8000) NOT NULL,
                                                    user_ip character varying(50) NOT NULL,
                                                    user_agent character varying(512) NOT NULL,
                                                    begin_time timestamp(6) without time zone NOT NULL,
                                                    end_time timestamp(6) without time zone NOT NULL,
                                                    duration integer NOT NULL,
                                                    result_code integer NOT NULL,
                                                    result_msg character varying(512),
                                                    creator character varying(64),
                                                    create_time timestamp(6) without time zone NOT NULL,
                                                    updater character varying(64),
                                                    update_time timestamp(6) without time zone NOT NULL,
                                                    deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE infra_api_access_log IS 'API 访问日志表';


COMMENT ON COLUMN infra_api_access_log.id IS '日志主键';


COMMENT ON COLUMN infra_api_access_log.trace_id IS '链路追踪编号';


COMMENT ON COLUMN infra_api_access_log.user_id IS '用户编号';


COMMENT ON COLUMN infra_api_access_log.user_type IS '用户类型';


COMMENT ON COLUMN infra_api_access_log.application_name IS '应用名';


COMMENT ON COLUMN infra_api_access_log.request_method IS '请求方法名';


COMMENT ON COLUMN infra_api_access_log.request_url IS '请求地址';


COMMENT ON COLUMN infra_api_access_log.request_params IS '请求参数';


COMMENT ON COLUMN infra_api_access_log.user_ip IS '用户 IP';


COMMENT ON COLUMN infra_api_access_log.user_agent IS '浏览器 UA';


COMMENT ON COLUMN infra_api_access_log.begin_time IS '开始请求时间';


COMMENT ON COLUMN infra_api_access_log.end_time IS '结束请求时间';


COMMENT ON COLUMN infra_api_access_log.duration IS '执行时长';


COMMENT ON COLUMN infra_api_access_log.result_code IS '结果码';


COMMENT ON COLUMN infra_api_access_log.result_msg IS '结果提示';


COMMENT ON COLUMN infra_api_access_log.creator IS '创建者';


COMMENT ON COLUMN infra_api_access_log.create_time IS '创建时间';


COMMENT ON COLUMN infra_api_access_log.updater IS '更新者';


COMMENT ON COLUMN infra_api_access_log.update_time IS '更新时间';


COMMENT ON COLUMN infra_api_access_log.deleted IS '是否删除';


CREATE TABLE infra_api_error_log (
                                                   id integer NOT NULL,
                                                   trace_id character varying(64) NOT NULL,
                                                   user_id integer DEFAULT 0 NOT NULL,
                                                   user_type smallint DEFAULT 0 NOT NULL,
                                                   application_name character varying(50) NOT NULL,
                                                   request_method character varying(16) NOT NULL,
                                                   request_url character varying(255) NOT NULL,
                                                   request_params character varying(8000) NOT NULL,
                                                   user_ip character varying(50) NOT NULL,
                                                   user_agent character varying(512) NOT NULL,
                                                   exception_time timestamp(6) without time zone NOT NULL,
                                                   exception_name character varying(128) NOT NULL,
                                                   exception_message text NOT NULL,
                                                   exception_root_cause_message text NOT NULL,
                                                   exception_stack_trace text NOT NULL,
                                                   exception_class_name character varying(512) NOT NULL,
                                                   exception_file_name character varying(512) NOT NULL,
                                                   exception_method_name character varying(512) NOT NULL,
                                                   exception_line_number integer NOT NULL,
                                                   process_status smallint NOT NULL,
                                                   process_time timestamp(6) without time zone,
                                                   process_user_id integer,
                                                   creator character varying(64),
                                                   create_time timestamp(6) without time zone NOT NULL,
                                                   updater character varying(64),
                                                   update_time timestamp(6) without time zone NOT NULL,
                                                   deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE infra_api_error_log IS '系统异常日志';


COMMENT ON COLUMN infra_api_error_log.id IS '编号';


COMMENT ON COLUMN infra_api_error_log.trace_id IS '链路追踪编号
     *
     * 一般来说，通过链路追踪编号，可以将访问日志，错误日志，链路追踪日志，logger 打印日志等，结合在一起，从而进行排错。';


COMMENT ON COLUMN infra_api_error_log.user_id IS '用户编号';


COMMENT ON COLUMN infra_api_error_log.user_type IS '用户类型';


COMMENT ON COLUMN infra_api_error_log.application_name IS '应用名
     *
     * 目前读取 spring.application.name';


COMMENT ON COLUMN infra_api_error_log.request_method IS '请求方法名';


COMMENT ON COLUMN infra_api_error_log.request_url IS '请求地址';


COMMENT ON COLUMN infra_api_error_log.request_params IS '请求参数';


COMMENT ON COLUMN infra_api_error_log.user_ip IS '用户 IP';


COMMENT ON COLUMN infra_api_error_log.user_agent IS '浏览器 UA';


COMMENT ON COLUMN infra_api_error_log.exception_time IS '异常发生时间';


COMMENT ON COLUMN infra_api_error_log.exception_name IS '异常名
     *
     * {@link Throwable#getClass()} 的类全名';


COMMENT ON COLUMN infra_api_error_log.exception_message IS '异常导致的消息
     *
     * {@link cn.iocoder.common.framework.util.ExceptionUtil#getMessage(Throwable)}';


COMMENT ON COLUMN infra_api_error_log.exception_root_cause_message IS '异常导致的根消息
     *
     * {@link cn.iocoder.common.framework.util.ExceptionUtil#getRootCauseMessage(Throwable)}';


COMMENT ON COLUMN infra_api_error_log.exception_stack_trace IS '异常的栈轨迹
     *
     * {@link cn.iocoder.common.framework.util.ExceptionUtil#getServiceException(Exception)}';


COMMENT ON COLUMN infra_api_error_log.exception_class_name IS '异常发生的类全名
     *
     * {@link StackTraceElement#getClassName()}';


COMMENT ON COLUMN infra_api_error_log.exception_file_name IS '异常发生的类文件
     *
     * {@link StackTraceElement#getFileName()}';


COMMENT ON COLUMN infra_api_error_log.exception_method_name IS '异常发生的方法名
     *
     * {@link StackTraceElement#getMethodName()}';


COMMENT ON COLUMN infra_api_error_log.exception_line_number IS '异常发生的方法所在行
     *
     * {@link StackTraceElement#getLineNumber()}';


COMMENT ON COLUMN infra_api_error_log.process_status IS '处理状态';


COMMENT ON COLUMN infra_api_error_log.process_time IS '处理时间';


COMMENT ON COLUMN infra_api_error_log.process_user_id IS '处理用户编号';


COMMENT ON COLUMN infra_api_error_log.creator IS '创建者';


COMMENT ON COLUMN infra_api_error_log.create_time IS '创建时间';


COMMENT ON COLUMN infra_api_error_log.updater IS '更新者';


COMMENT ON COLUMN infra_api_error_log.update_time IS '更新时间';


COMMENT ON COLUMN infra_api_error_log.deleted IS '是否删除';


CREATE TABLE infra_codegen_column (
                                                    id bigint NOT NULL,
                                                    table_id bigint NOT NULL,
                                                    column_name character varying(200) NOT NULL,
                                                    data_type character varying(100) NOT NULL,
                                                    column_comment character varying(500) NOT NULL,
                                                    nullable boolean NOT NULL,
                                                    primary_key boolean NOT NULL,
                                                    auto_increment boolean NOT NULL,
                                                    ordinal_position integer NOT NULL,
                                                    java_type character varying(32) NOT NULL,
                                                    java_field character varying(64) NOT NULL,
                                                    dict_type character varying(200),
                                                    example character varying(255),
                                                    create_operation boolean NOT NULL,
                                                    update_operation boolean NOT NULL,
                                                    list_operation boolean NOT NULL,
                                                    list_operation_condition character varying(32) NOT NULL,
                                                    list_operation_result boolean NOT NULL,
                                                    html_type character varying(32) NOT NULL,
                                                    creator character varying(64),
                                                    create_time timestamp(6) without time zone NOT NULL,
                                                    updater character varying(64),
                                                    update_time timestamp(6) without time zone NOT NULL,
                                                    deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE infra_codegen_column IS '代码生成表字段定义';


COMMENT ON COLUMN infra_codegen_column.id IS '编号';


COMMENT ON COLUMN infra_codegen_column.table_id IS '表编号';


COMMENT ON COLUMN infra_codegen_column.column_name IS '字段名';


COMMENT ON COLUMN infra_codegen_column.data_type IS '字段类型';


COMMENT ON COLUMN infra_codegen_column.column_comment IS '字段描述';


COMMENT ON COLUMN infra_codegen_column.nullable IS '是否允许为空';


COMMENT ON COLUMN infra_codegen_column.primary_key IS '是否主键';


COMMENT ON COLUMN infra_codegen_column.auto_increment IS '是否自增';


COMMENT ON COLUMN infra_codegen_column.ordinal_position IS '排序';


COMMENT ON COLUMN infra_codegen_column.java_type IS 'Java 属性类型';


COMMENT ON COLUMN infra_codegen_column.java_field IS 'Java 属性名';


COMMENT ON COLUMN infra_codegen_column.dict_type IS '字典类型';


COMMENT ON COLUMN infra_codegen_column.example IS '数据示例';


COMMENT ON COLUMN infra_codegen_column.create_operation IS '是否为 Create 创建操作的字段';


COMMENT ON COLUMN infra_codegen_column.update_operation IS '是否为 Update 更新操作的字段';


COMMENT ON COLUMN infra_codegen_column.list_operation IS '是否为 List 查询操作的字段';


COMMENT ON COLUMN infra_codegen_column.list_operation_condition IS 'List 查询操作的条件类型';


COMMENT ON COLUMN infra_codegen_column.list_operation_result IS '是否为 List 查询操作的返回字段';


COMMENT ON COLUMN infra_codegen_column.html_type IS '显示类型';


COMMENT ON COLUMN infra_codegen_column.creator IS '创建者';


COMMENT ON COLUMN infra_codegen_column.create_time IS '创建时间';


COMMENT ON COLUMN infra_codegen_column.updater IS '更新者';


COMMENT ON COLUMN infra_codegen_column.update_time IS '更新时间';


COMMENT ON COLUMN infra_codegen_column.deleted IS '是否删除';


CREATE TABLE infra_codegen_table (
                                                   id bigint NOT NULL,
                                                   data_source_config_id bigint NOT NULL,
                                                   scene smallint NOT NULL,
                                                   table_name character varying(200) NOT NULL,
                                                   table_comment character varying(500) NOT NULL,
                                                   remark character varying(500),
                                                   module_name character varying(30) NOT NULL,
                                                   business_name character varying(30) NOT NULL,
                                                   class_name character varying(100) NOT NULL,
                                                   class_comment character varying(50) NOT NULL,
                                                   author character varying(50) NOT NULL,
                                                   template_type smallint NOT NULL,
                                                   parent_menu_id bigint,
                                                   creator character varying(64),
                                                   create_time timestamp(6) without time zone NOT NULL,
                                                   updater character varying(64),
                                                   update_time timestamp(6) without time zone NOT NULL,
                                                   deleted smallint DEFAULT 0 NOT NULL,
                                                   front_type integer NOT NULL
);


COMMENT ON TABLE infra_codegen_table IS '代码生成表定义';


COMMENT ON COLUMN infra_codegen_table.id IS '编号';


COMMENT ON COLUMN infra_codegen_table.data_source_config_id IS '数据源配置的编号';


COMMENT ON COLUMN infra_codegen_table.scene IS '生成场景';


COMMENT ON COLUMN infra_codegen_table.table_name IS '表名称';


COMMENT ON COLUMN infra_codegen_table.table_comment IS '表描述';


COMMENT ON COLUMN infra_codegen_table.remark IS '备注';


COMMENT ON COLUMN infra_codegen_table.module_name IS '模块名';


COMMENT ON COLUMN infra_codegen_table.business_name IS '业务名';


COMMENT ON COLUMN infra_codegen_table.class_name IS '类名称';


COMMENT ON COLUMN infra_codegen_table.class_comment IS '类描述';


COMMENT ON COLUMN infra_codegen_table.author IS '作者';


COMMENT ON COLUMN infra_codegen_table.template_type IS '模板类型';


COMMENT ON COLUMN infra_codegen_table.parent_menu_id IS '父菜单编号';


COMMENT ON COLUMN infra_codegen_table.creator IS '创建者';


COMMENT ON COLUMN infra_codegen_table.create_time IS '创建时间';


COMMENT ON COLUMN infra_codegen_table.updater IS '更新者';


COMMENT ON COLUMN infra_codegen_table.update_time IS '更新时间';


COMMENT ON COLUMN infra_codegen_table.deleted IS '是否删除';


COMMENT ON COLUMN infra_codegen_table.front_type IS '前端类型';


CREATE TABLE infra_config (
                                            id integer NOT NULL,
                                            category character varying(50) NOT NULL,
                                            type smallint NOT NULL,
                                            name character varying(100) NOT NULL,
                                            config_key character varying(100) NOT NULL,
                                            value character varying(500) NOT NULL,
                                            visible character varying(5) NOT NULL,
                                            remark character varying(500),
                                            creator character varying(64),
                                            create_time timestamp(6) without time zone NOT NULL,
                                            updater character varying(64),
                                            update_time timestamp(6) without time zone NOT NULL,
                                            deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE infra_config IS '参数配置表';


COMMENT ON COLUMN infra_config.id IS '参数主键';


COMMENT ON COLUMN infra_config.category IS '参数分组';


COMMENT ON COLUMN infra_config.type IS '参数类型';


COMMENT ON COLUMN infra_config.name IS '参数名称';


COMMENT ON COLUMN infra_config.config_key IS '参数键名';


COMMENT ON COLUMN infra_config.value IS '参数键值';


COMMENT ON COLUMN infra_config.visible IS '是否可见';


COMMENT ON COLUMN infra_config.remark IS '备注';


COMMENT ON COLUMN infra_config.creator IS '创建者';


COMMENT ON COLUMN infra_config.create_time IS '创建时间';


COMMENT ON COLUMN infra_config.updater IS '更新者';


COMMENT ON COLUMN infra_config.update_time IS '更新时间';


COMMENT ON COLUMN infra_config.deleted IS '是否删除';


CREATE TABLE infra_data_source_config (
                                                        id bigint NOT NULL,
                                                        name character varying(100) NOT NULL,
                                                        url character varying(1024) NOT NULL,
                                                        username character varying(255) NOT NULL,
                                                        password character varying(255) NOT NULL,
                                                        creator character varying(64),
                                                        create_time timestamp(6) without time zone NOT NULL,
                                                        updater character varying(64),
                                                        update_time timestamp(6) without time zone NOT NULL,
                                                        deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE infra_data_source_config IS '数据源配置表';


COMMENT ON COLUMN infra_data_source_config.id IS '主键编号';


COMMENT ON COLUMN infra_data_source_config.name IS '参数名称';


COMMENT ON COLUMN infra_data_source_config.url IS '数据源连接';


COMMENT ON COLUMN infra_data_source_config.username IS '用户名';


COMMENT ON COLUMN infra_data_source_config.password IS '密码';


COMMENT ON COLUMN infra_data_source_config.creator IS '创建者';


COMMENT ON COLUMN infra_data_source_config.create_time IS '创建时间';


COMMENT ON COLUMN infra_data_source_config.updater IS '更新者';


COMMENT ON COLUMN infra_data_source_config.update_time IS '更新时间';


COMMENT ON COLUMN infra_data_source_config.deleted IS '是否删除';


CREATE TABLE infra_file (
                                          id bigint DEFAULT 0 NOT NULL,
                                          config_id bigint,
                                          path character varying(512) NOT NULL,
                                          url character varying(1024) NOT NULL,
                                          type character varying(127),
                                          size integer NOT NULL,
                                          creator character varying(64),
                                          create_time timestamp(6) without time zone NOT NULL,
                                          updater character varying(64),
                                          update_time timestamp(6) without time zone NOT NULL,
                                          deleted smallint DEFAULT 0 NOT NULL,
                                          name character varying(255)
);


COMMENT ON TABLE infra_file IS '文件表';


COMMENT ON COLUMN infra_file.id IS '文件编号';


COMMENT ON COLUMN infra_file.config_id IS '配置编号';


COMMENT ON COLUMN infra_file.path IS '文件路径';


COMMENT ON COLUMN infra_file.url IS '文件 URL';


COMMENT ON COLUMN infra_file.type IS '文件类型';


COMMENT ON COLUMN infra_file.size IS '文件大小';


COMMENT ON COLUMN infra_file.creator IS '创建者';


COMMENT ON COLUMN infra_file.create_time IS '创建时间';


COMMENT ON COLUMN infra_file.updater IS '更新者';


COMMENT ON COLUMN infra_file.update_time IS '更新时间';


COMMENT ON COLUMN infra_file.deleted IS '是否删除';


COMMENT ON COLUMN infra_file.name IS '文件名';


CREATE TABLE infra_file_config (
                                                 id bigint NOT NULL,
                                                 name character varying(63) NOT NULL,
                                                 storage smallint NOT NULL,
                                                 remark character varying(255),
                                                 master boolean NOT NULL,
                                                 config character varying(4096) NOT NULL,
                                                 creator character varying(64),
                                                 create_time timestamp(6) without time zone NOT NULL,
                                                 updater character varying(64),
                                                 update_time timestamp(6) without time zone NOT NULL,
                                                 deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE infra_file_config IS '文件配置表';


COMMENT ON COLUMN infra_file_config.id IS '编号';


COMMENT ON COLUMN infra_file_config.name IS '配置名';


COMMENT ON COLUMN infra_file_config.storage IS '存储器';


COMMENT ON COLUMN infra_file_config.remark IS '备注';


COMMENT ON COLUMN infra_file_config.master IS '是否为主配置';


COMMENT ON COLUMN infra_file_config.config IS '存储配置';


COMMENT ON COLUMN infra_file_config.creator IS '创建者';


COMMENT ON COLUMN infra_file_config.create_time IS '创建时间';


COMMENT ON COLUMN infra_file_config.updater IS '更新者';


COMMENT ON COLUMN infra_file_config.update_time IS '更新时间';


COMMENT ON COLUMN infra_file_config.deleted IS '是否删除';


CREATE TABLE infra_file_content (
                                                  id bigint NOT NULL,
                                                  config_id bigint NOT NULL,
                                                  path character varying(512) NOT NULL,
                                                  content bytea NOT NULL,
                                                  creator character varying(64),
                                                  create_time timestamp(6) without time zone NOT NULL,
                                                  updater character varying(64),
                                                  update_time timestamp(6) without time zone NOT NULL,
                                                  deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE infra_file_content IS '文件表';


COMMENT ON COLUMN infra_file_content.id IS '编号';


COMMENT ON COLUMN infra_file_content.config_id IS '配置编号';


COMMENT ON COLUMN infra_file_content.path IS '文件路径';


COMMENT ON COLUMN infra_file_content.content IS '文件内容';


COMMENT ON COLUMN infra_file_content.creator IS '创建者';


COMMENT ON COLUMN infra_file_content.create_time IS '创建时间';


COMMENT ON COLUMN infra_file_content.updater IS '更新者';


COMMENT ON COLUMN infra_file_content.update_time IS '更新时间';


COMMENT ON COLUMN infra_file_content.deleted IS '是否删除';


CREATE TABLE infra_job (
                                         id bigint NOT NULL,
                                         name character varying(32) NOT NULL,
                                         status smallint NOT NULL,
                                         handler_name character varying(64) NOT NULL,
                                         handler_param character varying(255),
                                         cron_expression character varying(32) NOT NULL,
                                         retry_count integer NOT NULL,
                                         retry_interval integer NOT NULL,
                                         monitor_timeout integer NOT NULL,
                                         creator character varying(64),
                                         create_time timestamp(6) without time zone NOT NULL,
                                         updater character varying(64),
                                         update_time timestamp(6) without time zone NOT NULL,
                                         deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE infra_job IS '定时任务表';


COMMENT ON COLUMN infra_job.id IS '任务编号';


COMMENT ON COLUMN infra_job.name IS '任务名称';


COMMENT ON COLUMN infra_job.status IS '任务状态';


COMMENT ON COLUMN infra_job.handler_name IS '处理器的名字';


COMMENT ON COLUMN infra_job.handler_param IS '处理器的参数';


COMMENT ON COLUMN infra_job.cron_expression IS 'CRON 表达式';


COMMENT ON COLUMN infra_job.retry_count IS '重试次数';


COMMENT ON COLUMN infra_job.retry_interval IS '重试间隔';


COMMENT ON COLUMN infra_job.monitor_timeout IS '监控超时时间';


COMMENT ON COLUMN infra_job.creator IS '创建者';


COMMENT ON COLUMN infra_job.create_time IS '创建时间';


COMMENT ON COLUMN infra_job.updater IS '更新者';


COMMENT ON COLUMN infra_job.update_time IS '更新时间';


COMMENT ON COLUMN infra_job.deleted IS '是否删除';


CREATE TABLE infra_job_log (
                                             id bigint NOT NULL,
                                             job_id bigint NOT NULL,
                                             handler_name character varying(64) NOT NULL,
                                             handler_param character varying(255),
                                             execute_index smallint NOT NULL,
                                             begin_time timestamp(6) without time zone NOT NULL,
                                             end_time timestamp(6) without time zone,
                                             duration integer,
                                             status smallint NOT NULL,
                                             result character varying(4000),
                                             creator character varying(64),
                                             create_time timestamp(6) without time zone NOT NULL,
                                             updater character varying(64),
                                             update_time timestamp(6) without time zone NOT NULL,
                                             deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE infra_job_log IS '定时任务日志表';


COMMENT ON COLUMN infra_job_log.id IS '日志编号';


COMMENT ON COLUMN infra_job_log.job_id IS '任务编号';


COMMENT ON COLUMN infra_job_log.handler_name IS '处理器的名字';


COMMENT ON COLUMN infra_job_log.handler_param IS '处理器的参数';


COMMENT ON COLUMN infra_job_log.execute_index IS '第几次执行';


COMMENT ON COLUMN infra_job_log.begin_time IS '开始执行时间';


COMMENT ON COLUMN infra_job_log.end_time IS '结束执行时间';


COMMENT ON COLUMN infra_job_log.duration IS '执行时长';


COMMENT ON COLUMN infra_job_log.status IS '任务状态';


COMMENT ON COLUMN infra_job_log.result IS '结果数据';


COMMENT ON COLUMN infra_job_log.creator IS '创建者';


COMMENT ON COLUMN infra_job_log.create_time IS '创建时间';


COMMENT ON COLUMN infra_job_log.updater IS '更新者';


COMMENT ON COLUMN infra_job_log.update_time IS '更新时间';


COMMENT ON COLUMN infra_job_log.deleted IS '是否删除';


CREATE TABLE infra_test_demo (
                                               id bigint NOT NULL,
                                               name character varying(100) NOT NULL,
                                               status smallint NOT NULL,
                                               type smallint NOT NULL,
                                               category smallint NOT NULL,
                                               remark character varying(500),
                                               creator character varying(64),
                                               create_time timestamp(6) without time zone NOT NULL,
                                               updater character varying(64),
                                               update_time timestamp(6) without time zone NOT NULL,
                                               deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE infra_test_demo IS '字典类型表';


COMMENT ON COLUMN infra_test_demo.id IS '编号';


COMMENT ON COLUMN infra_test_demo.name IS '名字';


COMMENT ON COLUMN infra_test_demo.status IS '状态';


COMMENT ON COLUMN infra_test_demo.type IS '类型';


COMMENT ON COLUMN infra_test_demo.category IS '分类';


COMMENT ON COLUMN infra_test_demo.remark IS '备注';


COMMENT ON COLUMN infra_test_demo.creator IS '创建者';


COMMENT ON COLUMN infra_test_demo.create_time IS '创建时间';


COMMENT ON COLUMN infra_test_demo.updater IS '更新者';


COMMENT ON COLUMN infra_test_demo.update_time IS '更新时间';


COMMENT ON COLUMN infra_test_demo.deleted IS '是否删除';


CREATE TABLE qrtz_blob_triggers (
                                                  sched_name character varying(120) NOT NULL,
                                                  trigger_name character varying(200) NOT NULL,
                                                  trigger_group character varying(200) NOT NULL,
                                                  blob_data bytea
);


COMMENT ON TABLE qrtz_blob_triggers IS 'qrtz表';


CREATE TABLE qrtz_calendars (
                                              sched_name character varying(120) NOT NULL,
                                              calendar_name character varying(200) NOT NULL,
                                              calendar bytea NOT NULL
);


COMMENT ON TABLE qrtz_calendars IS 'qrtz表';


CREATE TABLE qrtz_cron_triggers (
                                                  sched_name character varying(120) NOT NULL,
                                                  trigger_name character varying(200) NOT NULL,
                                                  trigger_group character varying(200) NOT NULL,
                                                  cron_expression character varying(120) NOT NULL,
                                                  time_zone_id character varying(80)
);


COMMENT ON TABLE qrtz_cron_triggers IS 'qrtz表';


CREATE TABLE qrtz_fired_triggers (
                                                   sched_name character varying(120) NOT NULL,
                                                   entry_id character varying(95) NOT NULL,
                                                   trigger_name character varying(200) NOT NULL,
                                                   trigger_group character varying(200) NOT NULL,
                                                   instance_name character varying(200) NOT NULL,
                                                   fired_time bigint NOT NULL,
                                                   sched_time bigint NOT NULL,
                                                   priority integer NOT NULL,
                                                   state character varying(16) NOT NULL,
                                                   job_name character varying(200),
                                                   job_group character varying(200),
                                                   is_nonconcurrent boolean,
                                                   requests_recovery boolean
);


COMMENT ON TABLE qrtz_fired_triggers IS 'qrtz表';


CREATE TABLE qrtz_job_details (
                                                sched_name character varying(120) NOT NULL,
                                                job_name character varying(200) NOT NULL,
                                                job_group character varying(200) NOT NULL,
                                                description character varying(250),
                                                job_class_name character varying(250) NOT NULL,
                                                is_durable boolean NOT NULL,
                                                is_nonconcurrent boolean NOT NULL,
                                                is_update_data boolean NOT NULL,
                                                requests_recovery boolean NOT NULL,
                                                job_data bytea
);


COMMENT ON TABLE qrtz_job_details IS 'qrtz表';


CREATE TABLE qrtz_locks (
                                          sched_name character varying(120) NOT NULL,
                                          lock_name character varying(40) NOT NULL
);


COMMENT ON TABLE qrtz_locks IS 'qrtz表';


CREATE TABLE qrtz_paused_trigger_grps (
                                                        sched_name character varying(120) NOT NULL,
                                                        trigger_group character varying(200) NOT NULL
);


COMMENT ON TABLE qrtz_paused_trigger_grps IS 'qrtz表';


CREATE TABLE qrtz_scheduler_state (
                                                    sched_name character varying(120) NOT NULL,
                                                    instance_name character varying(200) NOT NULL,
                                                    last_checkin_time bigint NOT NULL,
                                                    checkin_interval bigint NOT NULL
);


COMMENT ON TABLE qrtz_scheduler_state IS 'qrtz表';


CREATE TABLE qrtz_simple_triggers (
                                                    sched_name character varying(120) NOT NULL,
                                                    trigger_name character varying(200) NOT NULL,
                                                    trigger_group character varying(200) NOT NULL,
                                                    repeat_count bigint NOT NULL,
                                                    repeat_interval bigint NOT NULL,
                                                    times_triggered bigint NOT NULL
);


COMMENT ON TABLE qrtz_simple_triggers IS 'qrtz表';


CREATE TABLE qrtz_simprop_triggers (
                                                     sched_name character varying(120) NOT NULL,
                                                     trigger_name character varying(200) NOT NULL,
                                                     trigger_group character varying(200) NOT NULL,
                                                     str_prop_1 character varying(512),
                                                     str_prop_2 character varying(512),
                                                     str_prop_3 character varying(512),
                                                     int_prop_1 integer,
                                                     int_prop_2 integer,
                                                     long_prop_1 bigint,
                                                     long_prop_2 bigint,
                                                     dec_prop_1 numeric(13,4),
                                                     dec_prop_2 numeric(13,4),
                                                     bool_prop_1 boolean,
                                                     bool_prop_2 boolean
);


COMMENT ON TABLE qrtz_simprop_triggers IS 'qrtz表';


CREATE TABLE qrtz_triggers (
                                             sched_name character varying(120) NOT NULL,
                                             trigger_name character varying(200) NOT NULL,
                                             trigger_group character varying(200) NOT NULL,
                                             job_name character varying(200) NOT NULL,
                                             job_group character varying(200) NOT NULL,
                                             description character varying(250),
                                             next_fire_time bigint,
                                             prev_fire_time bigint,
                                             priority integer,
                                             trigger_state character varying(16) NOT NULL,
                                             trigger_type character varying(8) NOT NULL,
                                             start_time bigint NOT NULL,
                                             end_time bigint,
                                             calendar_name character varying(200),
                                             misfire_instr smallint,
                                             job_data bytea
);


COMMENT ON TABLE qrtz_triggers IS 'qrtz表';


CREATE TABLE system_dept (
                                           id bigint NOT NULL,
                                           name character varying(30) NOT NULL,
                                           parent_id bigint NOT NULL,
                                           sort integer NOT NULL,
                                           leader_user_id bigint,
                                           phone character varying(11),
                                           email character varying(50),
                                           status smallint NOT NULL,
                                           creator character varying(64),
                                           create_time timestamp(6) without time zone NOT NULL,
                                           updater character varying(64),
                                           update_time timestamp(6) without time zone NOT NULL,
                                           deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_dept IS '部门表';


COMMENT ON COLUMN system_dept.id IS '部门id';


COMMENT ON COLUMN system_dept.name IS '部门名称';


COMMENT ON COLUMN system_dept.parent_id IS '父部门id';


COMMENT ON COLUMN system_dept.sort IS '显示顺序';


COMMENT ON COLUMN system_dept.leader_user_id IS '负责人';


COMMENT ON COLUMN system_dept.phone IS '联系电话';


COMMENT ON COLUMN system_dept.email IS '邮箱';


COMMENT ON COLUMN system_dept.status IS '部门状态（0正常 1停用）';


COMMENT ON COLUMN system_dept.creator IS '创建者';


COMMENT ON COLUMN system_dept.create_time IS '创建时间';


COMMENT ON COLUMN system_dept.updater IS '更新者';


COMMENT ON COLUMN system_dept.update_time IS '更新时间';


COMMENT ON COLUMN system_dept.deleted IS '是否删除';


CREATE TABLE system_dict_data (
                                                id bigint NOT NULL,
                                                sort integer NOT NULL,
                                                label character varying(100) NOT NULL,
                                                value character varying(100) NOT NULL,
                                                dict_type character varying(100) NOT NULL,
                                                status smallint NOT NULL,
                                                color_type character varying(100),
                                                css_class character varying(100),
                                                remark character varying(500),
                                                creator character varying(64),
                                                create_time timestamp(6) without time zone NOT NULL,
                                                updater character varying(64),
                                                update_time timestamp(6) without time zone NOT NULL,
                                                deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_dict_data IS '字典数据表';


COMMENT ON COLUMN system_dict_data.id IS '字典编码';


COMMENT ON COLUMN system_dict_data.sort IS '字典排序';


COMMENT ON COLUMN system_dict_data.label IS '字典标签';


COMMENT ON COLUMN system_dict_data.value IS '字典键值';


COMMENT ON COLUMN system_dict_data.dict_type IS '字典类型';


COMMENT ON COLUMN system_dict_data.status IS '状态（0正常 1停用）';


COMMENT ON COLUMN system_dict_data.color_type IS '颜色类型';


COMMENT ON COLUMN system_dict_data.css_class IS 'css 样式';


COMMENT ON COLUMN system_dict_data.remark IS '备注';


COMMENT ON COLUMN system_dict_data.creator IS '创建者';


COMMENT ON COLUMN system_dict_data.create_time IS '创建时间';


COMMENT ON COLUMN system_dict_data.updater IS '更新者';


COMMENT ON COLUMN system_dict_data.update_time IS '更新时间';


COMMENT ON COLUMN system_dict_data.deleted IS '是否删除';


CREATE TABLE system_dict_type (
                                                id bigint NOT NULL,
                                                name character varying(100) NOT NULL,
                                                type character varying(100) NOT NULL,
                                                status smallint NOT NULL,
                                                remark character varying(500),
                                                creator character varying(64),
                                                create_time timestamp(6) without time zone NOT NULL,
                                                updater character varying(64),
                                                update_time timestamp(6) without time zone NOT NULL,
                                                deleted_time timestamp(6) without time zone,
                                                deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_dict_type IS '字典类型表';


COMMENT ON COLUMN system_dict_type.id IS '字典主键';


COMMENT ON COLUMN system_dict_type.name IS '字典名称';


COMMENT ON COLUMN system_dict_type.type IS '字典类型';


COMMENT ON COLUMN system_dict_type.status IS '状态（0正常 1停用）';


COMMENT ON COLUMN system_dict_type.remark IS '备注';


COMMENT ON COLUMN system_dict_type.creator IS '创建者';


COMMENT ON COLUMN system_dict_type.create_time IS '创建时间';


COMMENT ON COLUMN system_dict_type.updater IS '更新者';


COMMENT ON COLUMN system_dict_type.update_time IS '更新时间';


COMMENT ON COLUMN system_dict_type.deleted_time IS '删除时间';


COMMENT ON COLUMN system_dict_type.deleted IS '是否删除';


CREATE TABLE system_error_code (
                                                 id bigint NOT NULL,
                                                 type smallint NOT NULL,
                                                 application_name character varying(50) NOT NULL,
                                                 code integer NOT NULL,
                                                 message character varying(512) NOT NULL,
                                                 memo character varying(512),
                                                 creator character varying(64),
                                                 create_time timestamp(6) without time zone NOT NULL,
                                                 updater character varying(64),
                                                 update_time timestamp(6) without time zone NOT NULL,
                                                 deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_error_code IS '错误码表';


COMMENT ON COLUMN system_error_code.id IS '错误码编号';


COMMENT ON COLUMN system_error_code.type IS '错误码类型';


COMMENT ON COLUMN system_error_code.application_name IS '应用名';


COMMENT ON COLUMN system_error_code.code IS '错误码编码';


COMMENT ON COLUMN system_error_code.message IS '错误码错误提示';


COMMENT ON COLUMN system_error_code.memo IS '备注';


COMMENT ON COLUMN system_error_code.creator IS '创建者';


COMMENT ON COLUMN system_error_code.create_time IS '创建时间';


COMMENT ON COLUMN system_error_code.updater IS '更新者';


COMMENT ON COLUMN system_error_code.update_time IS '更新时间';


COMMENT ON COLUMN system_error_code.deleted IS '是否删除';


CREATE TABLE system_login_log (
                                                id bigint NOT NULL,
                                                log_type bigint NOT NULL,
                                                trace_id character varying(64) NOT NULL,
                                                user_id bigint DEFAULT 0 NOT NULL,
                                                user_type smallint NOT NULL,
                                                username character varying(50) NOT NULL,
                                                result smallint NOT NULL,
                                                user_ip character varying(50) NOT NULL,
                                                user_agent character varying(512) NOT NULL,
                                                creator character varying(64),
                                                create_time timestamp(6) without time zone NOT NULL,
                                                updater character varying(64),
                                                update_time timestamp(6) without time zone NOT NULL,
                                                deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_login_log IS '系统访问记录';


COMMENT ON COLUMN system_login_log.id IS '访问ID';


COMMENT ON COLUMN system_login_log.log_type IS '日志类型';


COMMENT ON COLUMN system_login_log.trace_id IS '链路追踪编号';


COMMENT ON COLUMN system_login_log.user_id IS '用户编号';


COMMENT ON COLUMN system_login_log.user_type IS '用户类型';


COMMENT ON COLUMN system_login_log.username IS '用户账号';


COMMENT ON COLUMN system_login_log.result IS '登陆结果';


COMMENT ON COLUMN system_login_log.user_ip IS '用户 IP';


COMMENT ON COLUMN system_login_log.user_agent IS '浏览器 UA';


COMMENT ON COLUMN system_login_log.creator IS '创建者';


COMMENT ON COLUMN system_login_log.create_time IS '创建时间';


COMMENT ON COLUMN system_login_log.updater IS '更新者';


COMMENT ON COLUMN system_login_log.update_time IS '更新时间';


COMMENT ON COLUMN system_login_log.deleted IS '是否删除';




CREATE TABLE system_menu (
                                           id bigint NOT NULL,
                                           name character varying(50) NOT NULL,
                                           permission character varying(100) DEFAULT ''::character varying NOT NULL,
                                           type smallint NOT NULL,
                                           sort integer NOT NULL,
                                           parent_id bigint NOT NULL,
                                           path character varying(200),
                                           icon character varying(100),
                                           component character varying(255),
                                           status smallint NOT NULL,
                                           visible boolean DEFAULT true NOT NULL,
                                           keep_alive boolean DEFAULT false NOT NULL,
                                           creator character varying(64),
                                           create_time timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP(6) NOT NULL,
                                           updater character varying(64),
                                           update_time timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP(6) NOT NULL,
                                           deleted smallint DEFAULT 0 NOT NULL,
                                           component_name character varying(255),
                                           always_show boolean DEFAULT false NOT NULL
);


COMMENT ON TABLE system_menu IS '菜单权限表';


COMMENT ON COLUMN system_menu.id IS '菜单ID';


COMMENT ON COLUMN system_menu.name IS '菜单名称';


COMMENT ON COLUMN system_menu.permission IS '权限标识';


COMMENT ON COLUMN system_menu.type IS '菜单类型';


COMMENT ON COLUMN system_menu.sort IS '显示顺序';


COMMENT ON COLUMN system_menu.parent_id IS '父菜单ID';


COMMENT ON COLUMN system_menu.path IS '路由地址';


COMMENT ON COLUMN system_menu.icon IS '菜单图标';


COMMENT ON COLUMN system_menu.component IS '组件路径';


COMMENT ON COLUMN system_menu.status IS '菜单状态';


COMMENT ON COLUMN system_menu.visible IS '是否可见';


COMMENT ON COLUMN system_menu.keep_alive IS '是否缓存';


COMMENT ON COLUMN system_menu.creator IS '创建者';


COMMENT ON COLUMN system_menu.create_time IS '创建时间';


COMMENT ON COLUMN system_menu.updater IS '更新者';


COMMENT ON COLUMN system_menu.update_time IS '更新时间';


COMMENT ON COLUMN system_menu.deleted IS '是否删除';


COMMENT ON COLUMN system_menu.component_name IS '组件名称';


COMMENT ON COLUMN system_menu.always_show IS '是否总是显示';


CREATE TABLE system_notice (
                                             id bigint NOT NULL,
                                             title character varying(50) NOT NULL,
                                             content text NOT NULL,
                                             type smallint NOT NULL,
                                             status smallint NOT NULL,
                                             creator character varying(64),
                                             create_time timestamp(6) without time zone NOT NULL,
                                             updater character varying(64),
                                             update_time timestamp(6) without time zone NOT NULL,
                                             deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_notice IS '通知公告表';


COMMENT ON COLUMN system_notice.id IS '公告ID';


COMMENT ON COLUMN system_notice.title IS '公告标题';


COMMENT ON COLUMN system_notice.content IS '公告内容';


COMMENT ON COLUMN system_notice.type IS '公告类型（1通知 2公告）';


COMMENT ON COLUMN system_notice.status IS '公告状态（0正常 1关闭）';


COMMENT ON COLUMN system_notice.creator IS '创建者';


COMMENT ON COLUMN system_notice.create_time IS '创建时间';


COMMENT ON COLUMN system_notice.updater IS '更新者';


COMMENT ON COLUMN system_notice.update_time IS '更新时间';


COMMENT ON COLUMN system_notice.deleted IS '是否删除';




CREATE TABLE system_notify_message (
                                                     id bigint NOT NULL,
                                                     user_id bigint NOT NULL,
                                                     user_type smallint NOT NULL,
                                                     template_id bigint NOT NULL,
                                                     template_code character varying(64) NOT NULL,
                                                     template_nickname character varying(63) NOT NULL,
                                                     template_content character varying(1024) NOT NULL,
                                                     template_type integer NOT NULL,
                                                     template_params character varying(255) NOT NULL,
                                                     read_status boolean DEFAULT false NOT NULL,
                                                     read_time timestamp(6) without time zone,
                                                     creator character varying(64),
                                                     create_time timestamp(6) without time zone NOT NULL,
                                                     updater character varying(64),
                                                     update_time timestamp(6) without time zone NOT NULL,
                                                     deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_notify_message IS '站内信消息表';


COMMENT ON COLUMN system_notify_message.id IS '用户ID';


COMMENT ON COLUMN system_notify_message.user_id IS '用户id';


COMMENT ON COLUMN system_notify_message.user_type IS '用户类型';


COMMENT ON COLUMN system_notify_message.template_id IS '模版编号';


COMMENT ON COLUMN system_notify_message.template_code IS '模板编码';


COMMENT ON COLUMN system_notify_message.template_nickname IS '模版发送人名称';


COMMENT ON COLUMN system_notify_message.template_content IS '模版内容';


COMMENT ON COLUMN system_notify_message.template_type IS '模版类型';


COMMENT ON COLUMN system_notify_message.template_params IS '模版参数';


COMMENT ON COLUMN system_notify_message.read_status IS '是否已读';


COMMENT ON COLUMN system_notify_message.read_time IS '阅读时间';


COMMENT ON COLUMN system_notify_message.creator IS '创建者';


COMMENT ON COLUMN system_notify_message.create_time IS '创建时间';


COMMENT ON COLUMN system_notify_message.updater IS '更新者';


COMMENT ON COLUMN system_notify_message.update_time IS '更新时间';


COMMENT ON COLUMN system_notify_message.deleted IS '是否删除';




CREATE TABLE system_notify_template (
                                                      id bigint NOT NULL,
                                                      name character varying(63) NOT NULL,
                                                      code character varying(64) NOT NULL,
                                                      nickname character varying(255) NOT NULL,
                                                      content character varying(1024) NOT NULL,
                                                      type smallint NOT NULL,
                                                      params character varying(255),
                                                      status smallint NOT NULL,
                                                      remark character varying(255),
                                                      creator character varying(64),
                                                      create_time timestamp(6) without time zone NOT NULL,
                                                      updater character varying(64),
                                                      update_time timestamp(6) without time zone NOT NULL,
                                                      deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_notify_template IS '站内信模板表';


COMMENT ON COLUMN system_notify_template.id IS '主键';


COMMENT ON COLUMN system_notify_template.name IS '模板名称';


COMMENT ON COLUMN system_notify_template.code IS '模版编码';


COMMENT ON COLUMN system_notify_template.nickname IS '发送人名称';


COMMENT ON COLUMN system_notify_template.content IS '模版内容';


COMMENT ON COLUMN system_notify_template.type IS '类型';


COMMENT ON COLUMN system_notify_template.params IS '参数数组';


COMMENT ON COLUMN system_notify_template.status IS '状态';


COMMENT ON COLUMN system_notify_template.remark IS '备注';


COMMENT ON COLUMN system_notify_template.creator IS '创建者';


COMMENT ON COLUMN system_notify_template.create_time IS '创建时间';


COMMENT ON COLUMN system_notify_template.updater IS '更新者';


COMMENT ON COLUMN system_notify_template.update_time IS '更新时间';


COMMENT ON COLUMN system_notify_template.deleted IS '是否删除';




CREATE TABLE system_oauth2_access_token (
                                                          id bigint NOT NULL,
                                                          user_id bigint NOT NULL,
                                                          access_token character varying(255) NOT NULL,
                                                          refresh_token character varying(32) NOT NULL,
                                                          user_type smallint NOT NULL,
                                                          client_id character varying(255) NOT NULL,
                                                          expires_time timestamp(6) without time zone NOT NULL,
                                                          creator character varying(64),
                                                          create_time timestamp(6) without time zone NOT NULL,
                                                          updater character varying(64),
                                                          update_time timestamp(6) without time zone NOT NULL,
                                                          deleted smallint DEFAULT 0 NOT NULL,
                                                          scopes character varying(255) DEFAULT ''::character varying
);


COMMENT ON TABLE system_oauth2_access_token IS '刷新令牌';


COMMENT ON COLUMN system_oauth2_access_token.id IS '编号';


COMMENT ON COLUMN system_oauth2_access_token.user_id IS '用户编号';


COMMENT ON COLUMN system_oauth2_access_token.access_token IS '访问令牌';


COMMENT ON COLUMN system_oauth2_access_token.refresh_token IS '刷新令牌';


COMMENT ON COLUMN system_oauth2_access_token.user_type IS '用户类型';


COMMENT ON COLUMN system_oauth2_access_token.client_id IS '客户端编号';


COMMENT ON COLUMN system_oauth2_access_token.expires_time IS '过期时间';


COMMENT ON COLUMN system_oauth2_access_token.creator IS '创建者';


COMMENT ON COLUMN system_oauth2_access_token.create_time IS '创建时间';


COMMENT ON COLUMN system_oauth2_access_token.updater IS '更新者';


COMMENT ON COLUMN system_oauth2_access_token.update_time IS '更新时间';


COMMENT ON COLUMN system_oauth2_access_token.deleted IS '是否删除';


COMMENT ON COLUMN system_oauth2_access_token.scopes IS '授权范围';




CREATE TABLE system_oauth2_approve (
                                                     id bigint NOT NULL,
                                                     user_id bigint NOT NULL,
                                                     user_type smallint NOT NULL,
                                                     client_id character varying(255) NOT NULL,
                                                     scope character varying(255) NOT NULL,
                                                     approved boolean NOT NULL,
                                                     expires_time timestamp(6) without time zone NOT NULL,
                                                     creator character varying(64),
                                                     create_time timestamp(6) without time zone NOT NULL,
                                                     updater character varying(64),
                                                     update_time timestamp(6) without time zone NOT NULL,
                                                     deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_oauth2_approve IS 'OAuth2 批准表';


COMMENT ON COLUMN system_oauth2_approve.id IS '编号';


COMMENT ON COLUMN system_oauth2_approve.user_id IS '用户编号';


COMMENT ON COLUMN system_oauth2_approve.user_type IS '用户类型';


COMMENT ON COLUMN system_oauth2_approve.client_id IS '客户端编号';


COMMENT ON COLUMN system_oauth2_approve.scope IS '授权范围';


COMMENT ON COLUMN system_oauth2_approve.approved IS '是否接受';


COMMENT ON COLUMN system_oauth2_approve.expires_time IS '过期时间';


COMMENT ON COLUMN system_oauth2_approve.creator IS '创建者';


COMMENT ON COLUMN system_oauth2_approve.create_time IS '创建时间';


COMMENT ON COLUMN system_oauth2_approve.updater IS '更新者';


COMMENT ON COLUMN system_oauth2_approve.update_time IS '更新时间';


COMMENT ON COLUMN system_oauth2_approve.deleted IS '是否删除';




CREATE TABLE system_oauth2_client (
                                                    id bigint NOT NULL,
                                                    client_id character varying(255) NOT NULL,
                                                    secret character varying(255) NOT NULL,
                                                    name character varying(255) NOT NULL,
                                                    logo character varying(255) NOT NULL,
                                                    description character varying(255),
                                                    status smallint NOT NULL,
                                                    access_token_validity_seconds integer NOT NULL,
                                                    refresh_token_validity_seconds integer NOT NULL,
                                                    redirect_uris character varying(255) NOT NULL,
                                                    authorized_grant_types character varying(255) NOT NULL,
                                                    scopes character varying(255),
                                                    authorities character varying(255),
                                                    resource_ids character varying(255),
                                                    additional_information character varying(4096),
                                                    creator character varying(64),
                                                    create_time timestamp(6) without time zone NOT NULL,
                                                    updater character varying(64),
                                                    update_time timestamp(6) without time zone NOT NULL,
                                                    deleted smallint DEFAULT 0 NOT NULL,
                                                    auto_approve_scopes character varying(255)
);


COMMENT ON TABLE system_oauth2_client IS 'OAuth2 客户端表';


COMMENT ON COLUMN system_oauth2_client.id IS '编号';


COMMENT ON COLUMN system_oauth2_client.client_id IS '客户端编号';


COMMENT ON COLUMN system_oauth2_client.secret IS '客户端密钥';


COMMENT ON COLUMN system_oauth2_client.name IS '应用名';


COMMENT ON COLUMN system_oauth2_client.logo IS '应用图标';


COMMENT ON COLUMN system_oauth2_client.description IS '应用描述';


COMMENT ON COLUMN system_oauth2_client.status IS '状态';


COMMENT ON COLUMN system_oauth2_client.access_token_validity_seconds IS '访问令牌的有效期';


COMMENT ON COLUMN system_oauth2_client.refresh_token_validity_seconds IS '刷新令牌的有效期';


COMMENT ON COLUMN system_oauth2_client.redirect_uris IS '可重定向的 URI 地址';


COMMENT ON COLUMN system_oauth2_client.authorized_grant_types IS '授权类型';


COMMENT ON COLUMN system_oauth2_client.scopes IS '授权范围';


COMMENT ON COLUMN system_oauth2_client.authorities IS '权限';


COMMENT ON COLUMN system_oauth2_client.resource_ids IS '资源';


COMMENT ON COLUMN system_oauth2_client.additional_information IS '附加信息';


COMMENT ON COLUMN system_oauth2_client.creator IS '创建者';


COMMENT ON COLUMN system_oauth2_client.create_time IS '创建时间';


COMMENT ON COLUMN system_oauth2_client.updater IS '更新者';


COMMENT ON COLUMN system_oauth2_client.update_time IS '更新时间';


COMMENT ON COLUMN system_oauth2_client.deleted IS '是否删除';


COMMENT ON COLUMN system_oauth2_client.auto_approve_scopes IS '自动通过的授权范围';




CREATE TABLE system_oauth2_code (
                                                  id bigint NOT NULL,
                                                  user_id bigint NOT NULL,
                                                  user_type smallint NOT NULL,
                                                  code character varying(32) NOT NULL,
                                                  client_id character varying(255) NOT NULL,
                                                  scopes character varying(255),
                                                  expires_time timestamp(6) without time zone NOT NULL,
                                                  redirect_uri character varying(255),
                                                  state character varying(255),
                                                  creator character varying(64),
                                                  create_time timestamp(6) without time zone NOT NULL,
                                                  updater character varying(64),
                                                  update_time timestamp(6) without time zone NOT NULL,
                                                  deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_oauth2_code IS 'OAuth2 授权码表';


COMMENT ON COLUMN system_oauth2_code.id IS '编号';


COMMENT ON COLUMN system_oauth2_code.user_id IS '用户编号';


COMMENT ON COLUMN system_oauth2_code.user_type IS '用户类型';


COMMENT ON COLUMN system_oauth2_code.code IS '授权码';


COMMENT ON COLUMN system_oauth2_code.client_id IS '客户端编号';


COMMENT ON COLUMN system_oauth2_code.scopes IS '授权范围';


COMMENT ON COLUMN system_oauth2_code.expires_time IS '过期时间';


COMMENT ON COLUMN system_oauth2_code.redirect_uri IS '可重定向的 URI 地址';


COMMENT ON COLUMN system_oauth2_code.state IS '状态';


COMMENT ON COLUMN system_oauth2_code.creator IS '创建者';


COMMENT ON COLUMN system_oauth2_code.create_time IS '创建时间';


COMMENT ON COLUMN system_oauth2_code.updater IS '更新者';


COMMENT ON COLUMN system_oauth2_code.update_time IS '更新时间';


COMMENT ON COLUMN system_oauth2_code.deleted IS '是否删除';




CREATE TABLE system_oauth2_refresh_token (
                                                           id bigint NOT NULL,
                                                           user_id bigint NOT NULL,
                                                           refresh_token character varying(32) NOT NULL,
                                                           user_type smallint NOT NULL,
                                                           client_id character varying(255) NOT NULL,
                                                           expires_time timestamp(6) without time zone NOT NULL,
                                                           creator character varying(64),
                                                           create_time timestamp(6) without time zone NOT NULL,
                                                           updater character varying(64),
                                                           update_time timestamp(6) without time zone NOT NULL,
                                                           deleted smallint DEFAULT 0 NOT NULL,
                                                           scopes character varying(255) DEFAULT ''::character varying
);


COMMENT ON TABLE system_oauth2_refresh_token IS '刷新令牌';


COMMENT ON COLUMN system_oauth2_refresh_token.id IS '编号';


COMMENT ON COLUMN system_oauth2_refresh_token.user_id IS '用户编号';


COMMENT ON COLUMN system_oauth2_refresh_token.refresh_token IS '刷新令牌';


COMMENT ON COLUMN system_oauth2_refresh_token.user_type IS '用户类型';


COMMENT ON COLUMN system_oauth2_refresh_token.client_id IS '客户端编号';


COMMENT ON COLUMN system_oauth2_refresh_token.expires_time IS '过期时间';


COMMENT ON COLUMN system_oauth2_refresh_token.creator IS '创建者';


COMMENT ON COLUMN system_oauth2_refresh_token.create_time IS '创建时间';


COMMENT ON COLUMN system_oauth2_refresh_token.updater IS '更新者';


COMMENT ON COLUMN system_oauth2_refresh_token.update_time IS '更新时间';


COMMENT ON COLUMN system_oauth2_refresh_token.deleted IS '是否删除';


COMMENT ON COLUMN system_oauth2_refresh_token.scopes IS '授权范围';




CREATE TABLE system_operate_log (
                                                  id bigint NOT NULL,
                                                  trace_id character varying(64) NOT NULL,
                                                  user_id bigint NOT NULL,
                                                  user_type smallint NOT NULL,
                                                  module character varying(50) NOT NULL,
                                                  name character varying(50) NOT NULL,
                                                  type bigint NOT NULL,
                                                  content character varying(2000) DEFAULT ''::character varying NOT NULL,
                                                  exts character varying(512) DEFAULT ''::character varying NOT NULL,
                                                  request_method character varying(16),
                                                  request_url character varying(255),
                                                  user_ip character varying(50),
                                                  user_agent character varying(200),
                                                  java_method character varying(512) NOT NULL,
                                                  java_method_args character varying(8000),
                                                  start_time timestamp(6) without time zone NOT NULL,
                                                  duration integer NOT NULL,
                                                  result_code integer NOT NULL,
                                                  result_msg character varying(512),
                                                  result_data character varying(4000),
                                                  creator character varying(64),
                                                  create_time timestamp(6) without time zone NOT NULL,
                                                  updater character varying(64),
                                                  update_time timestamp(6) without time zone NOT NULL,
                                                  deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_operate_log IS '操作日志记录';


COMMENT ON COLUMN system_operate_log.id IS '日志主键';


COMMENT ON COLUMN system_operate_log.trace_id IS '链路追踪编号';


COMMENT ON COLUMN system_operate_log.user_id IS '用户编号';


COMMENT ON COLUMN system_operate_log.user_type IS '用户类型';


COMMENT ON COLUMN system_operate_log.module IS '模块标题';


COMMENT ON COLUMN system_operate_log.name IS '操作名';


COMMENT ON COLUMN system_operate_log.type IS '操作分类';


COMMENT ON COLUMN system_operate_log.content IS '操作内容';


COMMENT ON COLUMN system_operate_log.exts IS '拓展字段';


COMMENT ON COLUMN system_operate_log.request_method IS '请求方法名';


COMMENT ON COLUMN system_operate_log.request_url IS '请求地址';


COMMENT ON COLUMN system_operate_log.user_ip IS '用户 IP';


COMMENT ON COLUMN system_operate_log.user_agent IS '浏览器 UA';


COMMENT ON COLUMN system_operate_log.java_method IS 'Java 方法名';


COMMENT ON COLUMN system_operate_log.java_method_args IS 'Java 方法的参数';


COMMENT ON COLUMN system_operate_log.start_time IS '操作时间';


COMMENT ON COLUMN system_operate_log.duration IS '执行时长';


COMMENT ON COLUMN system_operate_log.result_code IS '结果码';


COMMENT ON COLUMN system_operate_log.result_msg IS '结果提示';


COMMENT ON COLUMN system_operate_log.result_data IS '结果数据';


COMMENT ON COLUMN system_operate_log.creator IS '创建者';


COMMENT ON COLUMN system_operate_log.create_time IS '创建时间';


COMMENT ON COLUMN system_operate_log.updater IS '更新者';


COMMENT ON COLUMN system_operate_log.update_time IS '更新时间';


COMMENT ON COLUMN system_operate_log.deleted IS '是否删除';




CREATE TABLE system_post (
                                           id bigint DEFAULT 0 NOT NULL,
                                           code character varying(64) NOT NULL,
                                           name character varying(50) NOT NULL,
                                           sort integer NOT NULL,
                                           status smallint NOT NULL,
                                           remark character varying(500),
                                           creator character varying(64),
                                           create_time timestamp(6) without time zone NOT NULL,
                                           updater character varying(64),
                                           update_time timestamp(6) without time zone NOT NULL,
                                           deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_post IS '岗位信息表';


COMMENT ON COLUMN system_post.id IS '岗位ID';


COMMENT ON COLUMN system_post.code IS '岗位编码';


COMMENT ON COLUMN system_post.name IS '岗位名称';


COMMENT ON COLUMN system_post.sort IS '显示顺序';


COMMENT ON COLUMN system_post.status IS '状态（0正常 1停用）';


COMMENT ON COLUMN system_post.remark IS '备注';


COMMENT ON COLUMN system_post.creator IS '创建者';


COMMENT ON COLUMN system_post.create_time IS '创建时间';


COMMENT ON COLUMN system_post.updater IS '更新者';


COMMENT ON COLUMN system_post.update_time IS '更新时间';


COMMENT ON COLUMN system_post.deleted IS '是否删除';




CREATE TABLE system_role (
                                           id bigint NOT NULL,
                                           name character varying(30) NOT NULL,
                                           code character varying(100) NOT NULL,
                                           sort integer NOT NULL,
                                           data_scope smallint NOT NULL,
                                           data_scope_dept_ids character varying(500) DEFAULT ''::character varying NOT NULL,
                                           status smallint NOT NULL,
                                           type smallint NOT NULL,
                                           remark character varying(500),
                                           creator character varying(64),
                                           create_time timestamp(6) without time zone NOT NULL,
                                           updater character varying(64),
                                           update_time timestamp(6) without time zone NOT NULL,
                                           deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_role IS '角色信息表';


COMMENT ON COLUMN system_role.id IS '角色ID';


COMMENT ON COLUMN system_role.name IS '角色名称';


COMMENT ON COLUMN system_role.code IS '角色权限字符串';


COMMENT ON COLUMN system_role.sort IS '显示顺序';


COMMENT ON COLUMN system_role.data_scope IS '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）';


COMMENT ON COLUMN system_role.data_scope_dept_ids IS '数据范围(指定部门数组)';


COMMENT ON COLUMN system_role.status IS '角色状态（0正常 1停用）';


COMMENT ON COLUMN system_role.type IS '角色类型';


COMMENT ON COLUMN system_role.remark IS '备注';


COMMENT ON COLUMN system_role.creator IS '创建者';


COMMENT ON COLUMN system_role.create_time IS '创建时间';


COMMENT ON COLUMN system_role.updater IS '更新者';


COMMENT ON COLUMN system_role.update_time IS '更新时间';


COMMENT ON COLUMN system_role.deleted IS '是否删除';


CREATE TABLE system_role_menu (
                                                id bigint NOT NULL,
                                                role_id bigint NOT NULL,
                                                menu_id bigint NOT NULL,
                                                creator character varying(64),
                                                create_time timestamp(6) without time zone NOT NULL,
                                                updater character varying(64),
                                                update_time timestamp(6) without time zone NOT NULL,
                                                deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_role_menu IS '角色和菜单关联表';


COMMENT ON COLUMN system_role_menu.id IS '自增编号';


COMMENT ON COLUMN system_role_menu.role_id IS '角色ID';


COMMENT ON COLUMN system_role_menu.menu_id IS '菜单ID';


COMMENT ON COLUMN system_role_menu.creator IS '创建者';


COMMENT ON COLUMN system_role_menu.create_time IS '创建时间';


COMMENT ON COLUMN system_role_menu.updater IS '更新者';


COMMENT ON COLUMN system_role_menu.update_time IS '更新时间';


COMMENT ON COLUMN system_role_menu.deleted IS '是否删除';






CREATE TABLE system_sensitive_word (
                                                     id bigint NOT NULL,
                                                     name character varying(255) NOT NULL,
                                                     description character varying(512),
                                                     tags character varying(255),
                                                     status smallint NOT NULL,
                                                     creator character varying(64),
                                                     create_time timestamp(6) without time zone NOT NULL,
                                                     updater character varying(64),
                                                     update_time timestamp(6) without time zone NOT NULL,
                                                     deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_sensitive_word IS '敏感词';


COMMENT ON COLUMN system_sensitive_word.id IS '编号';


COMMENT ON COLUMN system_sensitive_word.name IS '敏感词';


COMMENT ON COLUMN system_sensitive_word.description IS '描述';


COMMENT ON COLUMN system_sensitive_word.tags IS '标签数组';


COMMENT ON COLUMN system_sensitive_word.status IS '状态';


COMMENT ON COLUMN system_sensitive_word.creator IS '创建者';


COMMENT ON COLUMN system_sensitive_word.create_time IS '创建时间';


COMMENT ON COLUMN system_sensitive_word.updater IS '更新者';


COMMENT ON COLUMN system_sensitive_word.update_time IS '更新时间';


COMMENT ON COLUMN system_sensitive_word.deleted IS '是否删除';




CREATE TABLE system_user_post (
                                                id bigint NOT NULL,
                                                user_id bigint NOT NULL,
                                                post_id bigint NOT NULL,
                                                creator character varying(64),
                                                create_time timestamp(6) without time zone NOT NULL,
                                                updater character varying(64),
                                                update_time timestamp(6) without time zone NOT NULL,
                                                deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_user_post IS '用户岗位表';


COMMENT ON COLUMN system_user_post.id IS 'id';


COMMENT ON COLUMN system_user_post.user_id IS '用户ID';


COMMENT ON COLUMN system_user_post.post_id IS '岗位ID';


COMMENT ON COLUMN system_user_post.creator IS '创建者';


COMMENT ON COLUMN system_user_post.create_time IS '创建时间';


COMMENT ON COLUMN system_user_post.updater IS '更新者';


COMMENT ON COLUMN system_user_post.update_time IS '更新时间';


COMMENT ON COLUMN system_user_post.deleted IS '是否删除';




CREATE TABLE system_user_role (
                                                id bigint NOT NULL,
                                                user_id bigint NOT NULL,
                                                role_id bigint NOT NULL,
                                                creator character varying(64),
                                                create_time timestamp(6) without time zone,
                                                updater character varying(64),
                                                update_time timestamp(6) without time zone,
                                                deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_user_role IS '用户和角色关联表';


COMMENT ON COLUMN system_user_role.id IS '自增编号';


COMMENT ON COLUMN system_user_role.user_id IS '用户ID';


COMMENT ON COLUMN system_user_role.role_id IS '角色ID';


COMMENT ON COLUMN system_user_role.creator IS '创建者';


COMMENT ON COLUMN system_user_role.create_time IS '创建时间';


COMMENT ON COLUMN system_user_role.updater IS '更新者';


COMMENT ON COLUMN system_user_role.update_time IS '更新时间';


COMMENT ON COLUMN system_user_role.deleted IS '是否删除';






CREATE TABLE system_user_session (
                                                   id bigint NOT NULL,
                                                   token character varying(32) NOT NULL,
                                                   user_id bigint NOT NULL,
                                                   user_type smallint NOT NULL,
                                                   session_timeout timestamp(6) without time zone NOT NULL,
                                                   username character varying(30) NOT NULL,
                                                   user_ip character varying(50) NOT NULL,
                                                   user_agent character varying(512) NOT NULL,
                                                   creator character varying(64),
                                                   create_time timestamp(6) without time zone NOT NULL,
                                                   updater character varying(64),
                                                   update_time timestamp(6) without time zone NOT NULL,
                                                   deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_user_session IS '用户在线 Session';


COMMENT ON COLUMN system_user_session.id IS '编号';


COMMENT ON COLUMN system_user_session.token IS '会话编号';


COMMENT ON COLUMN system_user_session.user_id IS '用户编号';


COMMENT ON COLUMN system_user_session.user_type IS '用户类型';


COMMENT ON COLUMN system_user_session.session_timeout IS '会话超时时间';


COMMENT ON COLUMN system_user_session.username IS '用户账号';


COMMENT ON COLUMN system_user_session.user_ip IS '用户 IP';


COMMENT ON COLUMN system_user_session.user_agent IS '浏览器 UA';


COMMENT ON COLUMN system_user_session.creator IS '创建者';


COMMENT ON COLUMN system_user_session.create_time IS '创建时间';


COMMENT ON COLUMN system_user_session.updater IS '更新者';


COMMENT ON COLUMN system_user_session.update_time IS '更新时间';


COMMENT ON COLUMN system_user_session.deleted IS '是否删除';




CREATE TABLE system_users (
                                            id bigint NOT NULL,
                                            username character varying(30) NOT NULL,
                                            password character varying(100) NOT NULL,
                                            nickname character varying(30) NOT NULL,
                                            remark character varying(500),
                                            dept_id bigint,
                                            post_ids character varying(255),
                                            email character varying(50),
                                            mobile character varying(11),
                                            sex smallint,
                                            avatar character varying(100),
                                            status smallint NOT NULL,
                                            login_ip character varying(50),
                                            login_date timestamp(6) without time zone,
                                            creator character varying(64),
                                            create_time timestamp(6) without time zone NOT NULL,
                                            updater character varying(64),
                                            update_time timestamp(6) without time zone NOT NULL,
                                            deleted smallint DEFAULT 0 NOT NULL
);


COMMENT ON TABLE system_users IS '用户信息表';


COMMENT ON COLUMN system_users.id IS '用户ID';


COMMENT ON COLUMN system_users.username IS '用户账号';


COMMENT ON COLUMN system_users.password IS '密码';


COMMENT ON COLUMN system_users.nickname IS '用户昵称';


COMMENT ON COLUMN system_users.remark IS '备注';


COMMENT ON COLUMN system_users.dept_id IS '部门ID';


COMMENT ON COLUMN system_users.post_ids IS '岗位编号数组';


COMMENT ON COLUMN system_users.email IS '用户邮箱';


COMMENT ON COLUMN system_users.mobile IS '手机号码';


COMMENT ON COLUMN system_users.sex IS '用户性别';


COMMENT ON COLUMN system_users.avatar IS '头像地址';


COMMENT ON COLUMN system_users.status IS '帐号状态（0正常 1停用）';


COMMENT ON COLUMN system_users.login_ip IS '最后登录IP';


COMMENT ON COLUMN system_users.login_date IS '最后登录时间';


COMMENT ON COLUMN system_users.creator IS '创建者';


COMMENT ON COLUMN system_users.create_time IS '创建时间';


COMMENT ON COLUMN system_users.updater IS '更新者';


COMMENT ON COLUMN system_users.update_time IS '更新时间';


COMMENT ON COLUMN system_users.deleted IS '是否删除';












INSERT INTO infra_config VALUES (1, 'ui', 1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', '0', '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow', 'admin', '2021-01-05 17:03:48', '1', '2022-03-26 23:10:31', 0);
INSERT INTO infra_config VALUES (2, 'biz', 1, '用户管理-账号初始密码', 'sys.user.init-password', '123456', '0', '初始化密码 123456', 'admin', '2021-01-05 17:03:48', '1', '2022-03-20 02:25:51', 0);
INSERT INTO infra_config VALUES (3, 'ui', 1, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', '0', '深色主题theme-dark，浅色主题theme-light', 'admin', '2021-01-05 17:03:48', '', '2021-01-19 03:05:21', 0);
INSERT INTO infra_config VALUES (4, '1', 2, 'xxx', 'demo.test', '10', '0', '5', '', '2021-01-19 03:10:26', '', '2021-01-20 09:25:55', 0);
INSERT INTO infra_config VALUES (5, 'xxx', 2, 'xxx', 'xxx', 'xxx', '1', 'xxx', '', '2021-02-09 20:06:47', '', '2021-02-09 20:06:47', 0);
INSERT INTO infra_config VALUES (6, 'biz', 2, '登陆验证码的开关', 'yudao.captcha.enable', 'true', '1', NULL, '1', '2022-02-17 00:03:11', '1', '2022-04-04 12:51:40', 0);






INSERT INTO infra_file_config VALUES (18, 'database', 1, NULL, true, '{"@class":"com.beacon.framework.file.core.client.db.DBFileClientConfig","domain":"http://localhost:7525"}', '1', '2023-06-30 17:24:01', '1', '2023-07-06 16:39:01', 0);
































INSERT INTO system_dept VALUES (100, '一级部门', 0, 0, 1, '18888888888', 'xxx@open-beacon.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2026-06-15 23:05:41.108', 0);
INSERT INTO system_dept VALUES (113, '二级部门', 100, 1, NULL, NULL, NULL, 0, '1', '2023-06-25 16:56:01', '1', '2026-06-15 23:05:55.372', 0);
INSERT INTO system_dept VALUES (116, '三级部门', 113, 1, NULL, '', NULL, 0, '1', '2023-06-25 16:56:48', '1', '2026-06-15 23:06:01.65', 0);


INSERT INTO system_dict_data VALUES (1, 1, '男', '1', 'system_user_sex', 0, 'default', 'A', '性别男', 'admin', '2021-01-05 17:03:48', '1', '2022-03-29 00:14:39', 0);
INSERT INTO system_dict_data VALUES (2, 2, '女', '2', 'system_user_sex', 0, 'success', '', '性别女', 'admin', '2021-01-05 17:03:48', '1', '2023-06-25 17:06:02', 0);
INSERT INTO system_dict_data VALUES (8, 1, '正常', '1', 'infra_job_status', 0, 'success', '', '正常状态', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 19:33:38', 0);
INSERT INTO system_dict_data VALUES (9, 2, '暂停', '2', 'infra_job_status', 0, 'danger', '', '停用状态', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 19:33:45', 0);
INSERT INTO system_dict_data VALUES (12, 1, '系统内置', '1', 'infra_config_type', 0, 'danger', '', '参数类型 - 系统内置', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 19:06:02', 0);
INSERT INTO system_dict_data VALUES (13, 2, '自定义', '2', 'infra_config_type', 0, 'primary', '', '参数类型 - 自定义', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 19:06:07', 0);
INSERT INTO system_dict_data VALUES (14, 1, '通知', '1', 'system_notice_type', 0, 'success', '', '通知', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 13:05:57', 0);
INSERT INTO system_dict_data VALUES (15, 2, '公告', '2', 'system_notice_type', 0, 'info', '', '公告', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 13:06:01', 0);
INSERT INTO system_dict_data VALUES (16, 0, '其它', '0', 'system_operate_type', 0, 'default', '', '其它操作', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 09:32:46', 0);
INSERT INTO system_dict_data VALUES (17, 1, '查询', '1', 'system_operate_type', 0, 'info', '', '查询操作', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 09:33:16', 0);
INSERT INTO system_dict_data VALUES (18, 2, '新增', '2', 'system_operate_type', 0, 'primary', '', '新增操作', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 09:33:13', 0);
INSERT INTO system_dict_data VALUES (19, 3, '修改', '3', 'system_operate_type', 0, 'warning', '', '修改操作', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 09:33:22', 0);
INSERT INTO system_dict_data VALUES (20, 4, '删除', '4', 'system_operate_type', 0, 'danger', '', '删除操作', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 09:33:27', 0);
INSERT INTO system_dict_data VALUES (22, 5, '导出', '5', 'system_operate_type', 0, 'default', '', '导出操作', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 09:33:32', 0);
INSERT INTO system_dict_data VALUES (23, 6, '导入', '6', 'system_operate_type', 0, 'default', '', '导入操作', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 09:33:35', 0);
INSERT INTO system_dict_data VALUES (27, 1, '开启', '0', 'common_status', 0, 'primary', '', '开启状态', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 08:00:39', 0);
INSERT INTO system_dict_data VALUES (28, 2, '关闭', '1', 'common_status', 0, 'info', '', '关闭状态', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 08:00:44', 0);
INSERT INTO system_dict_data VALUES (29, 1, '目录', '1', 'system_menu_type', 0, '', '', '目录', 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:43:45', 0);
INSERT INTO system_dict_data VALUES (30, 2, '菜单', '2', 'system_menu_type', 0, '', '', '菜单', 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:43:41', 0);
INSERT INTO system_dict_data VALUES (31, 3, '按钮', '3', 'system_menu_type', 0, '', '', '按钮', 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:43:39', 0);
INSERT INTO system_dict_data VALUES (32, 1, '内置', '1', 'system_role_type', 0, 'danger', '', '内置角色', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 13:02:08', 0);
INSERT INTO system_dict_data VALUES (33, 2, '自定义', '2', 'system_role_type', 0, 'primary', '', '自定义角色', 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 13:02:12', 0);
INSERT INTO system_dict_data VALUES (34, 1, '全部数据权限', '1', 'system_data_scope', 0, '', '', '全部数据权限', 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:47:17', 0);
INSERT INTO system_dict_data VALUES (35, 2, '指定部门数据权限', '2', 'system_data_scope', 0, '', '', '指定部门数据权限', 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:47:18', 0);
INSERT INTO system_dict_data VALUES (36, 3, '本部门数据权限', '3', 'system_data_scope', 0, '', '', '本部门数据权限', 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:47:16', 0);
INSERT INTO system_dict_data VALUES (37, 4, '本部门及以下数据权限', '4', 'system_data_scope', 0, '', '', '本部门及以下数据权限', 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:47:21', 0);
INSERT INTO system_dict_data VALUES (38, 5, '仅本人数据权限', '5', 'system_data_scope', 0, '', '', '仅本人数据权限', 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:47:23', 0);
INSERT INTO system_dict_data VALUES (39, 0, '成功', '0', 'system_login_result', 0, 'success', '', '登陆结果 - 成功', '', '2021-01-18 06:17:36', '1', '2022-02-16 13:23:49', 0);
INSERT INTO system_dict_data VALUES (40, 10, '账号或密码不正确', '10', 'system_login_result', 0, 'primary', '', '登陆结果 - 账号或密码不正确', '', '2021-01-18 06:17:54', '1', '2022-02-16 13:24:27', 0);
INSERT INTO system_dict_data VALUES (41, 20, '用户被禁用', '20', 'system_login_result', 0, 'warning', '', '登陆结果 - 用户被禁用', '', '2021-01-18 06:17:54', '1', '2022-02-16 13:23:57', 0);
INSERT INTO system_dict_data VALUES (42, 30, '验证码不存在', '30', 'system_login_result', 0, 'info', '', '登陆结果 - 验证码不存在', '', '2021-01-18 06:17:54', '1', '2022-02-16 13:24:07', 0);
INSERT INTO system_dict_data VALUES (43, 31, '验证码不正确', '31', 'system_login_result', 0, 'info', '', '登陆结果 - 验证码不正确', '', '2021-01-18 06:17:54', '1', '2022-02-16 13:24:11', 0);
INSERT INTO system_dict_data VALUES (44, 100, '未知异常', '100', 'system_login_result', 0, 'danger', '', '登陆结果 - 未知异常', '', '2021-01-18 06:17:54', '1', '2022-02-16 13:24:23', 0);
INSERT INTO system_dict_data VALUES (45, 1, '是', 'true', 'infra_boolean_string', 0, 'danger', '', 'Boolean 是否类型 - 是', '', '2021-01-19 03:20:55', '1', '2022-03-15 23:01:45', 0);
INSERT INTO system_dict_data VALUES (46, 1, '否', 'false', 'infra_boolean_string', 0, 'info', '', 'Boolean 是否类型 - 否', '', '2021-01-19 03:20:55', '1', '2022-03-15 23:09:45', 0);
INSERT INTO system_dict_data VALUES (47, 1, '永不超时', '1', 'infra_redis_timeout_type', 0, 'primary', '', 'Redis 未设置超时的情况', '', '2021-01-26 00:53:17', '1', '2022-02-16 19:03:35', 0);
INSERT INTO system_dict_data VALUES (48, 1, '动态超时', '2', 'infra_redis_timeout_type', 0, 'info', '', '程序里动态传入超时时间，无法固定', '', '2021-01-26 00:55:00', '1', '2022-02-16 19:03:41', 0);
INSERT INTO system_dict_data VALUES (49, 3, '固定超时', '3', 'infra_redis_timeout_type', 0, 'success', '', 'Redis 设置了过期时间', '', '2021-01-26 00:55:26', '1', '2022-02-16 19:03:45', 0);
INSERT INTO system_dict_data VALUES (50, 1, '单表（增删改查）', '1', 'infra_codegen_template_type', 0, '', '', NULL, '', '2021-02-05 07:09:06', '', '2022-03-10 16:33:15', 0);
INSERT INTO system_dict_data VALUES (51, 2, '树表（增删改查）', '2', 'infra_codegen_template_type', 0, '', '', NULL, '', '2021-02-05 07:14:46', '', '2022-03-10 16:33:19', 0);
INSERT INTO system_dict_data VALUES (53, 0, '初始化中', '0', 'infra_job_status', 0, 'primary', '', NULL, '', '2021-02-07 07:46:49', '1', '2022-02-16 19:33:29', 0);
INSERT INTO system_dict_data VALUES (57, 0, '运行中', '0', 'infra_job_log_status', 0, 'primary', '', 'RUNNING', '', '2021-02-08 10:04:24', '1', '2022-02-16 19:07:48', 0);
INSERT INTO system_dict_data VALUES (58, 1, '成功', '1', 'infra_job_log_status', 0, 'success', '', NULL, '', '2021-02-08 10:06:57', '1', '2022-02-16 19:07:52', 0);
INSERT INTO system_dict_data VALUES (59, 2, '失败', '2', 'infra_job_log_status', 0, 'warning', '', '失败', '', '2021-02-08 10:07:38', '1', '2022-02-16 19:07:56', 0);
INSERT INTO system_dict_data VALUES (60, 1, '会员', '1', 'user_type', 0, 'primary', '', NULL, '', '2021-02-26 00:16:27', '1', '2022-02-16 10:22:19', 0);
INSERT INTO system_dict_data VALUES (61, 2, '管理员', '2', 'user_type', 0, 'success', '', NULL, '', '2021-02-26 00:16:34', '1', '2022-02-16 10:22:22', 0);
INSERT INTO system_dict_data VALUES (62, 0, '未处理', '0', 'infra_api_error_log_process_status', 0, 'primary', '', NULL, '', '2021-02-26 07:07:19', '1', '2022-02-16 20:14:17', 0);
INSERT INTO system_dict_data VALUES (63, 1, '已处理', '1', 'infra_api_error_log_process_status', 0, 'success', '', NULL, '', '2021-02-26 07:07:26', '1', '2022-02-16 20:14:08', 0);
INSERT INTO system_dict_data VALUES (64, 2, '已忽略', '2', 'infra_api_error_log_process_status', 0, 'danger', '', NULL, '', '2021-02-26 07:07:34', '1', '2022-02-16 20:14:14', 0);
INSERT INTO system_dict_data VALUES (78, 1, '自动生成', '1', 'system_error_code_type', 0, 'warning', '', NULL, '1', '2021-04-21 00:06:48', '1', '2022-02-16 13:57:20', 0);
INSERT INTO system_dict_data VALUES (79, 2, '手动编辑', '2', 'system_error_code_type', 0, 'primary', '', NULL, '1', '2021-04-21 00:07:14', '1', '2022-02-16 13:57:24', 0);
INSERT INTO system_dict_data VALUES (80, 100, '账号登录', '100', 'system_login_type', 0, 'primary', '', '账号登录', '1', '2021-10-06 00:52:02', '1', '2022-02-16 13:11:34', 0);
INSERT INTO system_dict_data VALUES (81, 101, '社交登录', '101', 'system_login_type', 0, 'info', '', '社交登录', '1', '2021-10-06 00:52:17', '1', '2022-02-16 13:11:40', 0);
INSERT INTO system_dict_data VALUES (83, 200, '主动登出', '200', 'system_login_type', 0, 'primary', '', '主动登出', '1', '2021-10-06 00:52:58', '1', '2022-02-16 13:11:49', 0);
INSERT INTO system_dict_data VALUES (85, 202, '强制登出', '202', 'system_login_type', 0, 'danger', '', '强制退出', '1', '2021-10-06 00:53:41', '1', '2022-02-16 13:11:57', 0);
INSERT INTO system_dict_data VALUES (1145, 1, '管理后台', '1', 'infra_codegen_scene', 0, '', '', '代码生成的场景枚举 - 管理后台', '1', '2022-02-02 13:15:06', '1', '2022-03-10 16:32:59', 0);
INSERT INTO system_dict_data VALUES (1146, 2, '用户 APP', '2', 'infra_codegen_scene', 0, '', '', '代码生成的场景枚举 - 用户 APP', '1', '2022-02-02 13:15:19', '1', '2022-03-10 16:33:03', 0);
INSERT INTO system_dict_data VALUES (1150, 1, '数据库', '1', 'infra_file_storage', 0, 'default', '', NULL, '1', '2022-03-15 00:25:28', '1', '2022-03-15 00:25:28', 0);
INSERT INTO system_dict_data VALUES (1151, 10, '本地磁盘', '10', 'infra_file_storage', 0, 'default', '', NULL, '1', '2022-03-15 00:25:41', '1', '2022-03-15 00:25:56', 0);
INSERT INTO system_dict_data VALUES (1152, 11, 'FTP 服务器', '11', 'infra_file_storage', 0, 'default', '', NULL, '1', '2022-03-15 00:26:06', '1', '2022-03-15 00:26:10', 0);
INSERT INTO system_dict_data VALUES (1153, 12, 'SFTP 服务器', '12', 'infra_file_storage', 0, 'default', '', NULL, '1', '2022-03-15 00:26:22', '1', '2022-03-15 00:26:22', 0);
INSERT INTO system_dict_data VALUES (1154, 20, 'S3 对象存储', '20', 'infra_file_storage', 0, 'default', '', NULL, '1', '2022-03-15 00:26:31', '1', '2022-03-15 00:26:45', 0);
INSERT INTO system_dict_data VALUES (1155, 103, '短信登录', '103', 'system_login_type', 0, 'default', '', NULL, '1', '2022-05-09 23:57:58', '1', '2022-05-09 23:58:09', 0);
INSERT INTO system_dict_data VALUES (1156, 1, 'password', 'password', 'system_oauth2_grant_type', 0, 'default', '', '密码模式', '1', '2022-05-12 00:22:05', '1', '2022-05-11 16:26:01', 0);
INSERT INTO system_dict_data VALUES (1157, 2, 'authorization_code', 'authorization_code', 'system_oauth2_grant_type', 0, 'primary', '', '授权码模式', '1', '2022-05-12 00:22:59', '1', '2022-05-11 16:26:02', 0);
INSERT INTO system_dict_data VALUES (1158, 3, 'implicit', 'implicit', 'system_oauth2_grant_type', 0, 'success', '', '简化模式', '1', '2022-05-12 00:23:40', '1', '2022-05-11 16:26:05', 0);
INSERT INTO system_dict_data VALUES (1159, 4, 'client_credentials', 'client_credentials', 'system_oauth2_grant_type', 0, 'default', '', '客户端模式', '1', '2022-05-12 00:23:51', '1', '2022-05-11 16:26:08', 0);
INSERT INTO system_dict_data VALUES (1160, 5, 'refresh_token', 'refresh_token', 'system_oauth2_grant_type', 0, 'info', '', '刷新模式', '1', '2022-05-12 00:24:02', '1', '2022-05-11 16:26:11', 0);
INSERT INTO system_dict_data VALUES (1194, 10, '微信小程序', '10', 'terminal', 0, 'default', '', '终端 - 微信小程序', '1', '2022-12-10 10:51:11', '1', '2022-12-10 10:51:57', 0);
INSERT INTO system_dict_data VALUES (1195, 20, 'H5 网页', '20', 'terminal', 0, 'default', '', '终端 - H5 网页', '1', '2022-12-10 10:51:30', '1', '2022-12-10 10:51:59', 0);
INSERT INTO system_dict_data VALUES (1196, 11, '微信公众号', '11', 'terminal', 0, 'default', '', '终端 - 微信公众号', '1', '2022-12-10 10:54:16', '1', '2022-12-10 10:52:01', 0);
INSERT INTO system_dict_data VALUES (1197, 31, '苹果 App', '31', 'terminal', 0, 'default', '', '终端 - 苹果 App', '1', '2022-12-10 10:54:42', '1', '2022-12-10 10:52:18', 0);
INSERT INTO system_dict_data VALUES (1198, 32, '安卓 App', '32', 'terminal', 0, 'default', '', '终端 - 安卓 App', '1', '2022-12-10 10:55:02', '1', '2022-12-10 10:59:17', 0);
INSERT INTO system_dict_data VALUES (1227, 1, '通知公告', '1', 'system_notify_template_type', 0, 'primary', '', '站内信模版的类型 - 通知公告', '1', '2023-01-28 10:35:59', '1', '2023-01-28 10:35:59', 0);
INSERT INTO system_dict_data VALUES (1228, 2, '系统消息', '2', 'system_notify_template_type', 0, 'success', '', '站内信模版的类型 - 系统消息', '1', '2023-01-28 10:36:20', '1', '2023-01-28 10:36:25', 0);


INSERT INTO system_dict_type VALUES (1, '用户性别', 'system_user_sex', 0, NULL, 'admin', '2021-01-05 17:03:48', '1', '2022-05-16 20:29:32', NULL, 0);
INSERT INTO system_dict_type VALUES (6, '参数类型', 'infra_config_type', 0, NULL, 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:36:54', NULL, 0);
INSERT INTO system_dict_type VALUES (7, '通知类型', 'system_notice_type', 0, NULL, 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:35:26', NULL, 0);
INSERT INTO system_dict_type VALUES (9, '操作类型', 'system_operate_type', 0, NULL, 'admin', '2021-01-05 17:03:48', '1', '2022-02-16 09:32:21', NULL, 0);
INSERT INTO system_dict_type VALUES (10, '系统状态', 'common_status', 0, NULL, 'admin', '2021-01-05 17:03:48', '', '2022-02-01 16:21:28', NULL, 0);
INSERT INTO system_dict_type VALUES (11, 'Boolean 是否类型', 'infra_boolean_string', 0, 'boolean 转是否', '', '2021-01-19 03:20:08', '', '2022-02-01 16:37:10', NULL, 0);
INSERT INTO system_dict_type VALUES (104, '登陆结果', 'system_login_result', 0, '登陆结果', '', '2021-01-18 06:17:11', '', '2022-02-01 16:36:00', NULL, 0);
INSERT INTO system_dict_type VALUES (105, 'Redis 超时类型', 'infra_redis_timeout_type', 0, 'RedisKeyDefine.TimeoutTypeEnum', '', '2021-01-26 00:52:50', '', '2022-02-01 16:50:29', NULL, 0);
INSERT INTO system_dict_type VALUES (106, '代码生成模板类型', 'infra_codegen_template_type', 0, NULL, '', '2021-02-05 07:08:06', '1', '2022-05-16 20:26:50', NULL, 0);
INSERT INTO system_dict_type VALUES (107, '定时任务状态', 'infra_job_status', 0, NULL, '', '2021-02-07 07:44:16', '', '2022-02-01 16:51:11', NULL, 0);
INSERT INTO system_dict_type VALUES (108, '定时任务日志状态', 'infra_job_log_status', 0, NULL, '', '2021-02-08 10:03:51', '', '2022-02-01 16:50:43', NULL, 0);
INSERT INTO system_dict_type VALUES (109, '用户类型', 'user_type', 0, NULL, '', '2021-02-26 00:15:51', '', '2021-02-26 00:15:51', NULL, 0);
INSERT INTO system_dict_type VALUES (110, 'API 异常数据的处理状态', 'infra_api_error_log_process_status', 0, NULL, '', '2021-02-26 07:07:01', '', '2022-02-01 16:50:53', NULL, 0);
INSERT INTO system_dict_type VALUES (115, '错误码的类型', 'system_error_code_type', 0, NULL, '1', '2021-04-21 00:06:30', '1', '2022-02-01 16:36:49', NULL, 0);
INSERT INTO system_dict_type VALUES (116, '登陆日志的类型', 'system_login_type', 0, '登陆日志的类型', '1', '2021-10-06 00:50:46', '1', '2022-02-01 16:35:56', NULL, 0);
INSERT INTO system_dict_type VALUES (144, '代码生成的场景枚举', 'infra_codegen_scene', 0, '代码生成的场景枚举', '1', '2022-02-02 13:14:45', '1', '2022-03-10 16:33:46', NULL, 0);
INSERT INTO system_dict_type VALUES (145, '角色类型', 'system_role_type', 0, '角色类型', '1', '2022-02-16 13:01:46', '1', '2022-02-16 13:01:46', NULL, 0);
INSERT INTO system_dict_type VALUES (146, '文件存储器', 'infra_file_storage', 0, '文件存储器', '1', '2022-03-15 00:24:38', '1', '2022-03-15 00:24:38', NULL, 0);
INSERT INTO system_dict_type VALUES (147, 'OAuth 2.0 授权类型', 'system_oauth2_grant_type', 0, 'OAuth 2.0 授权类型（模式）', '1', '2022-05-12 00:20:52', '1', '2022-05-11 16:25:49', NULL, 0);
INSERT INTO system_dict_type VALUES (160, '终端', 'terminal', 0, '终端', '1', '2022-12-10 10:50:50', '1', '2022-12-10 10:53:11', NULL, 0);
INSERT INTO system_dict_type VALUES (167, '站内信模版的类型', 'system_notify_template_type', 0, '站内信模版的类型', '1', '2023-01-28 10:35:10', '1', '2023-01-28 10:35:10', '1970-01-01 00:00:00', 0);






INSERT INTO system_menu VALUES (1, '系统管理', '', 1, 10, 0, '/system', 'system', NULL, 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (2, '基础设施', '', 1, 20, 0, '/infra', 'monitor', NULL, 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (100, '用户管理', 'system:user:list', 2, 1, 1, 'user', 'user', 'system/user/index', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2023-02-10 13:50:21', 0, 'User', true);
INSERT INTO system_menu VALUES (101, '角色管理', '', 2, 2, 1, 'role', 'peoples', 'system/role/index', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (102, '菜单管理', '', 2, 3, 1, 'menu', 'tree-table', 'system/menu/index', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2023-07-19 16:49:51', 0, NULL, true);
INSERT INTO system_menu VALUES (103, '部门管理', '', 2, 4, 1, 'dept', 'tree', 'system/dept/index', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (104, '岗位管理', '', 2, 5, 1, 'post', 'post', 'system/post/index', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (105, '字典管理', '', 2, 6, 1, 'dict', 'dict', 'system/dict/index', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (106, '配置管理', '', 2, 6, 2, 'config', 'edit', 'infra/config/index', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (107, '通知公告', '', 2, 8, 1, 'notice', 'message', 'system/notice/index', 1, true, true, 'admin', '2021-01-05 17:03:48', '1', '2023-06-26 18:53:01', 0, NULL, true);
INSERT INTO system_menu VALUES (108, '审计日志', '', 1, 9, 1, 'log', 'log', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (109, '令牌管理', '', 2, 2, 1261, 'token', 'online', 'system/oauth2/token/index', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-05-11 23:31:42', 0, NULL, true);
INSERT INTO system_menu VALUES (110, '定时任务', '', 2, 12, 2, 'job', 'job', 'infra/job/index', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (112, 'Java 监控', '', 2, 11, 2, 'admin-server', 'server', 'infra/server/index', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (113, 'Redis 监控', '', 2, 10, 2, 'redis', 'redis', 'infra/redis/index', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (116, '系统接口', 'infra:swagger:list', 2, 3, 2, 'swagger', 'swagger', 'infra/swagger/index', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (500, '操作日志', '', 2, 1, 108, 'operate-log', 'form', 'system/operatelog/index', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (501, '登录日志', '', 2, 2, 108, 'login-log', 'logininfor', 'system/loginlog/index', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1001, '用户查询', 'system:user:query', 3, 1, 100, '', '#', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1002, '用户新增', 'system:user:create', 3, 2, 100, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1003, '用户修改', 'system:user:update', 3, 3, 100, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1004, '用户删除', 'system:user:delete', 3, 4, 100, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1005, '用户导出', 'system:user:export', 3, 5, 100, '', '#', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1006, '用户导入', 'system:user:import', 3, 6, 100, '', '#', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1007, '重置密码', 'system:user:update-password', 3, 7, 100, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1008, '角色查询', 'system:role:query', 3, 1, 101, '', '#', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1009, '角色新增', 'system:role:create', 3, 2, 101, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1010, '角色修改', 'system:role:update', 3, 3, 101, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1011, '角色删除', 'system:role:delete', 3, 4, 101, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1012, '角色导出', 'system:role:export', 3, 5, 101, '', '#', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1013, '菜单查询', 'system:menu:query', 3, 1, 102, '', '#', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1014, '菜单新增', 'system:menu:create', 3, 2, 102, '', '#', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1015, '菜单修改', 'system:menu:update', 3, 3, 102, '', '#', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1016, '菜单删除', 'system:menu:delete', 3, 4, 102, '', '#', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1017, '部门查询', 'system:dept:query', 3, 1, 103, '', '#', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1018, '部门新增', 'system:dept:create', 3, 2, 103, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1019, '部门修改', 'system:dept:update', 3, 3, 103, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1020, '部门删除', 'system:dept:delete', 3, 4, 103, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1021, '岗位查询', 'system:post:query', 3, 1, 104, '', '#', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1022, '岗位新增', 'system:post:create', 3, 2, 104, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1023, '岗位修改', 'system:post:update', 3, 3, 104, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1024, '岗位删除', 'system:post:delete', 3, 4, 104, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1025, '岗位导出', 'system:post:export', 3, 5, 104, '', '#', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1026, '字典查询', 'system:dict:query', 3, 1, 105, '#', '#', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1027, '字典新增', 'system:dict:create', 3, 2, 105, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1028, '字典修改', 'system:dict:update', 3, 3, 105, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1029, '字典删除', 'system:dict:delete', 3, 4, 105, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1030, '字典导出', 'system:dict:export', 3, 5, 105, '#', '#', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1031, '配置查询', 'infra:config:query', 3, 1, 106, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1032, '配置新增', 'infra:config:create', 3, 2, 106, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1033, '配置修改', 'infra:config:update', 3, 3, 106, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1034, '配置删除', 'infra:config:delete', 3, 4, 106, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1035, '配置导出', 'infra:config:export', 3, 5, 106, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (111, '数据库监控', '', 2, 9, 2, 'druid', 'druid', 'infra/druid/index', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2026-06-14 22:31:47.948', 0, NULL, true);
INSERT INTO system_menu VALUES (1036, '公告查询', 'system:notice:query', 3, 1, 107, '#', '#', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1037, '公告新增', 'system:notice:create', 3, 2, 107, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1038, '公告修改', 'system:notice:update', 3, 3, 107, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1039, '公告删除', 'system:notice:delete', 3, 4, 107, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1040, '操作查询', 'system:operate-log:query', 3, 1, 500, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1042, '日志导出', 'system:operate-log:export', 3, 2, 500, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1043, '登录查询', 'system:login-log:query', 3, 1, 501, '#', '#', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1045, '日志导出', 'system:login-log:export', 3, 3, 501, '#', '#', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1046, '令牌列表', 'system:oauth2-token:page', 3, 1, 109, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-05-09 23:54:42', 0, NULL, true);
INSERT INTO system_menu VALUES (1048, '令牌删除', 'system:oauth2-token:delete', 3, 2, 109, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '1', '2022-05-09 23:54:53', 0, NULL, true);
INSERT INTO system_menu VALUES (1050, '任务新增', 'infra:job:create', 3, 2, 110, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1051, '任务修改', 'infra:job:update', 3, 3, 110, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1052, '任务删除', 'infra:job:delete', 3, 4, 110, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1053, '状态修改', 'infra:job:update', 3, 5, 110, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1054, '任务导出', 'infra:job:export', 3, 7, 110, '', '', '', 0, true, true, 'admin', '2021-01-05 17:03:48', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1063, '设置角色菜单权限', 'system:permission:assign-role-menu', 3, 6, 101, '', '', '', 0, true, true, '', '2021-01-06 17:53:44', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1064, '设置角色数据权限', 'system:permission:assign-role-data-scope', 3, 7, 101, '', '', '', 0, true, true, '', '2021-01-06 17:56:31', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1065, '设置用户角色', 'system:permission:assign-user-role', 3, 8, 101, '', '', '', 0, true, true, '', '2021-01-07 10:23:28', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1066, '获得 Redis 监控信息', 'infra:redis:get-monitor-info', 3, 1, 113, '', '', '', 0, true, true, '', '2021-01-26 01:02:31', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1067, '获得 Redis Key 列表', 'infra:redis:get-key-list', 3, 2, 113, '', '', '', 0, true, true, '', '2021-01-26 01:02:52', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1075, '任务触发', 'infra:job:trigger', 3, 8, 110, '', '', '', 0, true, true, '', '2021-02-07 13:03:10', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1078, '访问日志', '', 2, 1, 1083, 'api-access-log', 'log', 'infra/apiAccessLog/index', 0, true, true, '', '2021-02-26 01:32:59', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1082, '日志导出', 'infra:api-access-log:export', 3, 2, 1078, '', '', '', 0, true, true, '', '2021-02-26 01:32:59', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1083, 'API 日志', '', 2, 8, 2, 'log', 'log', NULL, 0, true, true, '', '2021-02-26 02:18:24', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1084, '错误日志', 'infra:api-error-log:query', 2, 2, 1083, 'api-error-log', 'log', 'infra/apiErrorLog/index', 0, true, true, '', '2021-02-26 07:53:20', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1085, '日志处理', 'infra:api-error-log:update-status', 3, 2, 1084, '', '', '', 0, true, true, '', '2021-02-26 07:53:20', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1086, '日志导出', 'infra:api-error-log:export', 3, 3, 1084, '', '', '', 0, true, true, '', '2021-02-26 07:53:20', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1087, '任务查询', 'infra:job:query', 3, 1, 110, '', '', '', 0, true, true, '1', '2021-03-10 01:26:19', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1088, '日志查询', 'infra:api-access-log:query', 3, 1, 1078, '', '', '', 0, true, true, '1', '2021-03-10 01:28:04', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1089, '日志查询', 'infra:api-error-log:query', 3, 1, 1084, '', '', '', 0, true, true, '1', '2021-03-10 01:29:09', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1090, '文件列表', '', 2, 5, 1243, 'file', 'upload', 'infra/file/index', 0, true, true, '', '2021-03-12 20:16:20', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1091, '文件查询', 'infra:file:query', 3, 1, 1090, '', '', '', 0, true, true, '', '2021-03-12 20:16:20', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1092, '文件删除', 'infra:file:delete', 3, 4, 1090, '', '', '', 0, true, true, '', '2021-03-12 20:16:20', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1110, '错误码管理', '', 2, 12, 1, 'error-code', 'code', 'system/errorCode/index', 0, true, true, '', '2021-04-13 21:46:42', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1111, '错误码查询', 'system:error-code:query', 3, 1, 1110, '', '', '', 0, true, true, '', '2021-04-13 21:46:42', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1112, '错误码创建', 'system:error-code:create', 3, 2, 1110, '', '', '', 0, true, true, '', '2021-04-13 21:46:42', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1113, '错误码更新', 'system:error-code:update', 3, 3, 1110, '', '', '', 0, true, true, '', '2021-04-13 21:46:42', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1114, '错误码删除', 'system:error-code:delete', 3, 4, 1110, '', '', '', 0, true, true, '', '2021-04-13 21:46:42', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1115, '错误码导出', 'system:error-code:export', 3, 5, 1110, '', '', '', 0, true, true, '', '2021-04-13 21:46:42', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1237, '文件配置', '', 2, 0, 1243, 'file-config', 'config', 'infra/fileConfig/index', 0, true, true, '', '2022-03-15 14:35:28', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1238, '文件配置查询', 'infra:file-config:query', 3, 1, 1237, '', '', '', 0, true, true, '', '2022-03-15 14:35:28', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1239, '文件配置创建', 'infra:file-config:create', 3, 2, 1237, '', '', '', 0, true, true, '', '2022-03-15 14:35:28', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1240, '文件配置更新', 'infra:file-config:update', 3, 3, 1237, '', '', '', 0, true, true, '', '2022-03-15 14:35:28', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1241, '文件配置删除', 'infra:file-config:delete', 3, 4, 1237, '', '', '', 0, true, true, '', '2022-03-15 14:35:28', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1242, '文件配置导出', 'infra:file-config:export', 3, 5, 1237, '', '', '', 0, true, true, '', '2022-03-15 14:35:28', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1243, '文件管理', '', 2, 5, 2, 'file', 'download', NULL, 0, true, true, '1', '2022-03-16 23:47:40', '1', '2023-02-10 13:47:46', 0, '', true);
INSERT INTO system_menu VALUES (1247, '敏感词管理', '', 2, 13, 1, 'sensitive-word', 'education', 'system/sensitiveWord/index', 0, true, true, '', '2022-04-07 16:55:03', '1', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1248, '敏感词查询', 'system:sensitive-word:query', 3, 1, 1247, '', '', '', 0, true, true, '', '2022-04-07 16:55:03', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1249, '敏感词创建', 'system:sensitive-word:create', 3, 2, 1247, '', '', '', 0, true, true, '', '2022-04-07 16:55:03', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1250, '敏感词更新', 'system:sensitive-word:update', 3, 3, 1247, '', '', '', 0, true, true, '', '2022-04-07 16:55:03', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1251, '敏感词删除', 'system:sensitive-word:delete', 3, 4, 1247, '', '', '', 0, true, true, '', '2022-04-07 16:55:03', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1252, '敏感词导出', 'system:sensitive-word:export', 3, 5, 1247, '', '', '', 0, true, true, '', '2022-04-07 16:55:03', '', '2022-04-20 17:03:10', 0, NULL, true);
INSERT INTO system_menu VALUES (1255, '数据源配置', '', 2, 1, 2, 'data-source-config', 'rate', 'infra/dataSourceConfig/index', 0, true, true, '', '2022-04-27 14:37:32', '1', '2022-04-27 22:42:06', 0, NULL, true);
INSERT INTO system_menu VALUES (1256, '数据源配置查询', 'infra:data-source-config:query', 3, 1, 1255, '', '', '', 0, true, true, '', '2022-04-27 14:37:32', '', '2022-04-27 14:37:32', 0, NULL, true);
INSERT INTO system_menu VALUES (1257, '数据源配置创建', 'infra:data-source-config:create', 3, 2, 1255, '', '', '', 0, true, true, '', '2022-04-27 14:37:32', '', '2022-04-27 14:37:32', 0, NULL, true);
INSERT INTO system_menu VALUES (1258, '数据源配置更新', 'infra:data-source-config:update', 3, 3, 1255, '', '', '', 0, true, true, '', '2022-04-27 14:37:32', '', '2022-04-27 14:37:32', 0, NULL, true);
INSERT INTO system_menu VALUES (1259, '数据源配置删除', 'infra:data-source-config:delete', 3, 4, 1255, '', '', '', 0, true, true, '', '2022-04-27 14:37:32', '', '2022-04-27 14:37:32', 0, NULL, true);
INSERT INTO system_menu VALUES (1260, '数据源配置导出', 'infra:data-source-config:export', 3, 5, 1255, '', '', '', 0, true, true, '', '2022-04-27 14:37:32', '', '2022-04-27 14:37:32', 0, NULL, true);
INSERT INTO system_menu VALUES (1261, 'OAuth 2.0', '', 1, 14, 1, 'oauth2', 'people', NULL, 0, true, true, '1', '2022-05-09 23:38:17', '1', '2023-06-25 15:29:34', 0, NULL, true);
INSERT INTO system_menu VALUES (1263, '应用管理', '', 2, 0, 1261, 'oauth2/application', 'tool', 'system/oauth2/client/index', 0, true, true, '', '2022-05-10 16:26:33', '1', '2022-05-11 23:31:36', 0, NULL, true);
INSERT INTO system_menu VALUES (1264, '客户端查询', 'system:oauth2-client:query', 3, 1, 1263, '', '', '', 0, true, true, '', '2022-05-10 16:26:33', '1', '2022-05-11 00:31:06', 0, NULL, true);
INSERT INTO system_menu VALUES (1265, '客户端创建', 'system:oauth2-client:create', 3, 2, 1263, '', '', '', 0, true, true, '', '2022-05-10 16:26:33', '1', '2022-05-11 00:31:23', 0, NULL, true);
INSERT INTO system_menu VALUES (1266, '客户端更新', 'system:oauth2-client:update', 3, 3, 1263, '', '', '', 0, true, true, '', '2022-05-10 16:26:33', '1', '2022-05-11 00:31:28', 0, NULL, true);
INSERT INTO system_menu VALUES (1267, '客户端删除', 'system:oauth2-client:delete', 3, 4, 1263, '', '', '', 0, true, true, '', '2022-05-10 16:26:33', '1', '2022-05-11 00:31:33', 0, NULL, true);
INSERT INTO system_menu VALUES (2144, '站内信管理', '', 1, 11, 1, 'notify', 'message', NULL, 0, true, true, '1', '2023-01-28 10:25:18', '1', '2023-01-28 10:25:46', 0, NULL, true);
INSERT INTO system_menu VALUES (2145, '模板管理', '', 2, 0, 2144, 'notify-template', 'education', 'system/notify/template/index', 0, true, true, '', '2023-01-28 02:26:42', '1', '2023-01-28 10:27:47', 0, NULL, true);
INSERT INTO system_menu VALUES (2146, '站内信模板查询', 'system:notify-template:query', 3, 1, 2145, '', '', '', 0, true, true, '', '2023-01-28 02:26:42', '', '2023-01-28 02:26:42', 0, NULL, true);
INSERT INTO system_menu VALUES (2147, '站内信模板创建', 'system:notify-template:create', 3, 2, 2145, '', '', '', 0, true, true, '', '2023-01-28 02:26:42', '', '2023-01-28 02:26:42', 0, NULL, true);
INSERT INTO system_menu VALUES (2148, '站内信模板更新', 'system:notify-template:update', 3, 3, 2145, '', '', '', 0, true, true, '', '2023-01-28 02:26:42', '', '2023-01-28 02:26:42', 0, NULL, true);
INSERT INTO system_menu VALUES (2149, '站内信模板删除', 'system:notify-template:delete', 3, 4, 2145, '', '', '', 0, true, true, '', '2023-01-28 02:26:42', '', '2023-01-28 02:26:42', 0, NULL, true);
INSERT INTO system_menu VALUES (2150, '发送测试站内信', 'system:notify-template:send-notify', 3, 5, 2145, '', '', '', 0, true, true, '1', '2023-01-28 10:54:43', '1', '2023-01-28 10:54:43', 0, NULL, true);
INSERT INTO system_menu VALUES (2151, '消息记录', '', 2, 0, 2144, 'notify-message', 'edit', 'system/notify/message/index', 0, true, true, '', '2023-01-28 04:28:22', '1', '2023-01-28 20:59:53', 0, NULL, true);
INSERT INTO system_menu VALUES (2152, '站内信消息查询', 'system:notify-message:query', 3, 1, 2151, '', '', '', 0, true, true, '', '2023-01-28 04:28:22', '', '2023-01-28 04:28:22', 0, NULL, true);








INSERT INTO system_oauth2_access_token VALUES (51, 1, '90aac627d78049bb89df814826b92822', '1a40d312626344ddb98e73552592f733', 2, 'default', '2023-11-16 15:17:53.132', NULL, '2023-11-16 14:47:53.134', NULL, '2023-11-16 14:47:53.134', 0, '');
INSERT INTO system_oauth2_access_token VALUES (2066160351716880386, 1, '0c8473c0560f4c3daf16d8ecb7f937f5', '80925270666545c59563e2ae024d7281', 2, 'default', '2026-06-14 22:36:29.912', NULL, '2026-06-14 22:06:29.915', NULL, '2026-06-14 22:06:29.915', 1, '');
INSERT INTO system_oauth2_access_token VALUES (2066168313743200258, 1, 'c5f639ddedb745e0a0f345bde2d51e09', '80925270666545c59563e2ae024d7281', 2, 'default', '2026-06-14 23:08:08.204', NULL, '2026-06-14 22:38:08.21', NULL, '2026-06-14 22:38:08.21', 1, '');
INSERT INTO system_oauth2_access_token VALUES (2066518893103689730, 1, 'f84d1e9130d84f668224af17e22c3406', '8aeda7583108445ea6393a8afbb0e43e', 2, 'default', '2026-06-15 22:21:12.849', NULL, '2026-06-15 21:51:12.849', NULL, '2026-06-15 21:51:12.849', 1, '');
INSERT INTO system_oauth2_access_token VALUES (2066526566452834305, 1, '9405eb5e431446488a5130ef78da2893', '8aeda7583108445ea6393a8afbb0e43e', 2, 'default', '2026-06-15 22:51:42.308', NULL, '2026-06-15 22:21:42.309', NULL, '2026-06-15 22:21:42.309', 1, '');
INSERT INTO system_oauth2_access_token VALUES (2066534600197550081, 1, 'a8df169c0c6d48f4adbd196adc0d32d4', '8aeda7583108445ea6393a8afbb0e43e', 2, 'default', '2026-06-15 23:23:37.712', NULL, '2026-06-15 22:53:37.712', NULL, '2026-06-15 22:53:37.712', 1, '');
INSERT INTO system_oauth2_access_token VALUES (2066542205812879362, 1, '915209c5a5aa48198cd11aab56ff81c9', '8aeda7583108445ea6393a8afbb0e43e', 2, 'default', '2026-06-15 23:53:51.028', NULL, '2026-06-15 23:23:51.029', NULL, '2026-06-15 23:23:51.029', 0, '');




INSERT INTO system_oauth2_client VALUES (1, 'default', 'default', 'default', '', '我是描述', 0, 1800, 43200, '["https://www.beacon.cn","https://doc.beacon.cn"]', '["password","authorization_code","implicit","refresh_token"]', '["user.read","user.write"]', '["user.read","user.write"]', '[]', '{}', '1', '2022-05-11 21:47:12', '1', '2023-07-12 17:04:20', 0, '[]');




INSERT INTO system_oauth2_refresh_token VALUES (50, 1, '1a40d312626344ddb98e73552592f733', 2, 'default', '2023-11-17 02:47:53.122', NULL, '2023-11-16 14:47:53.13', NULL, '2023-11-16 14:47:53.13', 0, '');
INSERT INTO system_oauth2_refresh_token VALUES (2066160351628800001, 1, '80925270666545c59563e2ae024d7281', 2, 'default', '2026-06-15 10:06:29.864', NULL, '2026-06-14 22:06:29.893', NULL, '2026-06-14 22:06:29.893', 1, '');
INSERT INTO system_oauth2_refresh_token VALUES (2066518893103689729, 1, '8aeda7583108445ea6393a8afbb0e43e', 2, 'default', '2026-06-16 09:51:12.835', NULL, '2026-06-15 21:51:12.84', NULL, '2026-06-15 21:51:12.84', 0, '');




INSERT INTO system_post VALUES (5, 'qdgcs', '前端工程师', 1, 0, '', '1', '2023-06-25 17:03:24', '1', '2023-06-25 17:03:24', 0);
INSERT INTO system_post VALUES (6, 'javagcs', 'Java工程师', 2, 0, NULL, '1', '2023-06-25 17:03:55', '1', '2023-06-25 17:03:55', 0);


INSERT INTO system_role VALUES (1, '超级管理员', 'super_admin', 1, 1, '', 0, 1, '超级管理员', 'admin', '2021-01-05 17:03:48', '', '2022-02-22 05:08:21', 0);
INSERT INTO system_role VALUES (2, '普通角色', 'common', 2, 2, '', 0, 1, '普通角色', 'admin', '2021-01-05 17:03:48', '', '2022-02-22 05:08:20', 0);


INSERT INTO system_role_menu VALUES (263, 109, 1, '1', '2022-02-22 00:56:14', '1', '2022-02-22 00:56:14', 0);
INSERT INTO system_role_menu VALUES (434, 2, 1, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', 0);
INSERT INTO system_role_menu VALUES (470, 2, 1110, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', 0);
INSERT INTO system_role_menu VALUES (477, 2, 100, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', 0);
INSERT INTO system_role_menu VALUES (478, 2, 101, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', 0);
INSERT INTO system_role_menu VALUES (479, 2, 102, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', 0);
INSERT INTO system_role_menu VALUES (481, 2, 103, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', 0);
INSERT INTO system_role_menu VALUES (483, 2, 104, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', 0);
INSERT INTO system_role_menu VALUES (485, 2, 105, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', 0);
INSERT INTO system_role_menu VALUES (490, 2, 108, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', 0);
INSERT INTO system_role_menu VALUES (492, 2, 109, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', 0);
INSERT INTO system_role_menu VALUES (541, 2, 500, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', 0);
INSERT INTO system_role_menu VALUES (543, 2, 501, '1', '2022-02-22 13:09:12', '1', '2022-02-22 13:09:12', 0);
INSERT INTO system_role_menu VALUES (675, 2, 2, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', 0);
INSERT INTO system_role_menu VALUES (690, 2, 1078, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', 0);
INSERT INTO system_role_menu VALUES (692, 2, 1083, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', 0);
INSERT INTO system_role_menu VALUES (693, 2, 1084, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', 0);
INSERT INTO system_role_menu VALUES (699, 2, 1090, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', 0);
INSERT INTO system_role_menu VALUES (703, 2, 106, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', 0);
INSERT INTO system_role_menu VALUES (704, 2, 110, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', 0);
INSERT INTO system_role_menu VALUES (705, 2, 111, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', 0);
INSERT INTO system_role_menu VALUES (706, 2, 112, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', 0);
INSERT INTO system_role_menu VALUES (707, 2, 113, '1', '2022-02-22 13:16:57', '1', '2022-02-22 13:16:57', 0);
INSERT INTO system_role_menu VALUES (1489, 1, 1, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1490, 1, 2, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1495, 1, 1078, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1496, 1, 1083, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1497, 1, 1084, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1498, 1, 1090, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1503, 1, 1110, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1506, 1, 100, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1507, 1, 101, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1508, 1, 102, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1510, 1, 103, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1511, 1, 104, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1512, 1, 105, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1513, 1, 106, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1514, 1, 107, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1515, 1, 108, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1516, 1, 109, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1517, 1, 110, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1518, 1, 111, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1519, 1, 112, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1520, 1, 113, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1527, 1, 500, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1528, 1, 501, '1', '2022-02-23 20:03:57', '1', '2022-02-23 20:03:57', 0);
INSERT INTO system_role_menu VALUES (1578, 111, 1, '1', '2022-03-07 21:37:58', '1', '2022-03-07 21:37:58', 0);
INSERT INTO system_role_menu VALUES (1712, 113, 1024, '1', '2022-05-17 10:07:10', '1', '2022-05-17 10:07:10', 0);
INSERT INTO system_role_menu VALUES (1713, 113, 1025, '1', '2022-05-17 10:07:10', '1', '2022-05-17 10:07:10', 0);
INSERT INTO system_role_menu VALUES (1714, 113, 1, '1', '2022-05-17 10:07:10', '1', '2022-05-17 10:07:10', 0);
INSERT INTO system_role_menu VALUES (1715, 113, 102, '1', '2022-05-17 10:07:10', '1', '2022-05-17 10:07:10', 0);
INSERT INTO system_role_menu VALUES (1716, 113, 103, '1', '2022-05-17 10:07:10', '1', '2022-05-17 10:07:10', 0);
INSERT INTO system_role_menu VALUES (1717, 113, 104, '1', '2022-05-17 10:07:10', '1', '2022-05-17 10:07:10', 0);
INSERT INTO system_role_menu VALUES (1718, 113, 1013, '1', '2022-05-17 10:07:10', '1', '2022-05-17 10:07:10', 0);
INSERT INTO system_role_menu VALUES (1719, 113, 1014, '1', '2022-05-17 10:07:10', '1', '2022-05-17 10:07:10', 0);
INSERT INTO system_role_menu VALUES (1720, 113, 1015, '1', '2022-05-17 10:07:10', '1', '2022-05-17 10:07:10', 0);
INSERT INTO system_role_menu VALUES (1721, 113, 1016, '1', '2022-05-17 10:07:10', '1', '2022-05-17 10:07:10', 0);
INSERT INTO system_role_menu VALUES (1722, 113, 1017, '1', '2022-05-17 10:07:10', '1', '2022-05-17 10:07:10', 0);
INSERT INTO system_role_menu VALUES (1723, 113, 1018, '1', '2022-05-17 10:07:10', '1', '2022-05-17 10:07:10', 0);
INSERT INTO system_role_menu VALUES (1724, 113, 1019, '1', '2022-05-17 10:07:10', '1', '2022-05-17 10:07:10', 0);
INSERT INTO system_role_menu VALUES (1725, 113, 1020, '1', '2022-05-17 10:07:10', '1', '2022-05-17 10:07:10', 0);
INSERT INTO system_role_menu VALUES (1726, 113, 1021, '1', '2022-05-17 10:07:10', '1', '2022-05-17 10:07:10', 0);
INSERT INTO system_role_menu VALUES (1727, 113, 1022, '1', '2022-05-17 10:07:10', '1', '2022-05-17 10:07:10', 0);
INSERT INTO system_role_menu VALUES (1728, 113, 1023, '1', '2022-05-17 10:07:10', '1', '2022-05-17 10:07:10', 0);
INSERT INTO system_role_menu VALUES (1729, 109, 100, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', 0);
INSERT INTO system_role_menu VALUES (1730, 109, 101, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', 0);
INSERT INTO system_role_menu VALUES (1731, 109, 1063, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', 0);
INSERT INTO system_role_menu VALUES (1732, 109, 1064, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', 0);
INSERT INTO system_role_menu VALUES (1733, 109, 1001, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', 0);
INSERT INTO system_role_menu VALUES (1734, 109, 1065, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', 0);
INSERT INTO system_role_menu VALUES (1735, 109, 1002, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', 0);
INSERT INTO system_role_menu VALUES (1736, 109, 1003, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', 0);
INSERT INTO system_role_menu VALUES (1737, 109, 1004, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', 0);
INSERT INTO system_role_menu VALUES (1738, 109, 1005, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', 0);
INSERT INTO system_role_menu VALUES (1739, 109, 1006, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', 0);
INSERT INTO system_role_menu VALUES (1740, 109, 1007, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', 0);
INSERT INTO system_role_menu VALUES (1741, 109, 1008, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', 0);
INSERT INTO system_role_menu VALUES (1742, 109, 1009, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', 0);
INSERT INTO system_role_menu VALUES (1743, 109, 1010, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', 0);
INSERT INTO system_role_menu VALUES (1744, 109, 1011, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', 0);
INSERT INTO system_role_menu VALUES (1745, 109, 1012, '1', '2022-09-21 22:08:51', '1', '2022-09-21 22:08:51', 0);
INSERT INTO system_role_menu VALUES (1746, 111, 100, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', 0);
INSERT INTO system_role_menu VALUES (1747, 111, 101, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', 0);
INSERT INTO system_role_menu VALUES (1748, 111, 1063, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', 0);
INSERT INTO system_role_menu VALUES (1749, 111, 1064, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', 0);
INSERT INTO system_role_menu VALUES (1750, 111, 1001, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', 0);
INSERT INTO system_role_menu VALUES (1751, 111, 1065, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', 0);
INSERT INTO system_role_menu VALUES (1752, 111, 1002, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', 0);
INSERT INTO system_role_menu VALUES (1753, 111, 1003, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', 0);
INSERT INTO system_role_menu VALUES (1754, 111, 1004, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', 0);
INSERT INTO system_role_menu VALUES (1755, 111, 1005, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', 0);
INSERT INTO system_role_menu VALUES (1756, 111, 1006, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', 0);
INSERT INTO system_role_menu VALUES (1757, 111, 1007, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', 0);
INSERT INTO system_role_menu VALUES (1758, 111, 1008, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', 0);
INSERT INTO system_role_menu VALUES (1759, 111, 1009, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', 0);
INSERT INTO system_role_menu VALUES (1760, 111, 1010, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', 0);
INSERT INTO system_role_menu VALUES (1761, 111, 1011, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', 0);
INSERT INTO system_role_menu VALUES (1762, 111, 1012, '1', '2022-09-21 22:08:52', '1', '2022-09-21 22:08:52', 0);
INSERT INTO system_role_menu VALUES (1763, 109, 100, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', 0);
INSERT INTO system_role_menu VALUES (1764, 109, 101, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', 0);
INSERT INTO system_role_menu VALUES (1765, 109, 1063, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', 0);
INSERT INTO system_role_menu VALUES (1766, 109, 1064, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', 0);
INSERT INTO system_role_menu VALUES (1767, 109, 1001, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', 0);
INSERT INTO system_role_menu VALUES (1768, 109, 1065, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', 0);
INSERT INTO system_role_menu VALUES (1769, 109, 1002, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', 0);
INSERT INTO system_role_menu VALUES (1770, 109, 1003, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', 0);
INSERT INTO system_role_menu VALUES (1771, 109, 1004, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', 0);
INSERT INTO system_role_menu VALUES (1772, 109, 1005, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', 0);
INSERT INTO system_role_menu VALUES (1773, 109, 1006, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', 0);
INSERT INTO system_role_menu VALUES (1774, 109, 1007, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', 0);
INSERT INTO system_role_menu VALUES (1775, 109, 1008, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', 0);
INSERT INTO system_role_menu VALUES (1776, 109, 1009, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', 0);
INSERT INTO system_role_menu VALUES (1777, 109, 1010, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', 0);
INSERT INTO system_role_menu VALUES (1778, 109, 1011, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', 0);
INSERT INTO system_role_menu VALUES (1779, 109, 1012, '1', '2022-09-21 22:08:53', '1', '2022-09-21 22:08:53', 0);
INSERT INTO system_role_menu VALUES (1780, 111, 100, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', 0);
INSERT INTO system_role_menu VALUES (1781, 111, 101, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', 0);
INSERT INTO system_role_menu VALUES (1782, 111, 1063, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', 0);
INSERT INTO system_role_menu VALUES (1783, 111, 1064, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', 0);
INSERT INTO system_role_menu VALUES (1784, 111, 1001, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', 0);
INSERT INTO system_role_menu VALUES (1785, 111, 1065, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', 0);
INSERT INTO system_role_menu VALUES (1786, 111, 1002, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', 0);
INSERT INTO system_role_menu VALUES (1787, 111, 1003, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', 0);
INSERT INTO system_role_menu VALUES (1788, 111, 1004, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', 0);
INSERT INTO system_role_menu VALUES (1789, 111, 1005, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', 0);
INSERT INTO system_role_menu VALUES (1790, 111, 1006, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', 0);
INSERT INTO system_role_menu VALUES (1791, 111, 1007, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', 0);
INSERT INTO system_role_menu VALUES (1792, 111, 1008, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', 0);
INSERT INTO system_role_menu VALUES (1793, 111, 1009, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', 0);
INSERT INTO system_role_menu VALUES (1794, 111, 1010, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', 0);
INSERT INTO system_role_menu VALUES (1795, 111, 1011, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', 0);
INSERT INTO system_role_menu VALUES (1796, 111, 1012, '1', '2022-09-21 22:08:54', '1', '2022-09-21 22:08:54', 0);
INSERT INTO system_role_menu VALUES (1797, 109, 100, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', 0);
INSERT INTO system_role_menu VALUES (1798, 109, 101, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', 0);
INSERT INTO system_role_menu VALUES (1799, 109, 1063, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', 0);
INSERT INTO system_role_menu VALUES (1800, 109, 1064, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', 0);
INSERT INTO system_role_menu VALUES (1801, 109, 1001, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', 0);
INSERT INTO system_role_menu VALUES (1802, 109, 1065, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', 0);
INSERT INTO system_role_menu VALUES (1803, 109, 1002, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', 0);
INSERT INTO system_role_menu VALUES (1804, 109, 1003, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', 0);
INSERT INTO system_role_menu VALUES (1805, 109, 1004, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', 0);
INSERT INTO system_role_menu VALUES (1806, 109, 1005, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', 0);
INSERT INTO system_role_menu VALUES (1807, 109, 1006, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', 0);
INSERT INTO system_role_menu VALUES (1808, 109, 1007, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', 0);
INSERT INTO system_role_menu VALUES (1809, 109, 1008, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', 0);
INSERT INTO system_role_menu VALUES (1810, 109, 1009, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', 0);
INSERT INTO system_role_menu VALUES (1811, 109, 1010, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', 0);
INSERT INTO system_role_menu VALUES (1812, 109, 1011, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', 0);
INSERT INTO system_role_menu VALUES (1813, 109, 1012, '1', '2022-09-21 22:08:55', '1', '2022-09-21 22:08:55', 0);
INSERT INTO system_role_menu VALUES (1814, 111, 100, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', 0);
INSERT INTO system_role_menu VALUES (1815, 111, 101, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', 0);
INSERT INTO system_role_menu VALUES (1816, 111, 1063, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', 0);
INSERT INTO system_role_menu VALUES (1817, 111, 1064, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', 0);
INSERT INTO system_role_menu VALUES (1818, 111, 1001, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', 0);
INSERT INTO system_role_menu VALUES (1819, 111, 1065, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', 0);
INSERT INTO system_role_menu VALUES (1820, 111, 1002, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', 0);
INSERT INTO system_role_menu VALUES (1821, 111, 1003, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', 0);
INSERT INTO system_role_menu VALUES (1822, 111, 1004, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', 0);
INSERT INTO system_role_menu VALUES (1823, 111, 1005, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', 0);
INSERT INTO system_role_menu VALUES (1824, 111, 1006, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', 0);
INSERT INTO system_role_menu VALUES (1825, 111, 1007, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', 0);
INSERT INTO system_role_menu VALUES (1826, 111, 1008, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', 0);
INSERT INTO system_role_menu VALUES (1827, 111, 1009, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', 0);
INSERT INTO system_role_menu VALUES (1828, 111, 1010, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', 0);
INSERT INTO system_role_menu VALUES (1829, 111, 1011, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', 0);
INSERT INTO system_role_menu VALUES (1830, 111, 1012, '1', '2022-09-21 22:08:56', '1', '2022-09-21 22:08:56', 0);
INSERT INTO system_role_menu VALUES (1831, 109, 103, '1', '2022-09-21 22:43:23', '1', '2022-09-21 22:43:23', 0);
INSERT INTO system_role_menu VALUES (1832, 109, 1017, '1', '2022-09-21 22:43:23', '1', '2022-09-21 22:43:23', 0);
INSERT INTO system_role_menu VALUES (1833, 109, 1018, '1', '2022-09-21 22:43:23', '1', '2022-09-21 22:43:23', 0);
INSERT INTO system_role_menu VALUES (1834, 109, 1019, '1', '2022-09-21 22:43:23', '1', '2022-09-21 22:43:23', 0);
INSERT INTO system_role_menu VALUES (1835, 109, 1020, '1', '2022-09-21 22:43:23', '1', '2022-09-21 22:43:23', 0);
INSERT INTO system_role_menu VALUES (1836, 111, 103, '1', '2022-09-21 22:43:24', '1', '2022-09-21 22:43:24', 0);
INSERT INTO system_role_menu VALUES (1837, 111, 1017, '1', '2022-09-21 22:43:24', '1', '2022-09-21 22:43:24', 0);
INSERT INTO system_role_menu VALUES (1838, 111, 1018, '1', '2022-09-21 22:43:24', '1', '2022-09-21 22:43:24', 0);
INSERT INTO system_role_menu VALUES (1839, 111, 1019, '1', '2022-09-21 22:43:24', '1', '2022-09-21 22:43:24', 0);
INSERT INTO system_role_menu VALUES (1840, 111, 1020, '1', '2022-09-21 22:43:24', '1', '2022-09-21 22:43:24', 0);
INSERT INTO system_role_menu VALUES (1841, 109, 1036, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', 0);
INSERT INTO system_role_menu VALUES (1842, 109, 1037, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', 0);
INSERT INTO system_role_menu VALUES (1843, 109, 1038, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', 0);
INSERT INTO system_role_menu VALUES (1844, 109, 1039, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', 0);
INSERT INTO system_role_menu VALUES (1845, 109, 107, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', 0);
INSERT INTO system_role_menu VALUES (1846, 111, 1036, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', 0);
INSERT INTO system_role_menu VALUES (1847, 111, 1037, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', 0);
INSERT INTO system_role_menu VALUES (1848, 111, 1038, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', 0);
INSERT INTO system_role_menu VALUES (1849, 111, 1039, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', 0);
INSERT INTO system_role_menu VALUES (1850, 111, 107, '1', '2022-09-21 22:48:13', '1', '2022-09-21 22:48:13', 0);
INSERT INTO system_role_menu VALUES (1851, 114, 1, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1852, 114, 1036, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1853, 114, 1037, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1854, 114, 1038, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1855, 114, 1039, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1856, 114, 100, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1857, 114, 101, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1858, 114, 1063, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1859, 114, 103, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1860, 114, 1064, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1861, 114, 1001, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1862, 114, 1065, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1863, 114, 1002, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1864, 114, 1003, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1865, 114, 107, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1866, 114, 1004, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1867, 114, 1005, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1868, 114, 1006, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1869, 114, 1007, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1870, 114, 1008, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1871, 114, 1009, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1872, 114, 1010, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1873, 114, 1011, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1874, 114, 1012, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1875, 114, 1017, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1876, 114, 1018, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1877, 114, 1019, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1878, 114, 1020, '1', '2022-12-30 11:32:03', '1', '2022-12-30 11:32:03', 0);
INSERT INTO system_role_menu VALUES (1879, 115, 1, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1880, 115, 1036, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1881, 115, 1037, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1882, 115, 1038, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1883, 115, 1039, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1884, 115, 100, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1885, 115, 101, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1886, 115, 1063, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1887, 115, 103, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1888, 115, 1064, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1889, 115, 1001, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1890, 115, 1065, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1891, 115, 1002, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1892, 115, 1003, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1893, 115, 107, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1894, 115, 1004, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1895, 115, 1005, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1896, 115, 1006, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1897, 115, 1007, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1898, 115, 1008, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1899, 115, 1009, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1900, 115, 1010, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1901, 115, 1011, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1902, 115, 1012, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1903, 115, 1017, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1904, 115, 1018, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1905, 115, 1019, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1906, 115, 1020, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_role_menu VALUES (1907, 116, 1, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1908, 116, 1036, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1909, 116, 1037, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1910, 116, 1038, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1911, 116, 1039, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1912, 116, 100, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1913, 116, 101, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1914, 116, 1063, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1915, 116, 103, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1916, 116, 1064, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1917, 116, 1001, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1918, 116, 1065, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1919, 116, 1002, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1920, 116, 1003, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1921, 116, 107, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1922, 116, 1004, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1923, 116, 1005, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1924, 116, 1006, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1925, 116, 1007, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1926, 116, 1008, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1927, 116, 1009, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1928, 116, 1010, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1929, 116, 1011, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1930, 116, 1012, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1931, 116, 1017, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1932, 116, 1018, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1933, 116, 1019, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1934, 116, 1020, '1', '2022-12-30 11:33:48', '1', '2022-12-30 11:33:48', 0);
INSERT INTO system_role_menu VALUES (1963, 118, 1, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1964, 118, 1036, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1965, 118, 1037, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1966, 118, 1038, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1967, 118, 1039, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1968, 118, 100, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1969, 118, 101, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1970, 118, 1063, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1971, 118, 103, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1972, 118, 1064, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1973, 118, 1001, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1974, 118, 1065, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1975, 118, 1002, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1976, 118, 1003, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1977, 118, 107, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1978, 118, 1004, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1979, 118, 1005, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1980, 118, 1006, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1981, 118, 1007, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1982, 118, 1008, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1983, 118, 1009, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1984, 118, 1010, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1985, 118, 1011, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1986, 118, 1012, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1987, 118, 1017, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1988, 118, 1018, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1989, 118, 1019, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1990, 118, 1020, '1', '2022-12-30 11:47:52', '1', '2022-12-30 11:47:52', 0);
INSERT INTO system_role_menu VALUES (1991, 2, 1024, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (1992, 2, 1025, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (1993, 2, 1026, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (1994, 2, 1027, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (1995, 2, 1028, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (1996, 2, 1029, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (1997, 2, 1030, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (1998, 2, 1031, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (1999, 2, 1032, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2000, 2, 1033, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2001, 2, 1034, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2002, 2, 1035, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2007, 2, 1040, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2008, 2, 1042, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2009, 2, 1043, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2010, 2, 1045, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2011, 2, 1046, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2012, 2, 1048, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2013, 2, 1050, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2014, 2, 1051, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2015, 2, 1052, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2016, 2, 1053, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2017, 2, 1054, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2024, 2, 1063, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2025, 2, 1064, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2026, 2, 1065, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2027, 2, 1066, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2028, 2, 1067, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2034, 2, 1075, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2036, 2, 1082, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2037, 2, 1085, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2038, 2, 1086, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2039, 2, 1087, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2040, 2, 1088, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2041, 2, 1089, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2042, 2, 1091, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2043, 2, 1092, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2056, 2, 1111, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2057, 2, 1112, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2058, 2, 1113, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2059, 2, 1114, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2060, 2, 1115, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2072, 2, 114, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2076, 2, 116, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2103, 2, 1237, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2104, 2, 1238, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2105, 2, 1239, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2106, 2, 1240, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2107, 2, 1241, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2108, 2, 1242, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2109, 2, 1243, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2110, 2, 1247, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2111, 2, 1248, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2112, 2, 1249, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2113, 2, 1250, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2114, 2, 1251, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2115, 2, 1252, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2117, 2, 1255, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2118, 2, 1256, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2119, 2, 1257, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2120, 2, 1258, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2121, 2, 1259, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2122, 2, 1260, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2123, 2, 1261, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2124, 2, 1263, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2125, 2, 1264, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2126, 2, 1265, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2127, 2, 1266, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2128, 2, 1267, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2129, 2, 1001, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2132, 2, 1004, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2133, 2, 1005, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2134, 2, 1006, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2135, 2, 1007, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2136, 2, 1008, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2137, 2, 1009, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2138, 2, 1010, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2139, 2, 1011, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2140, 2, 1012, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2141, 2, 1013, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2142, 2, 1014, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2143, 2, 1015, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2144, 2, 1016, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2145, 2, 1017, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2146, 2, 1018, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2147, 2, 1019, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2148, 2, 1020, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2149, 2, 1021, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2150, 2, 1022, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);
INSERT INTO system_role_menu VALUES (2151, 2, 1023, '1', '2023-01-25 08:42:52', '1', '2023-01-25 08:42:52', 0);

INSERT INTO system_user_post VALUES (120, 1, 5, '1', '2023-06-25 17:05:02', '1', '2023-06-25 17:05:02', 0);
INSERT INTO system_user_post VALUES (121, 1, 6, '1', '2023-06-25 17:05:02', '1', '2023-06-25 17:05:02', 0);


INSERT INTO system_user_role VALUES (1, 1, 1, '', '2022-01-11 13:19:45', '', '2022-05-12 12:35:17', 0);
INSERT INTO system_user_role VALUES (2, 2, 2, '', '2022-01-11 13:19:45', '', '2022-05-12 12:35:13', 0);
INSERT INTO system_user_role VALUES (23, 119, 114, '1', '2022-12-30 11:32:04', '1', '2022-12-30 11:32:04', 0);
INSERT INTO system_user_role VALUES (24, 120, 115, '1', '2022-12-30 11:33:42', '1', '2022-12-30 11:33:42', 0);
INSERT INTO system_user_role VALUES (25, 121, 116, '1', '2022-12-30 11:33:49', '1', '2022-12-30 11:33:49', 0);
INSERT INTO system_user_role VALUES (26, 122, 118, '1', '2022-12-30 11:47:53', '1', '2022-12-30 11:47:53', 0);
INSERT INTO system_user_role VALUES (28, 123, 2, '1', '2023-06-28 16:06:24', '1', '2023-06-28 16:06:24', 0);

INSERT INTO system_users VALUES (123, 'common', '$2a$10$rTlx73/OagZdige6VrUbtOVAZUDmQMUAob/gLcV2Y92n4UWySIqUS', 'common', NULL, 116, '[]', '', '', 1, '', 0, '127.0.0.1', '2023-06-28 16:06:39', '1', '2023-06-28 16:05:30', '1', '2023-07-03 17:40:48', 0);
INSERT INTO system_users VALUES (1, 'admin', '$2a$10$zucG3ejGtYR3usu3DJMnruRTE5yb9J8MxSjq8vyozx.x/jZrQjh0m', 'admin', '系统管理员', 100, '[5,6]', 'xxx@beacon.com', '18888888889', 1, '', 0, '0:0:0:0:0:0:0:1', '2026-06-15 21:51:12.812', 'admin', '2021-01-05 17:03:47', NULL, '2026-06-15 21:51:12.817', 0);


ALTER TABLE ONLY infra_api_access_log
    ADD CONSTRAINT infra_api_access_log_pkey PRIMARY KEY (id);


ALTER TABLE ONLY infra_api_error_log
    ADD CONSTRAINT infra_api_error_log_pkey PRIMARY KEY (id);


ALTER TABLE ONLY infra_codegen_column
    ADD CONSTRAINT infra_codegen_column_pkey PRIMARY KEY (id);


ALTER TABLE ONLY infra_codegen_table
    ADD CONSTRAINT infra_codegen_table_pkey PRIMARY KEY (id);


ALTER TABLE ONLY infra_config
    ADD CONSTRAINT infra_config_pkey PRIMARY KEY (id);


ALTER TABLE ONLY infra_data_source_config
    ADD CONSTRAINT infra_data_source_config_pkey PRIMARY KEY (id);


ALTER TABLE ONLY infra_file_config
    ADD CONSTRAINT infra_file_config_pkey PRIMARY KEY (id);


ALTER TABLE ONLY infra_file_content
    ADD CONSTRAINT infra_file_content_pkey PRIMARY KEY (id);


ALTER TABLE ONLY infra_file
    ADD CONSTRAINT infra_file_pkey PRIMARY KEY (id);


ALTER TABLE ONLY infra_job_log
    ADD CONSTRAINT infra_job_log_pkey PRIMARY KEY (id);


ALTER TABLE ONLY infra_job
    ADD CONSTRAINT infra_job_pkey PRIMARY KEY (id);


ALTER TABLE ONLY infra_test_demo
    ADD CONSTRAINT infra_test_demo_pkey PRIMARY KEY (id);


ALTER TABLE ONLY qrtz_blob_triggers
    ADD CONSTRAINT qrtz_blob_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


ALTER TABLE ONLY qrtz_calendars
    ADD CONSTRAINT qrtz_calendars_pkey PRIMARY KEY (sched_name, calendar_name);


ALTER TABLE ONLY qrtz_cron_triggers
    ADD CONSTRAINT qrtz_cron_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


ALTER TABLE ONLY qrtz_fired_triggers
    ADD CONSTRAINT qrtz_fired_triggers_pkey PRIMARY KEY (sched_name, entry_id);


ALTER TABLE ONLY qrtz_job_details
    ADD CONSTRAINT qrtz_job_details_pkey PRIMARY KEY (sched_name, job_name, job_group);


ALTER TABLE ONLY qrtz_locks
    ADD CONSTRAINT qrtz_locks_pkey PRIMARY KEY (sched_name, lock_name);


ALTER TABLE ONLY qrtz_paused_trigger_grps
    ADD CONSTRAINT qrtz_paused_trigger_grps_pkey PRIMARY KEY (sched_name, trigger_group);


ALTER TABLE ONLY qrtz_scheduler_state
    ADD CONSTRAINT qrtz_scheduler_state_pkey PRIMARY KEY (sched_name, instance_name);


ALTER TABLE ONLY qrtz_simple_triggers
    ADD CONSTRAINT qrtz_simple_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


ALTER TABLE ONLY qrtz_simprop_triggers
    ADD CONSTRAINT qrtz_simprop_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


ALTER TABLE ONLY qrtz_triggers
    ADD CONSTRAINT qrtz_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


ALTER TABLE ONLY system_dept
    ADD CONSTRAINT system_dept_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_dict_data
    ADD CONSTRAINT system_dict_data_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_dict_type
    ADD CONSTRAINT system_dict_type_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_error_code
    ADD CONSTRAINT system_error_code_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_login_log
    ADD CONSTRAINT system_login_log_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_menu
    ADD CONSTRAINT system_menu_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_notice
    ADD CONSTRAINT system_notice_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_oauth2_access_token
    ADD CONSTRAINT system_oauth2_access_token_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_oauth2_approve
    ADD CONSTRAINT system_oauth2_approve_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_oauth2_client
    ADD CONSTRAINT system_oauth2_client_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_oauth2_code
    ADD CONSTRAINT system_oauth2_code_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_oauth2_refresh_token
    ADD CONSTRAINT system_oauth2_refresh_token_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_operate_log
    ADD CONSTRAINT system_operate_log_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_post
    ADD CONSTRAINT system_post_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_role_menu
    ADD CONSTRAINT system_role_menu_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_role
    ADD CONSTRAINT system_role_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_sensitive_word
    ADD CONSTRAINT system_sensitive_word_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_users
    ADD CONSTRAINT system_user_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_user_post
    ADD CONSTRAINT system_user_post_pkey PRIMARY KEY (id);


ALTER TABLE ONLY system_user_role
    ADD CONSTRAINT system_user_role_pkey PRIMARY KEY (id);


CREATE UNIQUE INDEX dict_type ON system_dict_type USING btree (type);


CREATE INDEX idx_qrtz_ft_inst_job_req_rcvry ON qrtz_fired_triggers USING btree (sched_name, instance_name, requests_recovery);


CREATE INDEX idx_qrtz_ft_j_g ON qrtz_fired_triggers USING btree (sched_name, job_name, job_group);


CREATE INDEX idx_qrtz_ft_jg ON qrtz_fired_triggers USING btree (sched_name, job_group);


CREATE INDEX idx_qrtz_ft_t_g ON qrtz_fired_triggers USING btree (sched_name, trigger_name, trigger_group);


CREATE INDEX idx_qrtz_ft_tg ON qrtz_fired_triggers USING btree (sched_name, trigger_group);


CREATE INDEX idx_qrtz_ft_trig_inst_name ON qrtz_fired_triggers USING btree (sched_name, instance_name);


CREATE INDEX idx_qrtz_j_grp ON qrtz_job_details USING btree (sched_name, job_group);


CREATE INDEX idx_qrtz_j_req_recovery ON qrtz_job_details USING btree (sched_name, requests_recovery);


CREATE INDEX idx_qrtz_t_c ON qrtz_triggers USING btree (sched_name, calendar_name);


CREATE INDEX idx_qrtz_t_g ON qrtz_triggers USING btree (sched_name, trigger_group);


CREATE INDEX idx_qrtz_t_j ON qrtz_triggers USING btree (sched_name, job_name, job_group);


CREATE INDEX idx_qrtz_t_jg ON qrtz_triggers USING btree (sched_name, job_group);


CREATE INDEX idx_qrtz_t_n_g_state ON qrtz_triggers USING btree (sched_name, trigger_group, trigger_state);


CREATE INDEX idx_qrtz_t_n_state ON qrtz_triggers USING btree (sched_name, trigger_name, trigger_group, trigger_state);


CREATE INDEX idx_qrtz_t_next_fire_time ON qrtz_triggers USING btree (sched_name, next_fire_time);


CREATE INDEX idx_qrtz_t_nft_misfire ON qrtz_triggers USING btree (sched_name, misfire_instr, next_fire_time);


CREATE INDEX idx_qrtz_t_nft_st ON qrtz_triggers USING btree (sched_name, trigger_state, next_fire_time);


CREATE INDEX idx_qrtz_t_nft_st_misfire ON qrtz_triggers USING btree (sched_name, misfire_instr, next_fire_time, trigger_state);


CREATE INDEX idx_qrtz_t_nft_st_misfire_grp ON qrtz_triggers USING btree (sched_name, misfire_instr, next_fire_time, trigger_group, trigger_state);


CREATE INDEX idx_qrtz_t_state ON qrtz_triggers USING btree (sched_name, trigger_state);


ALTER TABLE ONLY qrtz_blob_triggers
    ADD CONSTRAINT qrtz_blob_triggers_sched_name_trigger_name_trigger_group_fkey FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES qrtz_triggers(sched_name, trigger_name, trigger_group);


ALTER TABLE ONLY qrtz_cron_triggers
    ADD CONSTRAINT qrtz_cron_triggers_sched_name_trigger_name_trigger_group_fkey FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES qrtz_triggers(sched_name, trigger_name, trigger_group);


ALTER TABLE ONLY qrtz_simple_triggers
    ADD CONSTRAINT qrtz_simple_triggers_sched_name_trigger_name_trigger_group_fkey FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES qrtz_triggers(sched_name, trigger_name, trigger_group);


ALTER TABLE ONLY qrtz_simprop_triggers
    ADD CONSTRAINT qrtz_simprop_triggers_sched_name_trigger_name_trigger_grou_fkey FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES qrtz_triggers(sched_name, trigger_name, trigger_group);


ALTER TABLE ONLY qrtz_triggers
    ADD CONSTRAINT qrtz_triggers_sched_name_job_name_job_group_fkey FOREIGN KEY (sched_name, job_name, job_group) REFERENCES qrtz_job_details(sched_name, job_name, job_group);