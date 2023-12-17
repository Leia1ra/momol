package com.example.momol.DTO;

import lombok.Data;
import lombok.ToString;

import java.sql.Timestamp;
import java.util.Date;


@ToString @Data
public class CommunityVO {
    private int num;
    private int Catnum;

    private String UID;
    private String title;
    private String author;
    private Date writetime;

    private String Content;
    private int views;
    private int likes;

    private String fileName;
    private boolean deleted;

    private String Category;
    private String nick;

    private Timestamp writetime_Ts;
    private java.sql.Date writetime_Sql;

}

