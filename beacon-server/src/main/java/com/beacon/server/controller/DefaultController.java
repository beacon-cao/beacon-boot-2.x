package com.beacon.server.controller;

import org.springframework.web.bind.annotation.PostMapping;
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
    @PostMapping("/hello")
    public String hello() {
        return "hi";
    }


}
