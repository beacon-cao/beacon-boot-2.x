package com.beacon.framework.protection.idempotent.config;

import com.beacon.framework.protection.idempotent.core.aop.IdempotentAspect;
import com.beacon.framework.protection.idempotent.core.keyresolver.IdempotentKeyResolver;
import com.beacon.framework.protection.idempotent.core.keyresolver.impl.DefaultIdempotentKeyResolver;
import com.beacon.framework.protection.idempotent.core.keyresolver.impl.ExpressionIdempotentKeyResolver;
import com.beacon.framework.protection.idempotent.core.redis.IdempotentRedisDAO;
import com.beacon.framework.redis.config.RedisAutoConfiguration;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.data.redis.core.StringRedisTemplate;

import java.util.List;

@AutoConfiguration(after = RedisAutoConfiguration.class)
public class IdempotentConfiguration {

    @Bean
    public IdempotentAspect idempotentAspect(List<IdempotentKeyResolver> keyResolvers, IdempotentRedisDAO idempotentRedisDAO) {
        return new IdempotentAspect(keyResolvers, idempotentRedisDAO);
    }

    @Bean
    public IdempotentRedisDAO idempotentRedisDAO(StringRedisTemplate stringRedisTemplate) {
        return new IdempotentRedisDAO(stringRedisTemplate);
    }

    // ========== 各种 IdempotentKeyResolver Bean ==========

    @Bean
    public DefaultIdempotentKeyResolver defaultIdempotentKeyResolver() {
        return new DefaultIdempotentKeyResolver();
    }

    @Bean
    public ExpressionIdempotentKeyResolver expressionIdempotentKeyResolver() {
        return new ExpressionIdempotentKeyResolver();
    }

}
