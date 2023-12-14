package com.example.momol.Service;

import com.example.momol.DTO.*;
import com.example.momol.Mapper.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImple implements AdminService{

    @Autowired
    AdminMapper mapper;

    @Override
    public List<UserVO> user_list(UserVO in) {
        return mapper.user_list(in);
    }

    @Override
    public int user_delete(String id) {
        return mapper.user_delete(id);
    }

    @Override
    public int nick_edit(String usernick, String userid) {
        return mapper.nick_edit(usernick, userid);
    }

    @Override
    public List<IngrVO> ingre_list(IngrVO in) {
        return mapper.ingre_list(in);
    }

    @Override
    public int ingre_add(IngrVO in) {
        return mapper.ingre_add(in);
    }

    @Override
    public IngrVO ingre_edit_load(String num) {
        return mapper.ingre_edit_load(num);
    }

    @Override
    public int ingre_edit_submit(IngrVO in) {
        return mapper.ingre_edit_submit(in);
    }

    @Override
    public int ingre_del(String num) {
        return mapper.ingre_del(num);
    }

    @Override
    public List<CocktailVO> cocktail_list(CocktailVO in) {
        return mapper.cocktail_list(in);
    }

    @Override
    public int cocktail_add(CocktailVO in) {
        return mapper.cocktail_add(in);
    }

    @Override
    public CocktailVO cocktail_edit_load(String num) {
        return mapper.cocktail_edit_load(num);
    }
    @Override
    public int cocktail_edit_submit(CocktailVO in) {
        return mapper.cocktail_edit_submit(in);
    }

    @Override
    public int cocktail_del(String num) {
        return mapper.cocktail_del(num);
    }

    @Override
    public int count_user_all(String name) {
        return mapper.count_user_all(name);
    }

    @Override
    public int count_user_else(String name) {
        return mapper.count_user_else(name);
    }

    @Override
    public int count_news(String name, int y, int m, int d) {
        return mapper.count_news(name, y, m, d);
    }

    @Override
    public int count_board_new(int y, int m, int d) {
        return mapper.count_board_new(y, m, d);
    }


}
