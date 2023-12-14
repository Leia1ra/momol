package com.example.momol.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class LoginFailureVO {
    String UID;
    String Id;
    String Ip;
    String loginTime;
}
