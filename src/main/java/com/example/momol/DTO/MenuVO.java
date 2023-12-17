package com.example.momol.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class MenuVO {
    private String bizno;
    private String menu;
    private String subject;
    private String content;

    private String imgPath;
}
