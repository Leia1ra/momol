package com.example.momol.Controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.net.http.HttpRequest;

@Controller
public class HomeController {

    @RequestMapping("/")
    public String homeControl(HttpServletRequest req){
        System.out.println(req.getContextPath());
        return "index";
    }
}
