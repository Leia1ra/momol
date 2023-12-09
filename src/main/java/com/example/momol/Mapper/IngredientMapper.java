package com.example.momol.Mapper;

import com.example.momol.DTO.IngredientVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IngredientMapper {
    List<IngredientVO> ingredientList();
    IngredientVO jaeryoinfo(int ing_num);
    List<IngredientVO> jaeryoList(int ing_num);
}
