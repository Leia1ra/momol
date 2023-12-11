package com.example.momol.Service;

import com.example.momol.DTO.UserVO;
import jakarta.mail.MessagingException;

public interface MailService {
    void sendSimpleMail(UserVO vo) throws MessagingException;

    void pwChangeMail(UserVO vo) throws MessagingException;
}
