package com.example.momol.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor

public class BusinessVO {
    private String bizno;
    private String UID;
    private String place;
    private String p_img;

    private String other;
    private String address;
    private String date;
    private String time;
    private String lasttouch;
    private boolean approved;
}
