package com.beacon.business.system.mq.consumer.permission;

import com.beacon.framework.mq.core.pubsub.AbstractChannelMessageListener;
import com.beacon.business.system.mq.message.permission.RoleMenuRefreshMessage;
import com.beacon.business.system.service.permission.PermissionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * 针对 {@link RoleMenuRefreshMessage} 的消费者
 * 使用mq调用初始化缓存方法的目的是确保项启动多个节点的缓存数据都可以刷新
 * @author Beacon
 */
@Component
@Slf4j
public class RoleMenuRefreshConsumer extends AbstractChannelMessageListener<RoleMenuRefreshMessage> {

    @Resource
    private PermissionService permissionService;

    @Override
    public void onMessage(RoleMenuRefreshMessage message) {
        log.info("[onMessage][收到 Role 与 Menu 的关联刷新消息]");
        permissionService.initLocalCache();
    }

}
