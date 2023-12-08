package com.example.momol.Service;

import com.example.momol.DTO.UserVO;
import jakarta.mail.MessagingException;

public interface MailService {
    public void sendSimpleMail(UserVO vo) throws MessagingException;
}
