package com.example.momol.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CockIngredientVO {
    /*재료 정보*/
    private String name;
    private int ing_num;
    private String ing_amount;
    private String ing_name;
    private String ing_photo;
}
