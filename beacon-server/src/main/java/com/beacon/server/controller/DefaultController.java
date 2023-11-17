package com.beacon.server.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.security.PermitAll;

/**
 * 默认 Controller，解决部分 module 未开启时的 404 提示。
 *
 * @author Beacon
 */
@RestController
public class DefaultController {

    @PermitAll
    @GetMapping("/hello")
    public String hello() {
        return "hi";
    }


}
