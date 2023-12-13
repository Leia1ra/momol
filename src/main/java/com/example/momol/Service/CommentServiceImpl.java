package com.example.momol.Service;

import com.example.momol.DAO.BoardDAO;
import com.example.momol.DTO.CommentsVO;
import com.example.momol.Mapper.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService{
    private final CommentMapper commentMapper;

    @Autowired
    private BoardDAO boardDAO;
    @Autowired
    public CommentServiceImpl(CommentMapper commentMapper){
        this.commentMapper = commentMapper;
    }

    @Override
    public List<CommentsVO> getCommentsByBoardNum(int num){
        return commentMapper.getCommentsbyBoardNum(num);
    }

    @Override
    public void addComment(CommentsVO comment) {
        commentMapper.addComment(comment);
    }

}
