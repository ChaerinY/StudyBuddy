package user;

// �����͸� ó���ϰ� �����ϴ� ��� -> JAVA Beans
public class User {
	
	/* �����ͺ��̽� ������ ���� �÷��� Ÿ�� �״�� ���� ���� 
	create table userlist (
    	userID VARCHAR(20) primary KEY,
    	userPassword VARCHAR(20),
    	userName VARCHAR(20),
    	userEmail VARCHAR(50)
	);
	*/    

    private String userID;
    private String userPassword;
    private String userName;
    private String userEmail;
    
    // ������ ���콺 > Source > Generate Getter & Setter > Select All > Finish 
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}       
	
}