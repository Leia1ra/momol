package com.example.momol.Mapper;

import com.example.momol.DTO.CockIngredientVO;
import com.example.momol.DTO.CocktailVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CockMapper {
    List<CocktailVO> cocktailList();
    CocktailVO cocktailInfo(String name);
    List<CockIngredientVO> cock_ingreList(String name);
    List<CocktailVO> searchCocktails(String searchText);
    List<CockIngredientVO> cock_ingre(String name);
    List<CocktailVO> getCategoryData2(CocktailVO vo);
//    관련칵테일
List<CocktailVO> make_list2(String tagName);


}
