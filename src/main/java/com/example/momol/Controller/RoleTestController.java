package com.example.momol.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RoleTestController {
    @GetMapping("/admin/role")
    public String adminTest(){
        return "index";
    }
}
