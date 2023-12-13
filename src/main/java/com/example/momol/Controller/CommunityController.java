package com.example.momol.Controller;

import com.example.momol.DAO.BoardDAO;
import com.example.momol.DTO.CommentsVO;
import com.example.momol.DTO.CommunityVO;
import com.example.momol.Service.CommentService;
import com.example.momol.Service.CommunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/community")
public class CommunityController {

    @Autowired
    CommunityService service;
    @Autowired
    CommentService commentService;

    @GetMapping("/wishlist")
    public String wishlist(Model model) {
        BoardDAO boardDAO = new BoardDAO();
        List<CommunityVO> boards = boardDAO.getAllBoards();

        model.addAttribute("boards", boards);
        return "Community/wishlist";
    }

    @GetMapping("/wishlist/{num}")
    public String wish_view(@PathVariable int num, Model model) {
        BoardDAO boardDAO = new BoardDAO();
        CommunityVO board = boardDAO.vo(num);

        // 조회수 업데이트
        boardDAO.viewUpdate(board.getViews() + 1, num);
        List<CommentsVO> commentList = commentService.getCommentsByBoardNum(num);

        model.addAttribute("board", board);
        model.addAttribute("comments", commentList);
        return "Community/post-view";
    }

    @GetMapping("/walls")
    public String walls(Model model) {
        BoardDAO boardDAO = new BoardDAO();
        List<CommunityVO> boards = boardDAO.getAllBoards();

        model.addAttribute("boards", boards);
        return "Community/walls";
    }

    @GetMapping("/walls/{num}")
    public String walls_view(@PathVariable int num, Model model) {
        BoardDAO boardDAO = new BoardDAO();
        CommunityVO board = boardDAO.vo(num);

        // 조회수 업데이트
        boardDAO.viewUpdate(board.getViews() + 1, num);
        List<CommentsVO> commentList = commentService.getCommentsByBoardNum(num);

        model.addAttribute("board", board);
        model.addAttribute("comments", commentList);
        return "Community/post-view";
    }


    @GetMapping("/dadaima")
    public String dadaima(Model model) {
        BoardDAO boardDAO = new BoardDAO();
        List<CommunityVO> boards = boardDAO.getAllBoards();

        model.addAttribute("boards", boards);
        return "Community/dadaima";
    }

    @GetMapping("/dadaima/{num}")
    public String dada_view(@PathVariable int num, Model model) {
        BoardDAO boardDAO = new BoardDAO();
        CommunityVO board = boardDAO.vo(num);

        // 조회수 업데이트
        boardDAO.viewUpdate(board.getViews() + 1, num);
        List<CommentsVO> commentList = commentService.getCommentsByBoardNum(num);

        model.addAttribute("board", board);
        model.addAttribute("comments", commentList);
        return "Community/post-view";
    }

    @GetMapping("/myrecipe")
    public String myrecipe(Model model) {
        BoardDAO boardDAO = new BoardDAO();
        List<CommunityVO> boards = boardDAO.getAllBoards();

        model.addAttribute("boards", boards);
        return "Community/myrecipe";
    }

    @GetMapping("/recommendme")
    public String recommendme(Model model) {
        BoardDAO boardDAO = new BoardDAO();
        List<CommunityVO> boards = boardDAO.getAllBoards();


        model.addAttribute("boards", boards);
        return "Community/recommendme";
    }

    @GetMapping("/recommendme/{num}")
    public String rcmd_view(@PathVariable int num, Model model) {
        BoardDAO boardDAO = new BoardDAO();
        CommunityVO board = boardDAO.vo(num);

        // 조회수 업데이트
        boardDAO.viewUpdate(board.getViews() + 1, num);
        List<CommentsVO> commentList = commentService.getCommentsByBoardNum(num);

        model.addAttribute("board", board);
        model.addAttribute("comments", commentList);
        return "Community/post-view";
    }

    @GetMapping("/writing")
    public String posting() {
        return "Community/posting";
    }


    private String saveUploadedFile(MultipartFile file) throws IOException {
        // 업로드할 디렉토리 경로를 설정 (프로젝트 내의 원하는 위치로 설정 가능)
        String uploadDir = "path/to/upload/directory";

        // 업로드할 디렉토리가 없으면 생성
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }

        // 파일명 중복을 피하기 위해 UUID를 사용하여 파일명 생성
        String fileName = UUID.randomUUID().toString() + "_" + StringUtils.cleanPath(file.getOriginalFilename());

        // 파일을 업로드할 경로 설정
        Path uploadPath = Path.of(uploadDir, fileName);

        // 파일 복사
        Files.copy(file.getInputStream(), uploadPath, StandardCopyOption.REPLACE_EXISTING);

        return fileName;
    }

    @PostMapping("/posting")
    public String writePost(
            CommunityVO vo,
            @RequestPart(value = "file", required = false) MultipartFile file,
            RedirectAttributes redirectAttributes) {
        System.out.println(">" + vo.toString());

        // 파일 업로드 처리
        if (file != null && !file.isEmpty()) {
            try {
                // 파일 업로드 로직 적용
                String fileName = saveUploadedFile(file);

                // 이제 setFileName 메서드를 사용하여 fileName을 vo에 설정
                vo.setFileName(fileName);
            } catch (IOException e) {
                e.printStackTrace();
                // 파일 업로드 중 오류 발생 시, 적절한 처리를 수행하거나 예외를 던질 수 있습니다.
            }
        }

        int result = service.communityInsert(vo);
        redirectAttributes.addFlashAttribute("result", result);

        return "redirect:/";
    }

    @GetMapping("/delete/{num}")
    public String deletePost(@PathVariable int num, RedirectAttributes redirectAttributes) {
        int result = service.deletePost(num);

        if (result > 0) {
            redirectAttributes.addFlashAttribute("message", "게시글이 삭제되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("message", "게시글 삭제에 실패했습니다.");
        }

        return "redirect:/community/walls";
    }

    @PostMapping("/walls/{num}/like")
    @ResponseBody
    public ResponseEntity<Integer> likePost(@PathVariable int num) {
        // 게시글 번호를 이용하여 좋아요 수를 증가시키는 로직을 구현
        int updatedLikes = service.likePost(num);
        return ResponseEntity.ok(updatedLikes);
    }

}
