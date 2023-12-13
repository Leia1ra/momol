package com.example.momol.DTO;

import lombok.ToString;

import java.util.Date;

@ToString
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

    private boolean deleted;

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public String getTitle() {
        return title;
    }

    public int getCatnum() {
        return Catnum;
    }

    public void setCatnum(int catnum) {
        Catnum = catnum;
    }

    public String getUID() {
        return UID;
    }

    public void setUID(String UID) {
        this.UID = UID;
    }

    public String getContent() {
        return Content;
    }

    public void setContent(String content) {
        Content = content;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public java.sql.Date getWritetime() {
        return (java.sql.Date) writetime;
    }

    public void setWritetime(Date writetime) {
        this.writetime = writetime;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }
}

