package com.example.momol.Controller;

import com.example.momol.DTO.UserVO;
import com.example.momol.Service.MailService;
import com.example.momol.Service.UserService;
import jakarta.annotation.Resource;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.Base64;
import java.util.Base64.Decoder;

@Controller
@RequestMapping("/account")
public class UserController {
    private final static String clientId = "lm5g3zx9ad";//애플리케이션 클라이언트 아이디값";
    private final static String clientSecret = "mtO7Cz9bk12SX2LRxcXYxVTYOWkwVVIPu1LrjrOd";//애플리케이션 클라이언트 시크릿값";

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
    Decoder decode = Base64.getDecoder();

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

    private void fileUpload(HttpServletRequest req, String fileName, String path) throws IOException {
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

    @GetMapping("/findAccount")
    public String findAccount(String type, Model model){
        model.addAttribute("type", type);
        return "Account/findAccount";
    }
    /*@PostMapping("/findAction")
    public ModelAndView findAction(UserVO vo, String search){
        ModelAndView mav = new ModelAndView();

        return mav;
    }*/

    @PostMapping("/findCheck") @ResponseBody
    public String findCheck(UserVO vo, String type){
        UserVO result = service.findCheck(vo);
        if(result != null){
            if(type.equals("ID")) {
                return "귀하의 ID는 [" + result.getId() + "] 입니다";
            } else if (type.equals("PW")) {
                try {
                    String tmpPw = "TemporaryPassword_" + randomStr(22);
                    service.passwordUpdate(result.getUID(), tmpPw);
                    result.setPw(tmpPw);
                    mail.pwChangeMail(result);
                    return "메일의 링크를 통하여 비밀번호의 변경을 진행해주시길 바랍니다";
                } catch (MessagingException e) {
                    return "메일 전송이 실패하였습니다.";
                }
            }
        } else {
            return "일치하는 정보가 없습니다.";
        }
        return "";
    }
    private String randomStr(int max){
        char[] charArr = new char[max];
        Random rand = new Random();

        for(int i=0; i<max; i++){
            char randChar = (char) (rand.nextInt(122-48+1)+48);
            switch (randChar){
                case ':', ';', '<', '=', '>', '?', '@', '[', '₩', ']', '^', '_', '`':
                    --i; break;
                default:
                    charArr[i] = randChar;
                    break;
            }
        }
        return new String(charArr);
    }


    @GetMapping("/pwChange")
    public ModelAndView pwChange(String UID, @RequestParam(required = false) String tmp){
        ModelAndView mav = new ModelAndView();
        if(tmp != null){
            mav.addObject("type", "temporary");
            mav.addObject("tmp", tmp);
        } else {
            mav.addObject("type", "logUser");
        }
        mav.addObject("UID", UID);
        mav.setViewName("Account/pwChange");
        return mav;
    }

    @PostMapping("/pwChangeOk")
    public void pwChangeAction(String newPw, String UID, HttpServletResponse res){
        System.out.println(UID + " : " + newPw);
        String encodePw = passwordEncoder.encode(newPw);

        int result = service.pwUpdate(new String(decode.decode(UID)), encodePw);
        try {
            if(result != 0){
                res.sendRedirect("/account/login");
            } else {
                res.setContentType("text/html; charset=UTF-8");
                PrintWriter out = res.getWriter();
                out.println("<script>");
                out.println("alert('비밀번호 변경에 실패하였습니다.')");
                out.println("history.back()");
                out.println("</script>");
                out.flush();
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
    @PostMapping("/pwChangeAsync") @ResponseBody
    public Map pwChangeAsync(String Pw, String UID){
        Map result = new HashMap();
        UserVO vo = service.pwMatchByUID(new String(decode.decode(UID)));
        String decodePw = new String(decode.decode(Pw));
        if(decodePw.substring(0, decodePw.indexOf("_")).equals("TemporaryPassword")){
            if(vo.getPw().equals(decodePw)){
                result.put("result", true);
            } else {
                result.put("result", false);
                result.put("message", "잘못된 경로입니다.");
            }
        } else {
            if(passwordEncoder.matches(decodePw, vo.getPw())){
                result.put("result", true);
            } else {
                result.put("result", false);
                result.put("message", "기존 비밀번호가 잘못 입력되었습니다.");
            }
        }
        return result;
    }
}
