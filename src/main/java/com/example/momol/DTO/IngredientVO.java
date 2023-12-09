package com.example.momol.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class IngredientVO {
    private int ing_num;
    private String ing_name;
    private String ing_name_eng;
    private String ing_photo;
    private String ing_detail;
    private String ing_categ;
    private int abv;
}
