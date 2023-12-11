package com.example.momol.DTO;

import lombok.ToString;

import java.util.Date;

@ToString
public class CommentsVO {
    private String UID2;
    private int num;
    private int UID;
    private Date writetime;
    private String content;
    private int likes;
    private boolean deleted;

    public String getUID2() {
        return UID2;
    }

    public int getUID() {
        return UID;
    }

    public void setUID(int UID) {
        this.UID = UID;
    }

    public void setUID2(String UID2) {
        this.UID2 = UID2;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public Date getWritetime() {
        return writetime;
    }

    public void setWritetime(Date writetime) {
        this.writetime = writetime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }
}
