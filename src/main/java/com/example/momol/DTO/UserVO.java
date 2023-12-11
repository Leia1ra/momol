package com.example.momol.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class UserVO {
    private String UID;
    private String Id;
    private String Pw;
    private String Nick;

    private String Name;
    private String email;
    private String Birth;
    private String Phone;
    private boolean gender;

    private String JoinDate;
}
