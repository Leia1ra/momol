package com.example.momol.DAO;

import com.example.momol.DTO.CommunityVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.sql.*;

@Component
public class BoardDAO {
    private Connection conn;
    private ResultSet rs;
    @Autowired
    private JdbcTemplate jdbcTemplate;
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/momol";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "tiger1234";

    public List<CommunityVO> getAllBoards() {
        List<CommunityVO> boards = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
             Statement statement = connection.createStatement();
             // ResultSet resultSet = statement.executeQuery("SELECT * FROM board ORDER BY num DESC ")) {
            ResultSet resultSet = statement.executeQuery("SELECT num, catnum, board.UID as UID, title, writetime, views, likes, Nick, Category FROM board join user u on board.UID = u.UID join `board_ category` bc on catnum = bc.KeyNo ORDER BY writetime DESC ")) {
            while (resultSet.next()) {
                CommunityVO vo = new CommunityVO();

/*                vo.setNum(resultSet.getInt("num"));
                vo.setCatnum(resultSet.getInt("catnum"));
                vo.setUID(resultSet.getString("UID"));
                vo.setTitle(resultSet.getString("title"));
                vo.setWritetime(resultSet.getDate("writetime"));
                vo.setContent(resultSet.getString("content"));
                vo.setLikes(resultSet.getInt("likes"));
                vo.setViews(resultSet.getInt("views"));
                vo.setDeleted(resultSet.getBoolean("deleted"));
                vo = vo(resultSet.getInt("num"));*/

                vo.setNum(resultSet.getInt("num"));
                vo.setCatnum(resultSet.getInt("catnum"));
                vo.setUID(resultSet.getString("UID"));
                vo.setTitle(resultSet.getString("title"));
                vo.setWritetime(resultSet.getDate("writetime"));
                vo.setViews(resultSet.getInt("views"));
                vo.setLikes(resultSet.getInt("likes"));
                vo.setNick(resultSet.getString("Nick"));
                // vo.setDeleted(resultSet.getBoolean("deleted"));
                vo.setCategory(resultSet.getString("Category"));
                vo.setWritetime_Ts(resultSet.getTimestamp("writetime"));

                boards.add(vo);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return boards;
    }

    public CommunityVO vo(int num) {
        // String SQL = "SELECT * from board where num = ?";
        String SQL = "SELECT Category, u.nick as nick, title, content, writetime, views, likes, u.UID from board join user u on board.UID = u.UID join `board_ category` bc on catnum = bc.KeyNo where num = ?";

        try {
            conn = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                CommunityVO vo = new CommunityVO();
                // vo.setNum(rs.getInt("num"));
                // vo.setCatnum(rs.getInt("catnum"));
                // vo.setUID(rs.getString("UID"));
                // vo.setTitle(rs.getString("title"));
                // vo.setWritetime(rs.getDate("writetime"));
                // vo.setContent(rs.getString("content"));
                // vo.setLikes(rs.getInt("likes"));
                // vo.setViews(rs.getInt("views"));
                // vo.setDeleted(rs.getBoolean("deleted"));

                vo.setUID(rs.getString("UID"));
                vo.setCategory(rs.getString("Category"));
                vo.setNick(rs.getString("Nick"));
                vo.setTitle(rs.getString("title"));
                vo.setContent(rs.getString("content"));
                vo.setWritetime(rs.getDate("writetime"));
                vo.setViews(rs.getInt("views"));
                vo.setLikes(rs.getInt("likes"));
                vo.setWritetime_Ts(rs.getTimestamp("writetime"));
                vo.setWritetime_Sql(rs.getDate("writetime"));

                return vo;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public int viewUpdate(int views, int num) {
        String SQL = "update board set views = ? where num = ?";
        try {
            conn = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, views);
            pstmt.setInt(2, num);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int deletePost(int num) {
        String SQL = "DELETE FROM board WHERE num = ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement(SQL)) {

            pstmt.setInt(1, num);
            return pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }

    public int getCommentCount(int num) throws SQLException {
        int commentCount = 0;

        try (Connection connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
                     PreparedStatement pstmt = connection.prepareStatement("SELECT COUNT(*) AS commentCount FROM comments WHERE num = ?")) {
            pstmt.setInt(1, num);

            try (ResultSet resultSet = pstmt.executeQuery()) {
                if (resultSet.next()) {
                    commentCount = resultSet.getInt("commentCount");
                }
            }
        }

        return commentCount;
    }

    public int incrementLikes(int num) {
        // 게시글 번호를 이용하여 데이터베이스에서 좋아요 수를 증가시키는 로직
        String sql = "UPDATE board SET likes = likes + 1 WHERE num = ?";
        return jdbcTemplate.update(sql, num);
    }

    public int getLikes(int num) {
        // 게시글 번호를 이용하여 데이터베이스에서 현재 좋아요 수를 가져오는 로직
        String sql = "SELECT likes FROM board WHERE num = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, num);
    }

    public int updatePost(CommunityVO vo) {
        String SQL = "UPDATE board SET catnum=?, UID=?, title=?, writetime=?, content=?, likes=?, views=?, deleted=? WHERE num=?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement(SQL)) {

            pstmt.setInt(1, vo.getCatnum());
            pstmt.setString(2, vo.getUID());
            pstmt.setString(3, vo.getTitle());
            pstmt.setDate(4, (Date) vo.getWritetime());
            pstmt.setString(5, vo.getContent());
            pstmt.setInt(6, vo.getLikes());
            pstmt.setInt(7, vo.getViews());
            pstmt.setBoolean(8, vo.isDeleted());
            pstmt.setInt(9, vo.getNum());

            return pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }
}

