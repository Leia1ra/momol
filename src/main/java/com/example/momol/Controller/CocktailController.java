package com.example.momol.Controller;

import com.example.momol.DTO.CockIngredientVO;
import com.example.momol.DTO.CocktailVO;
import com.example.momol.DTO.IngredientVO;
import com.example.momol.Service.CockService;
import com.example.momol.Service.IngredientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/Cocktail")
public class CocktailController {
    @Autowired
    CockService service;

    @Autowired
    IngredientService service2;

    @GetMapping("/cakmain")
    public ModelAndView CocktailPage(){
        ModelAndView mav = new ModelAndView();
        List<CocktailVO> list = service.cocktailList();

        System.out.println( list.toString() );

        mav.addObject("li", list);
        mav.setViewName("Cocktail/CakMain");
        return mav;
    }

    @GetMapping("/cakinfo")
    public ModelAndView CocktailInfo(String name){
        ModelAndView mav = new ModelAndView();
        CocktailVO vo = service.cocktailInfo(name);
        List<CockIngredientVO> list = service.cock_ingre(name);

        List<CocktailVO> list2 = service.make_list2(vo.getBasetag());


        System.out.println(vo.toString());
        mav.addObject("li2", list2);
        mav.addObject("vo",vo);
        mav.addObject("li", list);
        mav.setViewName("Cocktail/CakInformation");
        return mav;
    }

    @GetMapping("/jaeryomain")
    public ModelAndView JaeryoPage(){
        ModelAndView mav = new ModelAndView();
        List<IngredientVO> list = service2.ingredientList();

        mav.addObject("li", list);
        mav.setViewName("Cocktail/JaeryoMain");
        return mav;
    }



    @GetMapping("/jaeryoinfo")
    public ModelAndView JaeryoInfo(int ing_num){
        ModelAndView mav = new ModelAndView();
        IngredientVO vo = service2.jaeryoinfo(ing_num);
        List<CocktailVO> list = service2.make_list(String.valueOf(ing_num));
        System.out.println(list.toString());

        mav.addObject("vo",vo);
        mav.addObject("li", list);
        mav.setViewName("Cocktail/JaeryoInformation");
        return mav;
    }

    @GetMapping("/search") @ResponseBody
    public List searchCocktails(String searchText) {
        List<CocktailVO> list = service.searchCocktails(searchText);
        System.out.println(list.toString());
        return list;
    }

    @GetMapping("/search2") @ResponseBody
    public List searchCocktails2(String searchText) {
        List<IngredientVO> list = service2.searchCocktails2(searchText);
        return list;
    }

    @GetMapping("/wordbook")
    public String wordbook() {
        return "Cocktail/WordBook";
    }

    @GetMapping("/getCategoryData")
    @ResponseBody
    public List<IngredientVO> getCategoryData(String category) {
        List<IngredientVO> categoryData = service2.getCategoryData(category);
        return categoryData;
    }

    @PostMapping("/getCategoryData2")
    @ResponseBody
    public List<CocktailVO> getCategoryData2(CocktailVO vo) {
        System.out.println(vo);
        if(vo.getBasetag() == null){
            vo.setBasetag("");
        }
        if(vo.getTastetag() == null){
            vo.setTastetag("");
        }
        //if(vo.getABV() == null){
        //    vo.setABV(0.0F);
        //}


        return service.getCategoryData2(vo);
    }

}
