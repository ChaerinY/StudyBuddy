package enrol;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import enrol.Enrol;
import room.Room;

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
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomID);
			pstmt.setString(2, userID);
			pstmt.setInt(3, auth);

			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	
	public int delete(int roomID,  String userID, int auth) {
		
		//������ 0�� ȸ����
		//���ۼ�

		
		return -1;
		
	}
	
	public int memberNum(int roomID) {       //�ش� ���͵�뿡 ���� ������ �ο���
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
