package enrol;

public class Enrol {

	/*
	CREATE TABLE ENROL (
	  ROOMID NUMBER NOT NULL,
	  USERID VARCHAR2(20 BYTE) NOT NULL,
	  AUTH NUMBER DEFAULT 0,
	  PRIMARY KEY (ROOMID, USERID)
	); 
	 */
	
	private int roomID;
    private String userID;
    private int auth;
    
    public int getRoomID() {
		return roomID;
	}
	public void setRoomID(int roomID) {
		this.roomID = roomID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	 public int getAuth() {
			return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}
    
}