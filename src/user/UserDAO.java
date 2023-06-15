package user;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {


	//DAO란 데이터베이스 접근 객체의 약자로서 실질적으로 데이터베이스에서 회원정보를 불러오거나 정보를 넣고자할때 이용하는 오브젝트


	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {    //자동으로 데이터베이스 커넥션이 이루어질수 있도록 생성자 작성
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
	
	public int login(String userID, String userPassword) {       //로그인하는 함수
		String SQL = "SELECT userPassword FROM userlist WHERE userID = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);    // 첫번째자리 물음표에 userID 삽입
			rs = pstmt.executeQuery();     //쿼리문 실행
			if(rs.next()) {              //userID 존재하면
				if(rs.getString(1).equals(userPassword)) {     //비밀번호 일치하면
					return 1;    //로그인 성공
				}
				else
					return 0;   //비밀번호 불일치
			}
			return -1;  //아이디가 없음
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -2; //데이터베이스 오류
	}
	
	
	// 사용자를 추가하는 함수
	
	public int join(User user) {
		
		String SQL = "INSERT INTO userlist VALUES (?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserEmail());    //각 물음표 위치에 삽입
			
			return pstmt.executeUpdate();  //쿼리문 실행. 성공시 0이상을 반환
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스오류
	}
	
	public String searchName(String userID) {
		String SQL = "SELECT userName FROM userlist WHERE userID = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);    // 첫번째자리 물음표에 userID 삽입
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String name = rs.getString(1);
				return name;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null; // 없거나 데이터베이스 오류
	}
	
	public User getUser(String userID) {              //아이디 검색으로 유저 정보 가져옴
		String SQL = "SELECT * FROM userlist WHERE userID = ?";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				User user = new User();
				
		    	// userID userPassword userName userEmail 순
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserEmail(rs.getString(4));
			
				return user;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(String userID, String userPass, String userName, String userEmail) {
		
		String SQL = "UPDATE userlist SET userPassword=? , userName=?, userEmail=? WHERE userID=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPass);
			pstmt.setString(2, userName);
			pstmt.setString(3, userEmail);
			pstmt.setString(4, userID);    //각 물음표 위치에 삽입
			
			pstmt.executeUpdate();  //쿼리문 실행. 성공시 0이상을 반환
			
			String SQL2 = "update posts set userName=? where userID=?";
			PreparedStatement pstmt2 = conn.prepareStatement(SQL2);
			pstmt2.setString(1, userName);
			pstmt2.setString(2,  userID);
			pstmt2.executeUpdate();
			
			String SQL3 = "update comments set userName=? where userID=?";
			PreparedStatement pstmt3 = conn.prepareStatement(SQL3);
			pstmt3.setString(1,  userName);
			pstmt3.setString(2,  userID);
	
			return pstmt3.executeUpdate(); 
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스오류
	}
	
	public int delete(String userID) {
		
		
		String SQL = "update posts set userName=?, userID=? where userID=?";    //탈퇴할 회원의 게시글의 닉네임과 아이디를 탈퇴회원으로 변경
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "(탈퇴회원)");
			pstmt.setString(2, "-");
			pstmt.setString(3, userID);
			pstmt.executeUpdate();
			
			String SQL2 = "update comments set userName=?, userID=? where userID=?";
			PreparedStatement pstmt2 = conn.prepareStatement(SQL2);
			pstmt2.setString(1, "(탈퇴회원)");
			pstmt2.setString(2, "-");
			pstmt2.setString(3, userID);
			pstmt2.executeUpdate();
			
			String SQL3 = "delete from room where hostID=?";
			PreparedStatement pstmt3 = conn.prepareStatement(SQL3);
			pstmt3.setString(1, userID);
			pstmt3.executeUpdate();
			
			String SQL4 = "delete from enrol where userID=?";        //탈퇴회원은 자동으로 가입했던 스터디그룹들도 탈퇴
			PreparedStatement pstmt4 = conn.prepareStatement(SQL4);
			pstmt4.setString(1, userID);
			pstmt4.executeUpdate();
			
			String SQL5 = "delete from userlist where userID=?";     //회원정보 삭제
			PreparedStatement pstmt5 = conn.prepareStatement(SQL5);
			pstmt5.setString(1, userID);
			
			return pstmt5.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;   //데이터베이스 오류. 
		
	}
}