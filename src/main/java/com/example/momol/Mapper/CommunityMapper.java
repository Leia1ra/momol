package com.example.momol.Mapper;

import com.example.momol.DTO.CommunityVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CommunityMapper {
    CommunityVO userSelect(CommunityVO vo);
    int communityInsert(CommunityVO vo);

    CommunityVO getPostByNum(@Param("num") int num);

}

