package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import comment.Comment;

public class CommentDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public CommentDAO() {
		try {
			String url = "jdbc:oracle:thin:@localhost:1521";
			String user = "scott";
			String password = "tiger";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, password);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {    //작성시각 불러오기
		
		String SQL = "select to_char(sysdate, 'yyyy-mm-dd HH24:MI') from dual";  //현재시간 가져오는 구문
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "";   //데이터베이스 오류
	}
	
	
	public int write(int postID, String userID, String userName, String commentContent, String fileName) { // 댓글 작성
		String SQL = "INSERT INTO comments values (comment_seq.nextval,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, postID);
			pstmt.setString(2,  userID);
			pstmt.setString(3,  userName);
			pstmt.setString(4, getDate());
			pstmt.setString(5, commentContent);
			pstmt.setString(6, fileName);
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Comment> getList(int postID){	// postID에 해당하는 게시글의 댓글 목록
		String SQL="SELECT * from comments where postID = ? order by commentID asc";
		ArrayList<Comment> list = new ArrayList<Comment>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, postID);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Comment comment = new Comment();
				comment.setCommentID(rs.getInt(1));
				comment.setPostID(rs.getInt(2));
				comment.setUserID(rs.getString(3));
				comment.setUserName(rs.getString(4));
				comment.setCommentDate(rs.getString(5));
				comment.setCommentContent(rs.getString(6));
				comment.setFileName(rs.getString(7));
				list.add(comment);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;//댓글 리스트 반환
	}
	
	public Comment getComment(int commentID) {//하나의 댓글 내용을 불러오는 함수
		String SQL="SELECT * from comments where commentID = ?";
		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, commentID);
			rs=pstmt.executeQuery();//select
			if(rs.next()) {//결과가 있다면
				Comment comment = new Comment();
				comment.setCommentID(rs.getInt(1));
				comment.setPostID(rs.getInt(2));
				comment.setUserID(rs.getString(3));
				comment.setUserName(rs.getString(4));
				comment.setCommentDate(rs.getString(5));
				comment.setCommentContent(rs.getString(6));
				comment.setFileName(rs.getString(7));
				return comment;
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int commentID, String commentContent, String fileName ) {	// 댓글 수정
		String SQL="update comments set commentContent = ?, fileName = ? where commentID = ?";//특정한 아이디에 해당하는 내용을 바꿔준다. 
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, commentContent);
			pstmt.setString(2, fileName);
			pstmt.setInt(3, commentID);
			return pstmt.executeUpdate();	
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int delete(int commentID) {	// 댓글 삭제
		String SQL = "delete from comments where commentID=?"; 
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, commentID);
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
}
