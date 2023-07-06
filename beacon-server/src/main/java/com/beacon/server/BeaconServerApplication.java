package com.beacon.server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 项目的启动类
 *
 * @author Beacon
 */
//关闭idea的提示
@SuppressWarnings("SpringComponentScan")
//SpringBoot启动类
@SpringBootApplication(scanBasePackages = {"${framework.info.base-package}.server","${framework.info.base-package}.business"})
public class BeaconServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(BeaconServerApplication.class, args);
    }

}
