package com.beacon.server.controller;

import com.beacon.framework.common.pojo.CommonResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.security.PermitAll;

import static com.beacon.framework.common.exception.enums.GlobalErrorCodeConstants.NOT_IMPLEMENTED;

/**
 * 默认 Controller，解决部分 module 未开启时的 404 提示。
 * 例如：/bpm/** 路径，工作流
 *
 * @author Beacon
 */
@RestController
public class DefaultController {

    @PermitAll
    @GetMapping("hello")
    public String hello() {
        return "hi";
    }

    @RequestMapping("/admin-api/bpm/**")
    public CommonResult<Boolean> bpm404() {
        return CommonResult.error(NOT_IMPLEMENTED.getCode(), "[工作流模块已禁用][请参考文档开启]");
    }

}
