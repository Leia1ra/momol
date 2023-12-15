package com.example.momol.Controller;

import com.example.momol.DTO.*;
import com.example.momol.Service.AdminService;
import com.example.momol.Service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;


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
    @GetMapping("/admin")
    public ModelAndView admin() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("Admin/admin_home");
        return mv;
    }

    // -----------------------------------------------

    //유저관리
    @GetMapping("/admin/user")
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

    //유저 - 유저정보 수정 (완)
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

    //유저 닉네임 변경 (완)
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

            if (usernick != null && ! usernick.isEmpty() && userid != null && ! userid.isEmpty()) {
                try {
                    result = adminService.nick_edit(usernick, userid);
                } catch (Exception e) {
                    e.printStackTrace();
                    System.out.println("닉네임 수정 실패");
                    result = 0;
                }
                System.out.println("reslut : " + result);
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


    // 유저 - 유저정보 삭제 (완)
    @RequestMapping("/admin/userdel")
    public ModelAndView admin_user_delete(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();

        try {

            String id = request.getParameter("userid");
            System.out.println("들어온 id: " + id);

            int result = adminService.user_delete(id);
            System.out.println("result: " + result);

            mv.addObject("result", result);

        } catch (Exception e) {
            e.printStackTrace();
        }

        mv.setViewName("Admin/admin_user_delete");
        return mv;
    }

    // -----------------------------------------------

    //게시글 관리
    @GetMapping("/admin/board")
    public ModelAndView admin_board() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("Admin/admin_board");
        return mv;
    }

    // -----------------------------------------------

    //댓글관리
    @GetMapping("/admin/comment")
    public ModelAndView admin_comment() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("Admin/admin_comment");
        return mv;
    }

    // -----------------------------------------------

    //레시피 관리
    @GetMapping("/admin/recipe")
    public ModelAndView admin_recipe(CocktailVO in) {
        ModelAndView mv = new ModelAndView();

        try {

            List<CocktailVO> vo = adminService.cocktail_list(in);
            // System.out.println(vo.toString());
            mv.addObject("cocktail", vo);

        } catch (Exception e) {
            e.printStackTrace();
        }

        mv.setViewName("Admin/admin_recipe");
        return mv;
    }

    //레시피 추가
    @RequestMapping("/admin/recipeAdd")
    public void recipeAdd ( HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        System.out.println("recipeAdd 들어옴");

        try {
            String name =  request.getParameter("cocktail_name");
            String name_eng = request.getParameter("cocktail_name_eng");
            String abv = request.getParameter("cocktail_abv");
            String recipe = request.getParameter("cocktail_recipe");
            String cocktail_img = request.getParameter("cocktail_img");
            String cocktail_detail = request.getParameter("cocktail_des");

            CocktailVO vo = new CocktailVO();
            vo.setName(name);
            vo.setName_eng(name_eng);
            vo.setABV(Float.parseFloat(abv));
            vo.setCocktail_detail(cocktail_detail);
            vo.setRecipe(recipe);
            vo.setCocktail_img(cocktail_img);

            System.out.println(vo.toString());

            int result = adminService.cocktail_add(vo);
            System.out.println("결과 : "+result);

            //ajax 통신 JSON 작성
            ObjectMapper mapper = new ObjectMapper();
            String json = "";

            try {
                json = mapper.writeValueAsString(result);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().print(json);
            } catch (Exception e) {
                System.out.println("json 변환 실패");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @RequestMapping("/admin/recipeEdit")
    public ModelAndView recipeEdit ( HttpServletRequest request, HttpServletResponse respon ) {
        ModelAndView mv = new ModelAndView();
        System.out.println("recipe edit 들어옴");
        try {
            String name = request.getParameter("cocktail_name");
            System.out.println("name : " + name);

            // 서비스로 나머지 정보 불러오기
            CocktailVO vo = adminService.cocktail_edit_load(name);
            System.out.println("vo : " + vo.toString());

            mv.addObject("cocktail", vo);

        } catch (Exception e) {
            e.printStackTrace();
        }

        mv.setViewName("Admin/recipeEdit");

        return mv;

    }

    @RequestMapping ("/admin/recipeEditSubmit")
    public void recipeEditSubmit ( HttpServletRequest request, HttpServletResponse response ) {
        System.out.println("recipeEditSubmit 들어옴");

        try {

            String name = request.getParameter("name");
            String name_eng = request.getParameter("name_eng");
            String abv = request.getParameter("ABV");
            String detail = request.getParameter("cocktail_detail");
            String recipe = request.getParameter("recipe");
            String img = request.getParameter("cocktail_img");

            System.out.println(name + name_eng + abv + detail + recipe + img);

            CocktailVO vo = new CocktailVO();
            vo.setName(name);
            vo.setName_eng(name_eng);
            vo.setABV(Float.parseFloat(abv));
            vo.setCocktail_detail(detail);
            vo.setRecipe(recipe);
            vo.setCocktail_img(img);

            System.out.println(vo.toString());

            int result = adminService.cocktail_edit_submit(vo);
            System.out.println("결과 : "+result);

            //ajax 통신 JSON 작성
            ObjectMapper mapper = new ObjectMapper();
            String json = "";

            try {
                json = mapper.writeValueAsString(result);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().print(json);
            } catch (Exception e) {
                System.out.println("json 변환 실패");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @RequestMapping ("/admin/recipeDel")
    public void recipeDel ( HttpServletRequest request, HttpServletResponse response ) {
        System.out.println("recipeDel 들어옴");

        try {
            String name = request.getParameter("cocktail_name");
            System.out.println("name : " + name);

            int result = adminService.cocktail_del(name);
            System.out.println("결과 : "+result);

            //ajax 통신 JSON 작성
            ObjectMapper mapper = new ObjectMapper();
            String json = "";

            try {
                json = mapper.writeValueAsString(result);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().print(json);
            } catch (Exception e) {
                System.out.println("json 변환 실패");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    // -----------------------------------------------

    //재료 관리
    @GetMapping("/admin/ingredient")
    public ModelAndView ingredient(IngrVO in) {
        ModelAndView mv = new ModelAndView();

        try {
            List<IngrVO> vo = adminService.ingre_list(in);
            // System.out.println(vo.toString());
            mv.addObject("ingre", vo);

        } catch (Exception e) {
            e.printStackTrace();
        }

        mv.setViewName("Admin/admin_ing");
        return mv;
    }

    //재료 추가 ingre add
    @RequestMapping(value = "/admin/ingreadd", method = {RequestMethod.GET, RequestMethod.POST})
    public void add_ingre ( HttpServletRequest request, HttpServletResponse response) {
        // ModelAndView mv = new ModelAndView();
        System.out.println("add_ingre 들어옴");

        try {
            // 받아온 값
            String ing_name = request.getParameter("ing_name");
            String ing_name_eng = request.getParameter("ing_name_eng");
            String ing_photo = request.getParameter("ing_photo");
            String ing_detail = request.getParameter("ing_detail");
            String ing_categ = request.getParameter("ing_categ");
            String abv = request.getParameter("abv");

            // 술 제외하고는 도수를 null로 처리
            if ( (ing_categ != "강한도수")  || (ing_categ !="약한도수") ) {
                System.out.println("술아님 :" + ing_categ);
                abv = "0";
            } else {
                System.out.println("카테고리 :" + ing_categ );
            }

            System.out.println(ing_name + ing_name_eng + ing_photo + ing_detail + ing_categ + abv);

            IngrVO vo = new IngrVO();
            vo.setIng_name(ing_name);
            vo.setIng_name_eng(ing_name_eng);
            vo.setIng_photo(ing_photo);
            vo.setIng_detail(ing_detail);
            vo.setIng_categ(ing_categ);
            vo.setAbv(Integer.valueOf(abv));

            System.out.println("vo : " + vo.toString());

            int result = adminService.ingre_add(vo);
            System.out.println(result);
            // 검색결과를 json 변환
            ObjectMapper mapper = new ObjectMapper();
            String json = "";
            try {
                json = mapper.writeValueAsString(result);

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().print(json);

            } catch (Exception e) {
                System.out.println("json 변환 실패");
            }


        } catch (Exception e) {
            e.printStackTrace();
        }

        // return mv;
    }

    //재료수정 진입 - ingre edit
    @RequestMapping(value = "/admin/ingreedit", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView ingreEdit(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mv = new ModelAndView();
        System.out.println("ingreEdit 들어옴");

        try {
            String num = request.getParameter("ing_num");
            IngrVO vo = adminService.ingre_edit_load(num);

            System.out.println("vo : " + vo.toString());

            mv.addObject("ingre", vo);

        } catch (Exception e) {
            e.printStackTrace();
        }

        mv.setViewName("Admin/ingre_edit");

        return mv;

    };

    //재료수정 submit
    @RequestMapping(value = "/admin/ingreadd_submit", method = {RequestMethod.GET, RequestMethod.POST})
    public void ingreSubmit ( HttpServletRequest request, HttpServletResponse response) {
        System.out.println("ingreSubmit 들어옴");

        try {

            IngrVO vo = new IngrVO();
            vo.setIng_num(request.getParameter("ing_num"));
            vo.setIng_name(request.getParameter("ing_name"));
            vo.setIng_name_eng(request.getParameter("ing_name_eng"));
            vo.setIng_photo(request.getParameter("ing_photo"));
            vo.setIng_detail(request.getParameter("ing_detail"));
            vo.setIng_categ(request.getParameter("ing_categ"));
            vo.setAbv(Integer.valueOf(request.getParameter("abv")));

            System.out.println("vo : " + vo.toString());

            int result = adminService.ingre_edit_submit(vo);

            //JSON 작성
            ObjectMapper mapper = new ObjectMapper();
            String json = "";

            try {
                json = mapper.writeValueAsString(result);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().print(json);
            } catch (Exception e) {
                System.out.println("json 변환 실패");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    //재료 삭제하기 ingre del (완)
    @RequestMapping(value = "/admin/ingredel", method = {RequestMethod.GET, RequestMethod.POST})
    public void ingreDel ( HttpServletRequest request, HttpServletResponse response) {
        System.out.println("ingreDel 들어옴");

        try {
            String num = request.getParameter("ing_num");
            System.out.println("num : " + num);

            int result = adminService.ingre_del(num);

            //JSON 작성
            ObjectMapper mapper = new ObjectMapper();
            String json = "";

            try {
                json = mapper.writeValueAsString(result);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().print(json);
            } catch (Exception e) {
                System.out.println("json 변환 실패");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // -----------------------------------------------

    //월드컵 관리
    @GetMapping ("/admin/worldcup")
    public ModelAndView admin_worldcup() {
        ModelAndView mv = new ModelAndView();

        mv.setViewName("Admin/admin_worldcup");
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

        LocalDate today = LocalDate.now();
        List<LocalDate> dayList = new ArrayList<>();

        int[] count_news = new int[10];

        //열흘
        for ( int i = 9; i >= 0; i-- ) {
            LocalDate day = today.minusDays(i);
            dayList.add(day);
        }

        System.out.println("dayList : " + dayList.toString());
        mv.addObject("dayList", dayList.toString());

        for ( int i = 0; i < dayList.size(); i++  ) {
            int y = dayList.get(i).getYear();
            int m = dayList.get(i).getMonthValue();
            int d = dayList.get(i).getDayOfMonth();

            try {
                count_news[i] = adminService.count_board_new(y, m, d);
            } catch (Exception e) {
                System.out.println("count_news[i] : " + count_news[i]);
                count_news[i] = 0;
            }
        }

        List<String> day = new ArrayList<>();
        for ( int i = 0; i < dayList.size(); i++ ) {
            day.add(dayList.get(i).toString());
        }
        System.out.println("new dayList후보"+ day.toString());

        System.out.println("count_news : " + Arrays.toString(count_news));
        mv.addObject("count_news", Arrays.toString(count_news));

        try {
            // 통계
            int count_user_all = adminService.count_user_all("user");
            int countUserBis = adminService.count_user_else("bis");
            int countUserAdmin = adminService.count_user_else("admin");
            int countUserGene = adminService.count_user_else("gene");
            int countUserTemp = adminService.count_user_else("Tep");

            mv.addObject("count_user_all", count_user_all);
            mv.addObject("countUserBis", countUserBis);
            mv.addObject("countUserAdmin", countUserAdmin);
            mv.addObject("countUserGene", countUserGene);
            mv.addObject("countUserTemp", countUserTemp);

            LocalDate todayz = LocalDate.now();
            int y = todayz.getYear();
            int m = todayz.getMonthValue();
            int d = todayz.getDayOfMonth();

            int count_news_gene = adminService.count_news("gene", y, m, d);
            int count_news_bis = adminService.count_news("bis", y, m, d);

            mv.addObject("count_news_gene", count_news_gene);
            mv.addObject("count_news_bis", count_news_bis);




            // -----------------------------------------------

        } catch (Exception e) {
            e.printStackTrace();
        }




        mv.setViewName("Admin/statistics");
        return mv;
    }

}
