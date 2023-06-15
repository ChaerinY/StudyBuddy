package post;

public class Post {

	/*
	create table posts (
    postID INT PRIMARY KEY,     //포스트 고유아이디
    roomID INT,
    userID VARCHAR(20),
    postType VARCHAR(20),         //카테고리. 모집게시판/공지사항/과제게시판/Q&A게시판/자유게시판
    postTitle NVARCHAR2(50),     //제한 50자이내
    postContent NVARCHAR2(2000),     //제한 2000자이내
    postDate VARCHAR(20),
    userName VARCHAR(20),    // 작성자란에 id대신 닉네임 표시하기위해
    postIndex INT          //각게시판 안에서의 인덱스
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