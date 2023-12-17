package com.example.momol.DAO;

import com.example.momol.DTO.CommentsVO;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class CommentsDAO {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/momol";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "tiger1234";


    public List<CommentsVO> getCommentsbyBoardNum(int num) {
        List<CommentsVO> comments = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM comments WHERE num = ?")) {
            pstmt.setInt(1, num);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                CommentsVO comment = new CommentsVO();
                comment.setUID2(rs.getString("UID2"));
                comment.setNum(rs.getInt("num"));
                comment.setUID(rs.getInt("UID"));
                comment.setWritetime(rs.getDate("writetime"));
                comment.setContent(rs.getString("content"));
                comment.setLikes(rs.getInt("likes"));
                comment.setDeleted(rs.getBoolean("deleted"));

                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }


    public int addComment(CommentsVO comment) {

        try (Connection connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement("INSERT INTO comments VALUES (?, ?, ?, ?, ?, ?, ?)")) {

            pstmt.setString(1, comment.getUID2());
            pstmt.setInt(2, comment.getNum());
            pstmt.setInt(3, comment.getUID());
            pstmt.setTimestamp(4, new java.sql.Timestamp(comment.getWritetime().getTime()));
            pstmt.setString(5, comment.getContent());
            pstmt.setInt(6, comment.getLikes());
            pstmt.setBoolean(7, comment.isDeleted());


            return pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }

    public int increaseLikes(int UID) {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement("UPDATE comments SET likes = likes + 1 WHERE UID = ?")) {

            pstmt.setInt(1, UID);

            return pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }
    public String findAuthor(String UID2) {
        String SQL = "SELECT UID2 FROM comments WHERE UID = ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement(SQL)) {

            pstmt.setString(1, UID2);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("UID2");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

}


