package room;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class RoomDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public RoomDAO() {
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
	
	
	public int create(int roomID, String hostID, String roomName, String roomContent, int maximum, String fileName) {    
		

		String SQL = "INSERT INTO room VALUES (?, ?, ?, ?, ?, ?)";  
		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomID);
			pstmt.setString(2, hostID);
			pstmt.setString(3, roomName);
			pstmt.setString(4, roomContent);
			pstmt.setInt(5, maximum);
			pstmt.setString(6, fileName);

			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
public ArrayList<Room> getList(String userID) {
		
		String SQL = "SELECT * FROM room"; 
		ArrayList<Room> list = new ArrayList<Room>();
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				Room room = new Room();
				
				room.setRoomID(rs.getInt(1));
				room.setHostID(rs.getString(2));
				room.setRoomName(rs.getString(3));
				room.setRoomContent(rs.getString(4));
				room.setMaximum(rs.getInt(5));
				room.setFileName(rs.getString(6));
				
				list.add(room);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

public ArrayList<Room> getMyList(String userID) {
	
	String SQL = "SELECT roomid,hostid,roomname,roomcontent,maximum,filename FROM room NATURAL JOIN enrol WHERE userid=?";  
	ArrayList<Room> list = new ArrayList<Room>();
	
	try {
		
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, userID);
		
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
			
			Room room = new Room();
			
			room.setRoomID(rs.getInt(1));
			room.setHostID(rs.getString(2));
			room.setRoomName(rs.getString(3));
			room.setRoomContent(rs.getString(4));
			room.setMaximum(rs.getInt(5));
			room.setFileName(rs.getString(6));
			
			list.add(room);
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	return list;
}

// searchRoom대신 getroom으로 수정

//public ArrayList<Room> searchRoom(Integer roomID) {
//	
//	String SQL = "SELECT * FROM room where roomid=?"; 
//	ArrayList<Room> list = new ArrayList<Room>();
//	
//	try {
//		
//		PreparedStatement pstmt = conn.prepareStatement(SQL);
//		pstmt.setInt(1, roomID);
//		
//		rs = pstmt.executeQuery();
//		
//		while (rs.next()) {
//			
//			Room room = new Room();
//			
//			room.setRoomID(rs.getInt(1));
//			room.setHostID(rs.getString(2));
//			room.setRoomName(rs.getString(3));
//			room.setRoomContent(rs.getString(4));
//			room.setMaximum(rs.getInt(5));
//			list.add(room);
//		}
//		
//	} catch (Exception e) {
//		e.printStackTrace();
//	}
//	return list;
//}

public Room getRoom(int roomID){
	
	String SQL = "SELECT * FROM room WHERE roomID=?";
	
	try{
		
		pstmt = conn.prepareStatement(SQL);
		pstmt.setInt(1, roomID);
		
		rs = pstmt.executeQuery();
		if(rs.next()){
			Room room = new Room();
			
			room.setRoomID(rs.getInt(1));
			room.setHostID(rs.getString(2));
			room.setRoomName(rs.getString(3));
			room.setRoomContent(rs.getString(4));
			room.setMaximum(rs.getInt(5));
			room.setFileName(rs.getString(6));
	
			return room;
		}
	} catch(Exception e){
	e.printStackTrace();
	}
	return null;
}

public boolean checkExists(int roomID) {
	
	String SQL = "SELECT * FROM room WHERE roomID=?";
	
	try{
		
		pstmt = conn.prepareStatement(SQL);
		pstmt.setInt(1, roomID);
		
		rs = pstmt.executeQuery();
		if(rs.next()){
			return true;          //해당 roomID를 가진 스터디룸이 존재
		}
	} catch(Exception e){
	e.printStackTrace();
	}
	return false;
}

public int maxMemberNum(int roomID) {        //해당 스터디룸의 최대인원수 리턴
	
	String SQL = "SELECT maximum FROM room WHERE roomID=?";    
	
	try{
		
		pstmt = conn.prepareStatement(SQL);
		pstmt.setInt(1, roomID);
		
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

	public int delete(int roomID) {
		String SQL = "delete from room where roomID=?"; 
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, roomID);
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}

}