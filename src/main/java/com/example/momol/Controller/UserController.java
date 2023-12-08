package com.example.momol.Controller;

import com.example.momol.DTO.UserVO;
import com.example.momol.Service.MailService;
import com.example.momol.Service.UserService;
import jakarta.annotation.Nullable;
import jakarta.annotation.Resource;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.Base64;
import java.util.Base64.Decoder;

@Controller
@RequestMapping("/account")
public class UserController {
    @Autowired
    UserService service;

    @Resource(name = "mailService")
    private MailService mail;

    @Autowired /* 트렌젝션 처리 */
    PlatformTransactionManager transactionManager;
    @Autowired
    TransactionDefinition definition;
    @Autowired /* 암호 해싱(Bcrypt) */
    PasswordEncoder passwordEncoder;

    /* 로그인 뷰 페이지 */
    @GetMapping("/login")
    public ModelAndView login(@RequestParam(value = "error", required = false)String exception){
        ModelAndView mav = new ModelAndView();
        if(exception != null){
            Decoder decoder = Base64.getDecoder();
            byte[] msg = decoder.decode(exception);
            String errMsg = new String(msg);
            mav.addObject("exception", errMsg);
        }
        mav.setViewName("Account/Login");
        return mav;
    }


    @GetMapping("/signIn") /* 회원가입 뷰 페이지 */
    public ModelAndView signIn(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("Account/SignIn");
        return mav;
    }

    @PostMapping("/accountCheck") @ResponseBody /* 회원가입 비동기 처리 */
    public Map<String, Boolean> accountCheck(UserVO vo){
        List<UserVO> list = service.checkedExist(vo);
        Map<String, Boolean> duplicate = null;
        if(list != null){
            duplicate = new HashMap<String, Boolean>();
            duplicate.put("Id", false);
            duplicate.put("Nick", false);
            duplicate.put("email", false);
            duplicate.put("Phone", false);
            for(UserVO test : list){
                if(Objects.equals(vo.getId(), test.getId()))        duplicate.put("Id", true);
                if(Objects.equals(vo.getNick(), test.getNick()))    duplicate.put("Nick", true);
                if(Objects.equals(vo.getEmail(), test.getEmail()))  duplicate.put("email", true);
                if(Objects.equals(vo.getPhone(), test.getPhone()))  duplicate.put("Phone", true);
            }
        }

        return duplicate;
    }

    @PostMapping("/signInOk") /* 회원가입(인증전) */
    public ModelAndView signInAction(UserVO vo, String isBusiAcc, HttpServletRequest req, HttpSession session){
        TransactionStatus status = transactionManager.getTransaction(definition);
        ModelAndView mav = new ModelAndView();
        try {
            vo.setPw(passwordEncoder.encode(vo.getPw()));
            String temp = "Tmp_";
            LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMddHHmmssSSS");
            if (isBusiAcc != null && isBusiAcc.equals("checked")){
                temp += "B";
                temp += now.format(formatter);
                String path = session.getServletContext().getRealPath("/img/Certificate");

                fileUpload(req, temp, path); /* 오류 생성기1 */
            } else {
                temp += "G";
                temp += now.format(formatter);
            }
            vo.setUID(temp);

            mail.sendSimpleMail(vo); /* 오류 생성기2 */
            int result = service.userInsert(vo);

            if(result > 0){
                mav.addObject("vo", vo);
                mav.setViewName("Account/signUpDone");
            }
            transactionManager.commit(status);
        } catch (MessagingException e) {
            transactionManager.rollback(status);
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        } catch (IOException e) {
            transactionManager.rollback(status);
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }

        return mav;
    }

    public void fileUpload(HttpServletRequest req, String fileName, String path) throws IOException {
        MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
        MultipartFile multipartFile = mr.getFile("Business_certificate");

        if(multipartFile != null && !multipartFile.isEmpty()){
            String orgFileName = multipartFile.getOriginalFilename();

            if(orgFileName != null && !orgFileName.equals("")){
                String ext = orgFileName.substring(orgFileName.indexOf("."));
                String newFileName = fileName + ext;
                File newFile = new File(path, newFileName);

                multipartFile.transferTo(newFile);
            }
        }
    }

    @GetMapping("/mailCheck")
    public ModelAndView mailCheck(String tmp, HttpSession session){
        ModelAndView mav = new ModelAndView();
        Decoder decode = Base64.getDecoder();

        byte[] decodeUID = decode.decode(tmp);
        String tmpData = new String(decodeUID);

        int index = tmpData.indexOf("_");
        if(tmpData.substring(0, index).equals("Tmp")){
            // BUSI_20231207 000000 // GENE_20231207 000000 // ADMIN_0000000
            String accountType = tmpData.substring(index+1, index+2);

            if(accountType.equals("G")){ // 일반사용자
                setUID("GENE_", tmpData);
            } else if(accountType.equals("B")){ // 사업자
                String newUID = setUID("BUSI_", tmpData);
                String path = session.getServletContext().getRealPath("/img/Certificate");
                String[] extArr = {".png", ".jpg", ".jpeg"};
                String fileExt = null;
                File file = null;
                for (String ext : extArr){
                    file = new File(path,tmpData+ext);
                    if(file.exists()){
                        fileExt = ext;
                        break;
                    }
                }
                File rename = new File(path, newUID+fileExt);
                file.renameTo(rename);
            }
            mav.setViewName("redirect:/account/login");
        } else {
            mav.setViewName("redirect:/");
        }
        return mav;
    }

    private String setUID(String type, String currentUID){
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        String newUID = type + currentDate.format(formatter) + " ";
        String lastUID = service.lastUID(newUID.indexOf(" ")+2, newUID+"%");
        if(lastUID == null) newUID += "000000";
        else {
            int lastCnt = Integer.parseInt(lastUID);
            String toStr = String.format("%06d", ++lastCnt);
            newUID += toStr;
        }
        service.updateUID(newUID, currentUID);
        return newUID;
    }

}
