package com.example.momol.Service;

import com.example.momol.DTO.CockIngredientVO;
import com.example.momol.DTO.CocktailVO;
import com.example.momol.Mapper.CockMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CockServiceImpl implements CockService{
    @Autowired
    CockMapper mapper;

    @Override
    public List<CocktailVO> cocktailList() {
        return mapper.cocktailList();
    }

    @Override
    public CocktailVO cocktailInfo(String name) {
        return mapper.cocktailInfo(name);
    }

    @Override
    public List<CockIngredientVO> cock_ingreList(String name) {
        return mapper.cock_ingreList(name);
    }

    @Override
    public List<CocktailVO> searchCocktails(String searchText) {
        return mapper.searchCocktails(searchText);
    }

    @Override
    public List<CockIngredientVO> cock_ingre(String name) {
        return mapper.cock_ingre(name);
    }

    @Override
    public List<CocktailVO> getCategoryData2(CocktailVO vo) {
        return mapper.getCategoryData2(vo);

    }

}


