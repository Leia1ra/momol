package com.example.momol.Controller;

import com.example.momol.DTO.UserVO;
import com.example.momol.Service.MypageService;
import com.example.momol.Service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/mmypage")
public class MypageController {
    @Autowired
    MypageService service;

    @GetMapping("/mypage")
    ModelAndView mypage(HttpSession session){
        ModelAndView mav = new ModelAndView();
        if("Y".equals(session.getAttribute("logIn"))){
            UserVO vo = new UserVO();
            vo = service.userSelectbyUID((String) session.getAttribute("logUID"));

            mav.addObject("user", vo);
            mav.setViewName("Mypage/mypage");
        }
        return mav;
    }
//주석
    @PostMapping("/mypageOk")
    ModelAndView updateUserInfo(UserVO updatedUser, HttpSession session) {

        System.out.println(updatedUser.toString());
        ModelAndView mav = new ModelAndView();

        // 현재 로그인한 사용자의 UID를 가져와서 UserVO에 설정

        String logUID = (String) session.getAttribute("logUID");
        updatedUser.setUID(logUID);

        System.out.println(updatedUser.toString());

        // 업데이트된 정보를 데이터베이스에 반영
        service.updateUser(updatedUser);

        // 업데이트된 정보를 다시 조회하여 화면에 표시
        UserVO vo = service.userSelectbyUID(logUID);

        mav.addObject("user", vo);
        mav.setViewName("Mypage/mypage");

        return mav;
    }

}
