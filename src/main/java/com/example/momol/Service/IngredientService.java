package com.example.momol.Service;

import com.example.momol.DTO.IngredientVO;

import java.util.List;

public interface IngredientService {
    List<IngredientVO> ingredientList();
    IngredientVO jaeryoinfo(int ing_num);
    List<IngredientVO> jaeryoList(int ing_num);
    List<IngredientVO> searchCocktails2(String searchText);
    List<IngredientVO> getCategoryData(String category);
}
