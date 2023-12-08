package com.example.momol.Mapper;

import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.lang.String;


@Mapper
public interface CombainMapper {

    List<String> load_total();

    List<String> load_strong();
    List<String> load_weak();
    List<String> load_drink();
    List<String> load_etc();

    List<String> ing_search(String search_value);

    int save_user_ing(String user_id, String ing_name);

    List<String> load_ing(String user_id);

    List<String> category_select(String category);

    List<String> find(List<String> ingredients);

    List<String> getCocktailInfo(String name);

    String getCocktailInfo_detail(String name);

    String getCocktailImg(String name);


}
