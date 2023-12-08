package com.example.momol.Controller;

import com.example.momol.DTO.UserVO;
import com.example.momol.Service.AdminService;
import com.example.momol.Service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;


@Controller
public class AdminController {


    private UserService userService;
    private final AdminService adminService;

    @Autowired
    public AdminController(UserService userService, AdminService adminService) {
        // this.userService = userService;
        this.adminService = adminService;
    }

    //관리자 페이지 홈
    @GetMapping ("/admin")
    public ModelAndView admin() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("Admin/admin_home");
        return mv;
    }

    //유저관리
    @GetMapping ("/admin/user")
    public ModelAndView admin_user(UserVO in) {
        ModelAndView mv = new ModelAndView();

        try {
            //유저 정보 가져오는거
            // UserVO vo = adminService.user_list(in);
            List<UserVO> vo = adminService.user_list(in);
            // System.out.println(vo.toString());
            // System.out.println("JoinDate from Controller: " + vo.get(0).getJoinDate()); // Check the first UserVO's JoinDate
            mv.addObject("user", vo);

        } catch (Exception e) {
            e.printStackTrace();
        }

        mv.setViewName("Admin/admin_user");
        return mv;
    }

    //유저 - 유저정보 수정
    @RequestMapping("/admin/useredit")
    public ModelAndView admin_useredit(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelAndView mv = new ModelAndView();

        try {
            request.getParameter("userid");
            request.getParameter("usernick");
            mv.addObject("userid", request.getParameter("userid"));
            mv.addObject("usernick", request.getParameter("usernick"));

        } catch (Exception e) {
            e.printStackTrace();
        }

        mv.setViewName("Admin/admin_user_edit");
        return mv;
    }

    @PostMapping("/admin/usernickedit")
    public ModelAndView admin_usernickedit(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelAndView mv = new ModelAndView();


        try {
            String usernick = request.getParameter("usernick");
            String userid = request.getParameter("userid");
            System.out.println("들어온 값");
            System.out.println("usernick: " + usernick);
            System.out.println("userid: " + userid);

            int result;

            if (usernick != null && !usernick.isEmpty() && userid != null && !userid.isEmpty()) {
                try {
                    result = adminService.nick_edit(usernick, userid);
                } catch (Exception e) {
                    e.printStackTrace();
                    System.out.println("닉네임 수정 실패");
                    result = 0;
                }
                System.out.println("reslut : "+result);
                mv.addObject("result", result);

            } else {
                // Handle invalid input or missing parameters
                System.out.println("Invalid input: usernick or userid is missing or empty.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        mv.setViewName("Admin/admin_user_editOK");
        return mv;
    }


    // 유저 - 유저정보 삭제
    @RequestMapping  ("/admin/userdel")
    public ModelAndView admin_user_delete(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ModelAndView mv = new ModelAndView();

        try {

            String id = request.getParameter("userid");
            System.out.println("들어온 id: " + id);

            int result = adminService.user_delete(id);
            System.out.println("result: " + result);

            mv.addObject("result", result);

        }catch (Exception e) {
            e.printStackTrace();
        }

        mv.setViewName("Admin/admin_user_delete");
        return mv;
    }

    //게시글 관리
    @GetMapping ("/admin/board")
    public ModelAndView admin_board() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("Admin/admin_board");
        return mv;
    }

    //댓글관리
    @GetMapping ("/admin/comment")
    public ModelAndView admin_comment() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("Admin/admin_comment");
        return mv;
    }

    //레시피 관리
    @GetMapping ("/admin/recipe")
    public ModelAndView admin_recipe() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("Admin/admin_recipe");
        return mv;
    }

    //월드컵 관리
    @GetMapping ("/admin/worldcup")
    public ModelAndView admin_worldcup() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("Admin/admin_worldcup");
        return mv;
    }

    //재료관리
    @GetMapping ("/admin/ingredient")
    public ModelAndView ingredient() {
        ModelAndView mv = new ModelAndView();



        mv.setViewName("Admin/admin_ing");
        return mv;
    }

    // 신고 관리
    @GetMapping ("/admin/report")
    public ModelAndView admin_report() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("Admin/admin_declaration");
        return mv;
    }

    // 통계
    @GetMapping ("/admin/statistics")
    public ModelAndView admin_statistics() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("Admin/statistics");
        return mv;
    }

}
