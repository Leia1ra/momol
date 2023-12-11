package com.example.momol.Service;

import com.example.momol.DTO.CommunityVO;
import org.springframework.stereotype.Service;


public interface CommunityService {
    int communityInsert(CommunityVO vo);
    CommunityVO getPostByNum(int num);

}
