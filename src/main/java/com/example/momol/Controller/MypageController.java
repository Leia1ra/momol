package com.example.momol.Controller;

import com.example.momol.DTO.CommunityVO;
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

import java.util.List;

@Controller
@RequestMapping("/mmypage")
public class MypageController {

    @Autowired
    MypageService service;

    //마이페이지
    @GetMapping("/mypage")
    public ModelAndView mypage(HttpSession session){
        ModelAndView mav = new ModelAndView();

        if("Y".equals(session.getAttribute("logIn"))){
            UserVO vo = new UserVO();
            vo = service.userSelectbyUID((String) session.getAttribute("logUID"));

            String userUID = (String) session.getAttribute("logUID");
            //본인이 작성한 게시글 불러오기
            try {
                List<CommunityVO> postList = service.my_post(userUID);
                System.out.println("postList : " + postList.toString());
                mav.addObject("postList", postList);
            } catch (Exception e) {
                e.printStackTrace();
            }


            mav.addObject("user", vo);
        }
        mav.setViewName("Mypage/mypage");
        return mav;
    }

    // 마이페이지 정보 수정
    @PostMapping("/mypageOk")
    ModelAndView updateUserInfo(UserVO updatedUser, HttpSession session) {

        System.out.println(updatedUser.toString());
        ModelAndView mav = new ModelAndView();

        // 현재 로그인한 사용자의 UID를 가져와서 UserVO에 설정
        String logUID = (String) session.getAttribute("logUID");
        updatedUser.setUID(logUID);
        System.out.println(updatedUser.toString());

        try {
            // 업데이트된 정보를 데이터베이스에 반영
            int result = service.updateUser(updatedUser);

            // 업데이트된 정보를 다시 조회하여 화면에 표시
            UserVO vo = service.userSelectbyUID(logUID);

            mav.addObject("user", vo);
            mav.setViewName("Mypage/mypage");

        } catch (Exception e) {
            //회원정보 수정 실패시 다시 마이페이지로 이동
            e.printStackTrace();
            mav.setViewName("Mypage/mypageUpdateFail");
        }

        return mav;
    }

}
