package com.example.momol.Mapper;

import com.example.momol.DTO.BusinessVO;
import com.example.momol.DTO.CommunityVO;
import com.example.momol.DTO.MenuVO;
import com.example.momol.DTO.UserVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface InfoMapper {

    UserVO userSelectbyUID(String UID);

    int  updateUser(UserVO updatedUser);

    BusinessVO businessSelectbyUID(String UID);

    List<CommunityVO> my_post(String UID);
    List<MenuVO> bimenuSelectbybizno(String bizno);
    void insertBusiness(BusinessVO businessVO);

    void updateBusiness(BusinessVO updateBusiness);

    void updateMenu(String bizno, String beforeSubject, String subject, String content);

    void deleteMenu(MenuVO deleteMenu);

    void insertMenu(MenuVO menuVO);

    List<BusinessVO> storeList();
    BusinessVO businessSelectbyBIZNO(String bizno);

}
