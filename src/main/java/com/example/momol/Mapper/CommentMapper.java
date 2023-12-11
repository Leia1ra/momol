package com.example.momol.Mapper;

import com.example.momol.DTO.CommentsVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CommentMapper {
    List<CommentsVO> getCommentsbyBoardNum(int num);
    void addComment(CommentsVO comment);
}
