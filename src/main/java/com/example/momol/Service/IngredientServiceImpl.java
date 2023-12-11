package com.example.momol.Service;

import com.example.momol.DTO.IngredientVO;
import com.example.momol.Mapper.IngredientMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class IngredientServiceImpl implements IngredientService{
    @Autowired
    IngredientMapper mapper;

    @Override
    public List<IngredientVO> ingredientList() { return mapper.ingredientList();}

    @Override
    public IngredientVO jaeryoinfo(int ing_num) {
        return mapper.jaeryoinfo(ing_num);
    }

    @Override
    public List<IngredientVO> jaeryoList(int ing_num) {
        return mapper.jaeryoList(ing_num);
    }
}