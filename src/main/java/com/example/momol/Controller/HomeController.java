package com.example.momol.Controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.Base64;

@Controller
public class HomeController {

    @RequestMapping("/")
    public ModelAndView homeControl(HttpServletRequest request, HttpSession session){
        ModelAndView mv = new ModelAndView();

        String login = (String) session.getAttribute("login");

        System.out.println(request.getContextPath());

        mv.setViewName("index");

        return mv;
    }


}
