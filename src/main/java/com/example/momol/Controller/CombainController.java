// 술장고 페이지 컨트롤러
package com.example.momol.Controller;

import java.util.*;
import com.example.momol.Service.CombainService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class CombainController {

    @Autowired
    private CombainService service;

    @GetMapping("/combain")
    public ModelAndView combain(HttpSession session) {
        ModelAndView mv = new ModelAndView();

        //재료 정보 가져오기
        List<String> strong_list = service.load_strong();
        List<String> weak_list = service.load_weak();
        List<String> drink_list = service.load_drink();
        List<String> etc_list = service.load_etc();

        List<String> allIngList = service.load_total();

        // allIngList 정렬
        Collections.sort(allIngList);

        mv.addObject("strong_list", strong_list);
        mv.addObject("weak_list", weak_list);
        mv.addObject("drink_list", drink_list);
        mv.addObject("etc_list", etc_list);

        mv.addObject("allIngList", allIngList);

        mv.setViewName("Combain/combain");
        return mv;
    }

    // 검색
    @RequestMapping(value = "/combain/search", method = {RequestMethod.GET, RequestMethod.POST})
    public void search(HttpServletRequest request, HttpServletResponse response) {
        String searchWord = request.getParameter("searchWord");
        List<String> searchResult = service.ing_search(searchWord);
        System.out.println("가져온 값 : " + searchWord + " /// " + "검색 결과" + searchResult);

        // 검색결과를 json 변환
        ObjectMapper mapper = new ObjectMapper();
        String json = "";
        try {
            json = mapper.writeValueAsString(searchResult);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().print(json);

        } catch (Exception e) {
            System.out.println("json 변환 실패");
        }

    }

    //술장고_저장하기
    @RequestMapping(value = "/combain/save", method = {RequestMethod.GET, RequestMethod.POST})
    public void save(HttpSession session, HttpServletRequest request, HttpServletResponse response) {

        String UID = "";

        //로그인 여부 확인하기
        boolean loginCheck = session.getAttribute("logUID") != null;
        if (loginCheck) {
            UID = session.getAttribute("logUID").toString();
            System.out.println("확인된 UID : " + UID);
        } else {
            System.out.println("로그인이 필요합니다.");
            return;
        }

        String inputList = request.getParameter("outputData");
        System.out.println("inputList : " + inputList);

        // == outputData를 "," 를 기준으로 나눠 배열에 저장
        // String[] inputListArr = inputList.split(",");
        // for (int i = 0; i < inputListArr.length; i++) {
        //     System.out.println("inputListArr[" + i + "] : " + inputListArr[i]);
        //     service.save_user_ing(UID, inputListArr[i]);
        // }

        // == outData를 toString된 상태로 저장
        service.save_user_ing(UID, inputList);

        ObjectMapper mapper = new ObjectMapper();
        String json = "";

        //술장고에 저장할 재료들 가져오기
        try {
            json = mapper.writeValueAsString(inputList);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().print(json);

        } catch (Exception e) {
            System.out.println("json 변환 실패");
        }

    }

    //술장고 불러오기
    @RequestMapping(value = "/combain/load", method = {RequestMethod.GET, RequestMethod.POST})
    public void load(HttpSession session, HttpServletRequest request, HttpServletResponse response) {

        //로그인 여부 체크
        if (session.getAttribute("logUID") == null) {
            System.out.println("로그인이 필요합니다.");
            return;
        } else {
            String UID = session.getAttribute("logUID").toString();
            System.out.println("확인된 UID : " + UID);

            //저장된 재료 가져오기
            List<String> loadIngCon = service.load_ing(UID);
            if (loadIngCon == null) {
                System.out.println("저장된 재료가 없습니다.");
                return;
            } else {

                if (loadIngCon.get(0).equals("") || loadIngCon.get(0) == null) {
                    System.out.println("저장된 재료가 없습니다.");
                    return;
                }

                // loadIngCon 을 "," 을 기준으로 나눠 배열에 저장
                String[] loadIngConArr = loadIngCon.get(0).split(",");
                // for (int i = 0; i < loadIngConArr.length; i++) {
                //     System.out.println("loadIngConArr[" + i + "] : " + loadIngConArr[i]);
                // }

                ObjectMapper mapper = new ObjectMapper();
                String json = "";

                try {
                    json = mapper.writeValueAsString(loadIngCon);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().print(json);
                } catch (Exception e) {
                    System.out.println("json 변환 실패");
                }
            }
        }
    }

    @RequestMapping(value = "/combain/category", method = {RequestMethod.GET, RequestMethod.POST})
    public void load_category(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        String[] categoryList = {"강한도수", "약한도수", "주류", "주스", "과일", "기타"};

        //카테고리 불러오기
        String category_name = request.getParameter("category");

        //카테고리에 해당하는 재료 불러오기
        List<String> categoryIngList = new ArrayList<>();
        if (Objects.equals(category_name, "전체")) {
            categoryIngList = service.load_total();
        } else {
            categoryIngList = service.category_select(category_name);
        }

        // 정렬
        Collections.sort(categoryIngList);

        //text 형식으로 ajax로 보내기
        String json = "";
        ObjectMapper mapper = new ObjectMapper();
        try {
            json = mapper.writeValueAsString(categoryIngList);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().print(json);
        } catch (Exception e) {
            System.out.println("json 변환 실패");
        }

    }

    // 만들 수 있는 칵테일 리스트 관련 메소드
    @RequestMapping(value = "/combain/find", method = {RequestMethod.GET, RequestMethod.POST})
    public void cocktailThatYouCanMake(HttpServletRequest request, HttpServletResponse response) {
        try {
            String loadIngConItems = request.getParameter("send_data");
            String[] ingredients = loadIngConItems.split(",");
            System.out.println("받은 데이터: " + Arrays.toString(ingredients));

            //List<String> 으로 변경
            List<String> ingredientsList = new ArrayList<>(Arrays.asList(ingredients));

            //칵테일 레시피 가져오기
            List<String> cocktailList = service.find(ingredientsList);
            Collections.sort(cocktailList); //정렬
            System.out.println("칵테일 레시피: " + cocktailList.toString());

            //JSON 변환
            String json = "";
            ObjectMapper mapper = new ObjectMapper();

            json = mapper.writeValueAsString(cocktailList);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().print(json);

        } catch (Exception e) {
            e.printStackTrace(); // 에러 메시지를 출력하도록 수정
            System.out.println("json 변환 실패");
        }
    }

    // 만들수 있는 칵테일... 에서 cocktail정보를 가져오는 메소드
    @RequestMapping(value = "/combain/cocktail_info", method = {RequestMethod.GET, RequestMethod.POST})
    public void getCocktailInfo( HttpServletRequest request, HttpServletResponse response) {
        try {
            String cocktailName = request.getParameter("name");
            System.out.println("받은 데이터: " + cocktailName);

            //칵테일 레시피 가져오기
            List<String> cocktailInfo = service.getCocktailInfo(cocktailName);
            String cocktailInfo_detail = service.getCocktailInfo_detail(cocktailName);
            String cocktailInfo_img = service.getCocktailImg(cocktailName);

            if (cocktailInfo_img == null && cocktailInfo_detail != null) {
                cocktailInfo_img = "https://file.thisisgame.com/upload/tboard/user/2011/04/22/20110422071025_4335.jpg";
            }

            if (cocktailInfo_img == null && cocktailInfo_detail == null) {
                return;
            }

            cocktailInfo.add(cocktailInfo_detail);
            cocktailInfo.add(cocktailInfo_img);

            System.out.println("칵테일 번호 " + cocktailInfo.toString());

            //JSON 변환
            String json = "";
            ObjectMapper mapper = new ObjectMapper();

            json = mapper.writeValueAsString(cocktailInfo);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().print(json);

        } catch (Exception e) {
            e.printStackTrace(); // 에러 메시지를 출력하도록 수정
            System.out.println("json 변환 실패");
        }
    }


}
