package com.example.momol.Service;

import com.example.momol.DTO.CockIngredientVO;
import com.example.momol.DTO.CocktailVO;

import java.util.List;

public interface CockService {
    List<CocktailVO> cocktailList();

    CocktailVO cocktailInfo(String name);
    List<CockIngredientVO> cock_ingreList(String name);

    List<CocktailVO> searchCocktails(String searchText);

    List<CockIngredientVO> cock_ingre(String name);
}
