package com.example.momol.Service;

import com.example.momol.Mapper.CombainMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CombainServiceImpl implements CombainService {

    @Autowired
    CombainMapper mapper;

    @Override
    public List<String> load_total() {
        return mapper.load_total();
    }

    @Override
    public List<String> load_strong() {
        return mapper.load_strong();
    }

    @Override
    public List<String> load_weak() {
        return mapper.load_weak();
    }

    @Override
    public List<String> load_drink() {
        return mapper.load_drink();
    }

    @Override
    public List<String> load_etc() {
        return mapper.load_etc();
    }

    @Override
    public List<String> ing_search(String search_value) {
        return mapper.ing_search(search_value);
    }

    @Override
    public int save_user_ing(String user_id, String ing_name) {
        return mapper.save_user_ing(user_id, ing_name);
    }

    @Override
    public List<String> load_ing(String user_id) {
        return mapper.load_ing(user_id);
    }

    @Override
    public List<String> category_select(String category) {
        return mapper.category_select(category);
    }

    // @Override
    // public List<String> find(List<String> ingredients) {
    //     return mapper.find(ingredients);
    // }

    @Override
    public List<String> find(List<String> ingredients) {
        try {
            return mapper.find(ingredients);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error executing find query: " + e.getMessage(), e);
        }
    }

    @Override
    public List<String> getCocktailInfo(String name) {
        return mapper.getCocktailInfo(name);
    }

    @Override
    public String getCocktailInfo_detail(String name) {
        return mapper.getCocktailInfo_detail(name);
    }

    @Override
    public String getCocktailImg(String name) {
        return mapper.getCocktailImg(name);
    }


}
