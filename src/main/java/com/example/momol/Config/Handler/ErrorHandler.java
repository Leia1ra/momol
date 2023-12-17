package com.example.momol.Config.Handler;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.Base64;

@Controller
public class ErrorHandler implements ErrorController {
    @GetMapping("/err")
    public ModelAndView errorPage(String status, String message, HttpServletRequest req){
        ModelAndView mav = new ModelAndView();
        Base64.Decoder d = Base64.getDecoder();
        String msg = new String(d.decode(message));
        mav.addObject("message", msg);
        mav.addObject("status", status);
        mav.setViewName("errorPage");
        return mav;
    }

    @GetMapping("/error")
    public ModelAndView handleError(HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        Object statusCode = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        String status = "";
        String msg = "";
        if(statusCode != null){
            int intCode = Integer.parseInt(statusCode.toString());
            HttpStatus httpStatus = HttpStatus.valueOf(intCode);
            System.out.println(httpStatus);
            status = httpStatus.toString();
            if(intCode/100 == 4){
                msg = "잘못된 요청입니다.";
            } else if(intCode/100 == 5){
                msg = "죄송합니다. 서버 사정으로 인한 문제가 발생하였습니다.";
            } else{
                msg = "기타 에러입니다.";
            }

        } else {
            status = statusCode + " ";
        }

        mav.addObject("status", status);
        mav.addObject("message", msg);
        mav.setViewName("errorPage");
        return mav;
    }
}
