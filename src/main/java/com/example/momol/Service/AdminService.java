package com.example.momol.Service;

import com.example.momol.DTO.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminService {

    List<UserVO> user_list(UserVO in);
    int user_delete(String id);

    // int nick_edit(String usernick, String userid);
    int nick_edit(@Param("usernick") String usernick, @Param("userid") String userid);

    List<IngrVO> ingre_list(IngrVO in);

    int ingre_add(IngrVO in);
    IngrVO ingre_edit_load(String num); //업데이트
    int ingre_edit_submit(IngrVO in); //재료수정
    int ingre_del(String num); //재료삭제

    List<CocktailVO> cocktail_list(CocktailVO in);

    int cocktail_add(CocktailVO in);
    CocktailVO cocktail_edit_load(String num);
    int cocktail_edit_submit(CocktailVO in);
    int cocktail_del(String num);

    int count_user_all(String name);
    int count_user_else(String name);
    int count_news(String name, int y, int m, int d);
    int count_board_new(int y, int m, int d);


    BusinessVO businessSelectbyUID(String UID);
    UserVO userSelectByUID(String UID);

    int businessDeletebyUID(String UID);
    int businessApprove(String UID);

    String lastAdminUID(int index, String UID);

    int toAdmin(String UID, String newUID);
}
