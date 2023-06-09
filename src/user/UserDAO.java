package user;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {


	//DAO�� �����ͺ��̽� ���� ��ü�� ���ڷμ� ���������� �����ͺ��̽����� ȸ�������� �ҷ����ų� ������ �ְ����Ҷ� �̿��ϴ� ������Ʈ


	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {    //�ڵ����� �����ͺ��̽� Ŀ�ؼ��� �̷������ �ֵ��� ������ �ۼ�
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
	
	public int login(String userID, String userPassword) {       //�α����ϴ� �Լ�
		String SQL = "SELECT userPassword FROM userlist WHERE userID = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);    // ù��°�ڸ� ����ǥ�� userID ����
			rs = pstmt.executeQuery();     //������ ����
			if(rs.next()) {              //userID �����ϸ�
				if(rs.getString(1).equals(userPassword)) {     //��й�ȣ ��ġ�ϸ�
					return 1;    //�α��� ����
				}
				else
					return 0;   //��й�ȣ ����ġ
			}
			return -1;  //���̵� ����
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -2; //�����ͺ��̽� ����
	}
	
	
	// ����ڸ� �߰��ϴ� �Լ�
	
	public int join(User user) {
		
		String SQL = "INSERT INTO userlist VALUES (?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserEmail());    //�� ����ǥ ��ġ�� ����
			
			return pstmt.executeUpdate();  //������ ����. ������ 0�̻��� ��ȯ
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽�����
	}
	
	public String searchName(String userID) {
		String SQL = "SELECT userName FROM userlist WHERE userID = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);    // ù��°�ڸ� ����ǥ�� userID ����
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String name = rs.getString(1);
				return name;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null; // ���ų� �����ͺ��̽� ����
	}
	
}
