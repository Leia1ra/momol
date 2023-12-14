package com.example.momol.Controller;

import com.example.momol.DAO.BoardDAO;
import com.example.momol.DTO.CommentsVO;
import com.example.momol.DTO.CommunityVO;
import com.example.momol.Service.CommentService;
import com.example.momol.Service.CommunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

@Controller
public class CommentController {
    private final CommentService commentService;
    private final CommunityService communityService;
    private  final BoardDAO boardDAO;

    @Autowired
    public CommentController(CommentService commentService, CommunityService communityService, BoardDAO boardDAO) {
        this.commentService = commentService;
        this.communityService = communityService;
        this.boardDAO = boardDAO;
    }


    @PostMapping("/addComment")
    public ModelAndView addComment(@RequestParam("content") String content, @RequestParam("num") int num, Model model) {
        ModelAndView mav = new ModelAndView();

        CommentsVO newComment = new CommentsVO();
        newComment.setUID2("user");
        newComment.setContent(content);
        newComment.setLikes(0);
        newComment.setNum(num);

        commentService.addComment(newComment);

        List<CommentsVO> commentList = commentService.getCommentsByBoardNum(num);

        mav.addObject("comments", commentList);
        mav.setViewName("redirect:/community/walls/"+num);
        return mav;
    }

    @PostMapping("/likeComment")
    public ResponseEntity<Integer> likeComment(@RequestBody Map<String, Integer> params) {
        int UID = params.get("UID");
        int updatedLikes = commentService.increaseLikes(UID);
        return ResponseEntity.ok(updatedLikes);
    }

    @DeleteMapping("/deleteComment")
    public ResponseEntity<Void> deleteComment(@RequestBody Map<String, Integer> params) {
        int UID = params.get("UID");
        commentService.deleteComment(UID);
        return ResponseEntity.noContent().build();
    }
}

