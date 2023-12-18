package com.example.momol.DTO;

import lombok.Data;
import lombok.ToString;

import java.util.Date;

@ToString @Data
public class CommentsVO {
    private String UID2;
    private int num;
    private int UID;
    private Date writetime;
    private String content;
    private int likes;
    private boolean deleted;
    private String nick;
}
