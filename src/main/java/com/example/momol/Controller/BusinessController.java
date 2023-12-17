package com.example.momol.Controller;

import com.example.momol.DTO.BusinessVO;
import com.example.momol.DTO.MenuVO;
import com.example.momol.Service.BusinessService;
import com.example.momol.Service.MypageService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
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
import java.sql.ClientInfoStatus;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/mmypage")
public class BusinessController {
    @Autowired
    MypageService service;

    @Autowired
    BusinessService businessService;

    @Autowired /* 트렌젝션 처리 */
            PlatformTransactionManager transactionManager;
    @Autowired
    TransactionDefinition definition;

    private void fileUpload(HttpServletRequest req, String fileName, String path, String tagName) throws IOException {
        MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
        MultipartFile multipartFile = mr.getFile(tagName);
        File directory = new File(path);
        if(!directory.exists()){
            boolean created = directory.mkdirs();
        }

        File orgFile = new File(path,findFileName(fileName, path));
        if(orgFile.exists()){
            orgFile.delete();
        }

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
    private String findFileName(String fileName, String path){
        File directory = new File(path);
        if(!directory.exists()){
            return "";
        } else {
            String[] extArr = {".png", ".jpg", ".jpeg"};
            String fileExt = null;
            File file = null;
            for (String ext : extArr){
                file = new File(path,fileName+ext);
                if(file.exists()){
                    fileExt = ext;
                    break;
                }
            }
            return fileName+fileExt;
        }
    }

    @GetMapping("/business")
    ModelAndView business(HttpSession session){
        ModelAndView mav = new ModelAndView();
        String logUID = (String) session.getAttribute("logUID");
        BusinessVO vo = businessService.businessSelectbyUID(logUID);

        if(vo == null){ // 비즈니스 사용자인데 레코드가 없을때
            mav.addObject("v","f");
            mav.setViewName("Mypage/business");
        } else if(vo != null) { // 비즈니스 사용자이고 레코드가 있을때
            List<MenuVO> menulist = businessService.bimenuSelectbybizno(vo.getBizno());
            mav.addObject("v", "t");
            mav.addObject("business", vo);

            String fName = "StoreImage"+logUID;
            String path = session.getServletContext().getRealPath("/img/Store/"+logUID);

            System.out.println(findFileName(fName,path));
            String pImgPath = "/resources/img/Store/"+logUID+"/"+findFileName(fName,path);

            String menuPath = session.getServletContext().getRealPath("/img/Store/"+logUID+"/Menu");
            for(MenuVO v : menulist){
                v.setImgPath("/resources/img/Store/"+logUID+"/Menu/"+findFileName(v.getSubject(),menuPath));
            }
            System.out.println(menulist);

            mav.addObject("storeImage", pImgPath);
            mav.addObject("list", menulist);
            mav.setViewName("Mypage/business");

        }
        return mav;
    }
    @PostMapping("/businessOk")
    ModelAndView businessupin(BusinessVO updateBusiness,
                              String businessInfo,
                              HttpSession session,
                              HttpServletRequest request,
                              @RequestParam(value = "p_img", required = false)MultipartFile multipartFile){
        TransactionStatus status = transactionManager.getTransaction(definition);
        ModelAndView mav = new ModelAndView();
        String logUID = (String) session.getAttribute("logUID");
        updateBusiness.setUID(logUID);
        System.out.println(updateBusiness);

        try { // 데이터베이스에 UID가 이미 존재하는지 확인
            if (businessInfo.equals("t")) { // 이미 존재하면 Update 쿼리 실행
                businessService.updateBusiness(updateBusiness);
            } else { // 존재하지 않으면 Insert 쿼리 실행
                businessService.insertBusiness(updateBusiness);
            }
            String fileName = "StoreImage"+logUID;
            String path = session.getServletContext().getRealPath("/img/Store/"+logUID);
            if(!multipartFile.isEmpty()){
                fileUpload(request, fileName, path, "p_img");
            }
            transactionManager.commit(status);
        } catch (IOException e) {
            transactionManager.rollback(status);
            throw new RuntimeException(e);
        }
        mav.setViewName("redirect:/mmypage/business");
        return mav;
    }

    @PostMapping("/menuDeleteOk") @ResponseBody
    public boolean menuDelete(MenuVO deleteMenu, HttpSession session) {
        String logUID = (String) session.getAttribute("logUID");

        businessService.deleteMenu(deleteMenu);
        String path = session.getServletContext().getRealPath("/img/Store/"+logUID+"/Menu");
        System.out.println(deleteMenu.getSubject());
        System.out.println(findFileName(deleteMenu.getSubject(),path));

        File orgFile = new File(path,findFileName(deleteMenu.getSubject(),path));
        if(orgFile.exists()){
            orgFile.delete();
        }

        return true;
    }

    @PostMapping("/menuUpdate") @ResponseBody
    public boolean menuUpdate(@RequestParam(value = "menu_imgFile", required = false)MultipartFile multipartFile,
                           String bizno,
                           String subject,
                           String content,
                           String beforeSubject,
                           HttpServletRequest request,
                           HttpSession session){
        TransactionStatus status = transactionManager.getTransaction(definition);
        String logUID = (String) session.getAttribute("logUID");
        System.out.println(bizno + ":" + subject + ":" + content + ":" + beforeSubject);
        try {
            String path = session.getServletContext().getRealPath("/img/Store/"+logUID+"/Menu");
            if(!multipartFile.isEmpty()){
                File orgFile = new File(path,findFileName(beforeSubject, path));
                if(orgFile.exists()){
                    orgFile.delete();
                }
                fileUpload(request, subject ,path,"menu_imgFile");
            } else {
                String orgFileName = findFileName(beforeSubject, path);
                File reNameFile = new File(path,orgFileName);
                if(reNameFile.exists()){
                    String ext = orgFileName.substring(orgFileName.indexOf("."));
                    reNameFile.renameTo(new File(path, subject+ext));
                    System.out.println(orgFileName);
                    new File(path, orgFileName).delete();

                }
            }
            businessService.updateMenu(bizno, beforeSubject, subject, content);
            transactionManager.commit(status);
            return true;
        } catch (IOException e) {
            transactionManager.rollback(status);
            return false;
        }
    }

    @PostMapping("/menuInsertOk") @ResponseBody
    boolean menuInsert(MenuVO vo, HttpSession session, HttpServletRequest request, @RequestParam(value = "menu_imgFile", required = false)MultipartFile multipartFile){
        TransactionStatus status = transactionManager.getTransaction(definition);
        String logUID = (String) session.getAttribute("logUID");

        BusinessVO voo = businessService.businessSelectbyUID(logUID);
        vo.setBizno(voo.getBizno());

        try {
            String path = session.getServletContext().getRealPath("/img/Store/"+logUID+"/Menu");
            if(!multipartFile.isEmpty()){
                fileUpload(request,vo.getSubject(),path,"menu_imgFile");
            }

            businessService.insertMenu(vo);
            transactionManager.commit(status);
            return true;
        } catch (IOException e) {
            transactionManager.rollback(status);
            return false;
        }
    }

}
