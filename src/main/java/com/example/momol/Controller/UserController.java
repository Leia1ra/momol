package com.example.momol.Controller;

import com.example.momol.DTO.UserVO;
import com.example.momol.Service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/account")
public class UserController {
    @Autowired
    UserService service;

    @GetMapping("/login")
    public String login(){
        return "Account/Login";
    }

    @PostMapping("/loginOk")
    ModelAndView loginAction(UserVO in, HttpSession session){
        ModelAndView mav = new ModelAndView();
        System.out.println(in.getId());
        UserVO vo = service.userSelect(in);
        System.out.println(vo.toString());
        if(vo != null){
            mav.setViewName("redirect:/");
            session.setAttribute("logIn", "Y");
            session.setAttribute("logUID", vo.getUID());
            session.setAttribute("logNick", vo.getNick());
        } else {
            mav.setViewName("redirect:login");
        }

        return mav;
    }
}
