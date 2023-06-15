package room;

public class Room {

	/*
	create table room (
    	roomID INT PRIMARY KEY,
    	hostID VARCHAR2(20),    
    	roomName NVARCHAR2(50),       
    	roomContent NVARCHAR2(2000),    
    	maximum INT        
	);  
	
	roomID = 0 인 모집게시판 미리 존재		
	insert into room values(0, 'System', '모집게시판', '모집게시판', 0);

	 */	

	private int roomID;
    private String hostID;
    private String roomName;
    private String roomContent;
    private int maximum;
    
	public int getRoomID() {
		return roomID;
	}
	public void setRoomID(int roomID) {
		this.roomID = roomID;
	}
	public String getHostID() {
		return hostID;
	}
	public void setHostID(String hostID) {
		this.hostID = hostID;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public String getRoomContent() {
		return roomContent;
	}
	public void setRoomContent(String roomContent) {
		this.roomContent = roomContent;
	}
	public int getMaximum() {
		return maximum;
	}
	public void setMaximum(int maximum) {
		this.maximum = maximum;
	}
}