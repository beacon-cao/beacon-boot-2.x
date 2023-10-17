package com.beacon.framework.web.core.filter;

import cn.hutool.core.util.StrUtil;
import com.beacon.framework.common.util.servlet.ServletUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Request Body 缓存 Filter，实现它的可重复读取
 *
 * @author Beacon
 */
public class CacheRequestBodyFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws IOException, ServletException {
        filterChain.doFilter(new CacheRequestBodyWrapper(request), response);
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {

        //不缓存 springboot admin 的请求
        String requestURI = request.getRequestURI();
        if (StrUtil.startWith(requestURI, "/admin/instance")) {
            return true;
        }

        // 判断请求内容是否为 json ，只处理 json 请求内容
        return !ServletUtils.isJsonRequest(request);
    }

}
