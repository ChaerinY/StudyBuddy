package comment;

public class Comment {
	
	/*create table comments(
    commentID int not null,		// 댓글 ID
    postID int not null,		// 게시글 ID
    userID varchar2(20 byte) not null,		// 유저 ID
    userName varchar2(20 byte) not null,	// 유저 닉네임
    commentDate varchar(20),		// 작성일자
    commentContent NVARCHAR2(100)	// 작성내용
	);

	CREATE SEQUENCE comment_seq;

	alter table comments add primary key (commentID);
	alter table comments add constraint comments foreign key (postID) references posts(postID) on delete cascade;
	*/
	
	private int commentID;
	private int postID;
	private String userID;
	private String userName;
	private String commentDate;
	private String commentContent;
	
	public int getCommentID() {
		return commentID;
	}
	public void setCommentID(int commentID) {
		this.commentID = commentID;
	}
	public int getPostID() {
		return postID;
	}
	public void setPostID(int postID) {
		this.postID = postID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(String commentDate) {
		this.commentDate = commentDate;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
}
