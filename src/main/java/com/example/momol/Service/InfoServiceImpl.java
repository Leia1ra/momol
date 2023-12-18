package com.example.momol.Service;

import com.example.momol.DTO.*;
import com.example.momol.Mapper.InfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InfoServiceImpl implements MypageService, BusinessService {

    @Autowired
    InfoMapper mapper;

    @Override
    public UserVO userSelectbyUID(String UID) {
        return mapper.userSelectbyUID(UID);
    }

    @Override
    public int updateUser(UserVO updatedUser) {
        return mapper.updateUser(updatedUser);
    }

    @Override
    public List<CommunityVO> my_post(String UID) {
        return mapper.my_post(UID);
    }

    @Override
    public BusinessVO businessSelectbyUID(String UID) {
        return mapper.businessSelectbyUID(UID);
    }

    @Override
    public void insertBusiness(BusinessVO businessVO) {
        mapper.insertBusiness(businessVO);
    }

    @Override
    public void updateBusiness(BusinessVO updateBusiness) {
        mapper.updateBusiness(updateBusiness);
    }

    @Override
    public void updateMenu(String bizno, String beforeSubject, String subject, String content) {
        mapper.updateMenu(bizno, beforeSubject, subject, content);
    }

    @Override
    public void deleteMenu(MenuVO deleteMenu) {
        mapper.deleteMenu(deleteMenu);
    }

    @Override
    public void insertMenu(MenuVO menuVO) {
        mapper.insertMenu(menuVO);
    }

    @Override
    public List<BusinessVO> storeList(PagingVO pvo) {
        return mapper.storeList(pvo);
    }

    @Override
    public BusinessVO businessSelectbyBIZNO(String bizno) {
        return mapper.businessSelectbyBIZNO(bizno);
    }

    @Override
    public void lastUpdate(String bizno) {
        mapper.lastUpdate(bizno);
    }

    @Override
    public int totalRecord(PagingVO pvo) {
        return mapper.totalRecord(pvo);
    }

    @Override
    public List<MenuVO> bimenuSelectbybizno(String bizno) {
        return mapper.bimenuSelectbybizno(bizno);
    }

}