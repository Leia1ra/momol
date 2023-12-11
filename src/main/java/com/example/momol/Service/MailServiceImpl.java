package com.example.momol.Service;

import com.example.momol.DTO.UserVO;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
// import org.springframework.mail.javamail.MimeMailMessage;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.util.Base64;
import java.util.Base64.Encoder;
import java.util.Base64.Decoder;

@Service("mailService")
public class MailServiceImpl implements MailService {
    @Autowired
    private JavaMailSender jms;
    Encoder encode = Base64.getEncoder();
    // Decoder decode = Base64.getDecoder();

    public void sendSimpleMail(UserVO vo) throws MessagingException {
        // SimpleMailMessage message = new SimpleMailMessage();
        String subject = "[Momol] 안녕하세요 Momol 회원가입 확인 메일입니다.";

        byte[] encodeUID = encode.encode(vo.getUID().getBytes());
        String tmpData = new String(encodeUID);
        String plainContent = "본 메일은 회원가입을 위한 인증 메일입니다. 하단의 링크를 클릭하여 본인임을 인증해주세요\n" +
                "http://localhost:8080/account/mailCheck?tmp=" + tmpData;
        String htmlContent = "<h1>본 메일은 회원가입을 위한 인증 메일입니다.</h1>" +
                "<p><a href='http://localhost:8080/account/mailCheck?tmp=" + tmpData + "'>본인임을 인증하기 위하여 클릭해 주세요</a></p>";

        MimeMessage message = jms.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
        helper.setTo(vo.getEmail());
        helper.setSubject(subject);
        helper.setText(plainContent, htmlContent);

        jms.send(message);
    }

    public void pwChangeMail(UserVO vo) throws MessagingException{
        String subject = "[Momol] 안녕하세요 Momol 비밀번호 변경 메일입니다.";

        String encodeUID = new String(encode.encode(vo.getUID().getBytes()));
        String encodeTmp = new String(encode.encode(vo.getPw().getBytes()));
        System.out.println(encodeTmp);
        String url = "http://localhost:8080/account/pwChange?UID=" + encodeUID + "&tmp=" + encodeTmp;

        String plainContent = "본 메일은 비밀번호 변경을 위한 메일입니다. 하단의 링크를 클릭하여 비밀번호의 변경을 진행해 주세요\n" + url;
        String htmlContent = "<h1>본 메일은 비밀번호 변경을 위한 메일입니다.</h1>" +
                "<p><a href='" + url + "'>클릭하여 비밀번호의 변경을 진행해 주세요</a></p>";

        MimeMessage message = jms.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
        helper.setTo(vo.getEmail());
        helper.setSubject(subject);
        helper.setText(plainContent, htmlContent);

        jms.send(message);
    }
}
