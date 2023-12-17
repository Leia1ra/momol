package com.example.momol.Service;

import com.example.momol.DTO.BusinessVO;
import com.example.momol.DTO.MenuVO;
import com.example.momol.DTO.PagingVO;

import java.util.List;

public interface BusinessService {
    BusinessVO businessSelectbyUID(String UID);
    List<MenuVO> bimenuSelectbybizno(String bizno);

    void insertBusiness(BusinessVO businessVO);

    void updateBusiness(BusinessVO updateBusiness);

    void updateMenu(String bizno, String beforeSubject, String subject, String content);

    void deleteMenu(MenuVO deleteMenu);

    void insertMenu(MenuVO menuVO);

    List<BusinessVO> storeList(PagingVO pvo);

    BusinessVO businessSelectbyBIZNO(String bizno);

    void lastUpdate(String bizno);

    int totalRecord(PagingVO pvo);
}