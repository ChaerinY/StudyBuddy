package user;

// 데이터를 처리하고 관리하는 기법 -> JAVA Beans
public class User {
	
	/* 데이터베이스 내에서 만든 컬럼과 타입 그대로 변수 선언 
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
    
    // 오른쪽 마우스 > Source > Generate Getter & Setter > Select All > Finish 
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