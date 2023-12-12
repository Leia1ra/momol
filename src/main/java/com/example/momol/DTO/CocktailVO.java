package com.example.momol.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data @NoArgsConstructor @AllArgsConstructor
public class CocktailVO {

    private String name;
    private String name_eng;
    private Float ABV;
    private String cocktail_detail;
    private String recipe;
    private String cocktails;
    private String cocktail_img;

    //태그
    private int baseNo;
    private int tasteNo;
    private int smellNo;
    private String TagName;
}

