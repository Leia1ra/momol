package com.example.momol.Mapper;

import com.example.momol.DTO.CocktailVO;
import com.example.momol.DTO.IngrVO;
import com.example.momol.DTO.UserVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AdminMapper {
    List<UserVO> user_list(UserVO in);
    int user_delete(String id);
    int nick_edit(String usernick, String userid);

    List<IngrVO> ingre_list(IngrVO in);
    int ingre_add(IngrVO in); //재료 추가
    IngrVO ingre_edit_load(String num); //업데이트
    int ingre_edit_submit(IngrVO in); //재료수정
    int ingre_del(String num); //재료삭제

    List<CocktailVO> cocktail_list(CocktailVO in);
    int cocktail_add(CocktailVO in);
    CocktailVO cocktail_edit_load(String num);
    int cocktail_edit_submit(CocktailVO in);
    int cocktail_del(String num);

}
