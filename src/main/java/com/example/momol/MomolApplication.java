package com.example.momol;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class MomolApplication {

    public static void main(String[] args) {
        SpringApplication.run(MomolApplication.class, args);
        System.out.println("http://localhost:8080");
    }

}
