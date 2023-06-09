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
	
}
