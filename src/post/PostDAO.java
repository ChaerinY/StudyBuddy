package post;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import post.Post;

public class PostDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public PostDAO() {    //자동으로 데이터베이스 커넥션이 이루어질수 있도록 생성자 작성
		try {
			String url="jdbc:oracle:thin:@localhost:1521";
			String user ="scott";
			String password ="tiger";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, password);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public String getDate() {    //작성시각 불러오기
		
		String SQL = "select to_char(sysdate, 'yyyy-mm-dd') from dual";  //현재시간 가져오는 구문
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
	
	
	public int getNext(int roomID, String postType) {    //해당게시판의 다음 인덱스 번호 가져오기
		
		String SQL = "SELECT postIndex FROM posts WHERE roomID = ? AND postType= ? ORDER BY postIndex DESC";  //제일 최근 게시글 번호
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomID);
			pstmt.setString(2, postType);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1;   //첫 게시물인 경우
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;   //데이터베이스 오류
	}
	
	public int write(int roomID, String postType, String postTitle, String userID, String postContent, String userName) {    
		
		// postid, roomid, userid, posttype, title, content, date, username, postindex 순으로 삽입
		String SQL = "INSERT INTO posts VALUES (post_seq.nextval,?,?,?,?,?,?,?,?)";  
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomID);
			
			pstmt.setString(2, userID);
			pstmt.setString(3, postType);
			pstmt.setString(4, postTitle);
			pstmt.setString(5, postContent);
			pstmt.setString(6, getDate());
			pstmt.setString(7, userName);
			pstmt.setInt(8, getNext(roomID, postType));
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;   //데이터베이스 오류. 인서트문은 성공적으로 insert했을때는 0이상의 결과 반환, 실패시 -1 반환
	}
	
	
	public ArrayList<Post> getList(int roomID, String postType, int pageNumber) {
		
		String SQL = "SELECT * FROM (SELECT * FROM posts WHERE postIndex < ? AND roomID = ? AND postType = ? ORDER BY postIndex DESC) WHERE ROWNUM<=10"; 
		ArrayList<Post> list = new ArrayList<Post>();
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext(roomID, postType) - (pageNumber -1 ) * 10);
			pstmt.setInt(2, roomID);
			pstmt.setString(3, postType);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				Post post = new Post();
				
				//postid, roomid, userid, posttype, title, content, date, username, postindex 순
				post.setPostID(rs.getInt(1));
				post.setRoomID(rs.getInt(2));
				post.setUserID(rs.getString(3));
				post.setPostType(rs.getString(4));
				post.setPostTitle(rs.getString(5));
				post.setPostContent(rs.getString(6));
				post.setPostDate(rs.getString(7));
				post.setUserName(rs.getString(8));
				post.setPostIndex(rs.getInt(9));
				
				list.add(post);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public boolean nextPage(int roomID, String postType, int pageNumber) {
		
		String SQL = "SELECT * FROM posts WHERE postIndex < ? AND roomID = ? AND postType = ?"; 
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext(roomID, postType) - (pageNumber -1 ) * 10);
			pstmt.setInt(2, roomID);
			pstmt.setString(3, postType);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				return true;            //특정페이지가 존재하냐?
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Post getPost(int roomID, String postType, int postIndex) {   //게시글 정보를 가져옴
		
		String SQL = "SELECT * FROM posts WHERE postIndex = ? AND roomID = ? AND postType = ?"; 
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, postIndex);
			pstmt.setInt(2, roomID);
			pstmt.setString(3, postType);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Post post = new Post();
				
				//postid, roomid, userid, posttype, title, content, date, username, postindex 순
				post.setPostID(rs.getInt(1));
				post.setRoomID(rs.getInt(2));
				post.setUserID(rs.getString(3));
				post.setPostType(rs.getString(4));
				post.setPostTitle(rs.getString(5));
				post.setPostContent(rs.getString(6));
				post.setPostDate(rs.getString(7));
				post.setUserName(rs.getString(8));
				post.setPostIndex(rs.getInt(9));
				
				return post;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	public int update(int roomID, String postType, int postIndex, String postTitle, String postContent) {    
		
		String SQL = "UPDATE posts SET postTitle=? , postContent=? WHERE roomID=? AND postType=? AND postIndex=?";  
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, postTitle);
			pstmt.setString(2, postContent);
			pstmt.setInt(3, roomID);
			pstmt.setString(4, postType);
			pstmt.setInt(5, postIndex);
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;   //데이터베이스 오류. 성공적으로 update했을때는 0이상의 결과 반환, 실패시 -1 반환
	}
	
	public int delete(int roomID, String postType, int postIndex) {
		
		
		String SQL = "delete from posts where roomID=? AND postType=? AND postIndex=?"; 
		//포스트 레코드 삭제
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomID);
			pstmt.setString(2, postType);
			pstmt.setInt(3, postIndex);
			pstmt.executeUpdate();
			
			String SQL2 = "update posts set postIndex = ROWNUM where roomID=? AND postType=?";    //해당 게시판의 postIndex 재정렬
			PreparedStatement pstmt2 = conn.prepareStatement(SQL2);
			pstmt2.setInt(1, roomID);
			pstmt2.setString(2, postType);
			
			return pstmt2.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;   //데이터베이스 오류. 
		
	}
}
