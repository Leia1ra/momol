package com.example.momol.Controller;

import com.example.momol.DTO.BusinessVO;
import com.example.momol.DTO.MenuVO;
import com.example.momol.DTO.PagingVO;
import com.example.momol.Service.BusinessService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.util.List;

@Controller
@RequestMapping("/store")
public class StoreController {
    @Autowired
    BusinessService businessService;
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

    @GetMapping("/list")
    public ModelAndView StoreListPage(PagingVO pvo, HttpSession session){
        ModelAndView mav = new ModelAndView();

        List<BusinessVO> list = businessService.storeList(pvo);
        for(BusinessVO v : list){
            String fName = "StoreImage"+v.getUID();
            String path = session.getServletContext().getRealPath("/img/Store/"+v.getUID());
            v.setImgPath(findFileName(fName, path));
            System.out.println(v);
        }
        // findFileName()
        pvo.setTotalRecord(businessService.totalRecord(pvo));

        mav.addObject("pVO",pvo);
        mav.addObject("list", list);
        mav.setViewName("StorePage/StoreList");
        return mav;
    }

    @GetMapping("/view")
    public ModelAndView StoreViewPage(String bizno, HttpSession session){
        ModelAndView mav = new ModelAndView();
        BusinessVO vo = businessService.businessSelectbyBIZNO(bizno);
        if(vo != null){
            String fName = "StoreImage"+vo.getUID();
            String path = session.getServletContext().getRealPath("/img/Store/"+vo.getUID());
            vo.setImgPath(findFileName(fName, path));

            List<MenuVO> menulist = businessService.bimenuSelectbybizno(vo.getBizno());
            String menuPath = session.getServletContext().getRealPath("/img/Store/"+vo.getUID()+"/Menu");
            for(MenuVO menu : menulist){
                menu.setImgPath("/resources/img/Store/"+vo.getUID()+"/Menu/"+findFileName(menu.getSubject(),menuPath));
            }
            System.out.println(menulist);

            mav.addObject("vo", vo);
            mav.addObject("list", menulist);
        } else {

        }

        mav.setViewName("StorePage/StoreView");
        return mav;
    }
}
