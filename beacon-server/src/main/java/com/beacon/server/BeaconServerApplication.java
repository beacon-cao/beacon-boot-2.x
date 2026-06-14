package com.beacon.server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 项目的启动类
 *
 * @author Beacon
 */
@SpringBootApplication(scanBasePackages = {"${framework.info.base-package}.server","${framework.info.base-package}.business"})
public class BeaconServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(BeaconServerApplication.class, args);
    }

}
