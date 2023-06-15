package enrol;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class EnrolDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public EnrolDAO() {
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
	
	public int enrol(int roomID,  String userID, int auth) {    
		
		String SQL = "INSERT INTO enrol VALUES (?,?,?)";  
		try {
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomID);
			pstmt.setString(2, userID);
			pstmt.setInt(3, auth);

			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public int getAuth(int roomID, String userID){	// 스터디룸에 대한 유저의 권한
		
		String SQL = "SELECT auth FROM enrol WHERE roomID=? AND userID=?";
		
		try{
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomID);
			pstmt.setString(2, userID);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				
				int result = rs.getInt(1);
		
				return result;
			}
		} catch(Exception e){
		e.printStackTrace();
		}
		return -1;
	}
	
	
	public int withdrawal(int roomID,  String userID, int auth) {	// 탈퇴하기
		
		String SQL = "DELETE FROM enrol WHERE roomID=? AND userID=? AND auth=?";
		try {
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomID);
			pstmt.setString(2, userID);
			pstmt.setInt(3, auth);
		
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
	public int memberNum(int roomID) {       //	해당 스터디룸에 현재 가입한 인원수
		String SQL = "select count(*) from enrol where roomid=?";  
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomID);
			rs = pstmt.executeQuery();
			if(rs.next()){
				
				int result = rs.getInt(1);
		
				return result;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
}