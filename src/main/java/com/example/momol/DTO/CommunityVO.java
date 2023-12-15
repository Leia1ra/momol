package com.example.momol.DTO;

import lombok.Data;
import lombok.ToString;

@ToString @Data
public class CommunityVO {
    private int num;
    private int Catnum;

    private String UID;
    private String title;
    private String author;
    private String writetime;

    private String Content;
    private int views;
    private int likes;

    private String fileName;
    private boolean deleted;

    private String Category;

}

