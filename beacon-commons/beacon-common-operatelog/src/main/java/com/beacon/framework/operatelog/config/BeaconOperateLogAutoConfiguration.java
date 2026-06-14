package com.beacon.framework.operatelog.config;

import com.beacon.framework.operatelog.core.aop.OperateLogAspect;
import com.beacon.framework.operatelog.core.service.OperateLogFrameworkService;
import com.beacon.framework.operatelog.core.service.OperateLogFrameworkServiceImpl;
import com.beacon.business.system.api.logger.OperateLogApi;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.context.annotation.Bean;

@AutoConfiguration
public class BeaconOperateLogAutoConfiguration {

    @Bean
    public OperateLogAspect operateLogAspect() {
        return new OperateLogAspect();
    }

    @Bean
    public OperateLogFrameworkService operateLogFrameworkService(OperateLogApi operateLogApi) {
        return new OperateLogFrameworkServiceImpl(operateLogApi);
    }

}
