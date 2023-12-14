package com.example.momol.Mapper;

import com.example.momol.DTO.CommentsVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CommentMapper {
    void addComment(CommentsVO comment);

    void deleteComment(int UID);
    List<CommentsVO> getCommentsbyBoardNum(int num);
    List<Integer> getComLikeNum(int num);

}
