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
	
	public PostDAO() {    //�ڵ����� �����ͺ��̽� Ŀ�ؼ��� �̷������ �ֵ��� ������ �ۼ�
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
	
	
	public String getDate() {    //�ۼ��ð� �ҷ�����
		
		String SQL = "select to_char(sysdate, 'yyyy-mm-dd') from dual";  //����ð� �������� ����
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "";   //�����ͺ��̽� ����
		
	}
	
	
	public int getNext(int roomID, String postType) {    //�ش�Խ����� ���� �ε��� ��ȣ ��������
		
		String SQL = "SELECT postIndex FROM posts WHERE roomID = ? AND postType= ? ORDER BY postIndex DESC";  //���� �ֱ� �Խñ� ��ȣ
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomID);
			pstmt.setString(2, postType);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1;   //ù �Խù��� ���
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;   //�����ͺ��̽� ����
	}
	
	public int write(int roomID, String postType, String postTitle, String userID, String postContent, String userName) {    
		
		// postid, roomid, userid, posttype, title, content, date, username, postindex ������ ����
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
		
		return -1;   //�����ͺ��̽� ����. �μ�Ʈ���� ���������� insert�������� 0�̻��� ��� ��ȯ, ���н� -1 ��ȯ
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
				
				//postid, roomid, userid, posttype, title, content, date, username, postindex ��
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
				return true;            //Ư���������� �����ϳ�?
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Post getPost(int roomID, String postType, int postIndex) {   //�Խñ� ������ ������
		
		String SQL = "SELECT * FROM posts WHERE postIndex = ? AND roomID = ? AND postType = ?"; 
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, postIndex);
			pstmt.setInt(2, roomID);
			pstmt.setString(3, postType);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Post post = new Post();
				
				//postid, roomid, userid, posttype, title, content, date, username, postindex ��
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
		
		return -1;   //�����ͺ��̽� ����. ���������� update�������� 0�̻��� ��� ��ȯ, ���н� -1 ��ȯ
	}
	
	public int delete(int roomID, String postType, int postIndex) {
		
		
		String SQL = "delete from posts where roomID=? AND postType=? AND postIndex=?"; 
		//����Ʈ ���ڵ� ����
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomID);
			pstmt.setString(2, postType);
			pstmt.setInt(3, postIndex);
			pstmt.executeUpdate();
			
			String SQL2 = "update posts set postIndex = ROWNUM where roomID=? AND postType=?";    //�ش� �Խ����� postIndex ������
			PreparedStatement pstmt2 = conn.prepareStatement(SQL2);
			pstmt2.setInt(1, roomID);
			pstmt2.setString(2, postType);
			
			return pstmt2.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;   //�����ͺ��̽� ����. 
		
	}
}
