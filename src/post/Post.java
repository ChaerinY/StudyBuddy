package post;

public class Post {

	/*
	create table posts (
    postID INT PRIMARY KEY,     //����Ʈ �������̵�
    roomID INT,
    userID VARCHAR(20),
    postType VARCHAR(20),         //ī�װ�. �����Խ���/��������/�����Խ���/Q&A�Խ���/�����Խ���
    postTitle NVARCHAR2(20),     //���� 20���̳�
    postContent NVARCHAR2(2000),     //���� 2000���̳�
    postDate VARCHAR(20),
    userName VARCHAR(20),    // �ۼ��ڶ��� id��� �г��� ǥ���ϱ�����
    postIndex INT          //���Խ��� �ȿ����� �ε���
	); 
	 */
	
	private int postID;
	private int roomID;
    private String userID;
    private String postType;
    private String postTitle;
    private String postContent;
    private String postDate;
    private String userName;
    private int postIndex;
    
	public int getPostID() {
		return postID;
	}
	public void setPostID(int postID) {
		this.postID = postID;
	}
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
	public String getPostType() {
		return postType;
	}
	public void setPostType(String postType) {
		this.postType = postType;
	}
	public String getPostTitle() {
		return postTitle;
	}
	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}
	public String getPostContent() {
		return postContent;
	}
	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}
	public String getPostDate() {
		return postDate;
	}
	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getPostIndex() {
		return postIndex;
	}
	public void setPostIndex(int postIndex) {
		this.postIndex = postIndex;
	}
    
}
