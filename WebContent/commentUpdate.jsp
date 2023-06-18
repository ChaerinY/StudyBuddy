<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.PostDAO" %>  
<%@ page import="post.Post" %>
<%@ page import="room.RoomDAO" %>  
<%@ page import="room.Room" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="comment.Comment" %>
<%@ page import="enrol.EnrolDAO" %>
<%@ page import="java.util.ArrayList" %>    
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="en">
	<% 
		String userID = null;
		if(session.getAttribute("userID")!= null){      //세션이 있으면 userID값을 가지고 없다면 null값
			userID=(String) session.getAttribute("userID");
		}
		
		if(userID == null){  //로그인이 되어있지 않다면
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp;'");   //로그인페이지로 이동
			script.println("</script>");
		}
		
		int roomID = -1;
		String postType = null;
		
		int postIndex=0;
		int commentID=0;
		
		
		if (request.getParameter("postIndex") != null && request.getParameter("roomID") != null && request.getParameter("postType") != null && request.getParameter("commentID") != null){
			postIndex = Integer.parseInt(request.getParameter("postIndex"));   
			roomID = Integer.parseInt(request.getParameter("roomID"));
			postType = request.getParameter("postType");
			commentID = Integer.parseInt(request.getParameter("commentID"));
			/* a태그 링크타고 올때 studyBBS_View.jsp?postIndex=<%= list.get(i).getPostIndex() ~~~~에서 postIndex받아옴 */
		}
		
		if (postIndex==0 || commentID==0){
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않습니다.')");
			script.println("location.href='roomMain.jsp'");
			script.println("</script>");			
			
		}
		
		EnrolDAO enrolDAO = new EnrolDAO();
		int auth = enrolDAO.getAuth(roomID, userID);
		
		if(auth == -1 && roomID != 0){  // 방장이나 회원만 열람 가능
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('잘못된 접근입니다.')");
			script.println("location.href = 'main.jsp;'");  
			script.println("</script>");
		}
		
		Post post = new PostDAO().getPost(roomID, postType, postIndex);   //현재 보려는 post객체 가져오기
		Room room = new RoomDAO().getRoom(roomID);
		Comment comment = new CommentDAO().getComment(commentID);
		
	%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StudyBuddy - <%=postType%></title>
    <!-- 부트스트랩 CSS 링크 추가 -->
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<!-- 구글 폰트 사용 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

<style>
	* {font-family: 'Nanum Gothic', sans-serif;}  /*페이지 전체에 나눔고딕 폰트 사용*/
</style>

</head>

<body>
    <header class="p-3 text-bg-dark">
        <div class="container">
            <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
	            <img src="img/wig_whtie.png" width="30px" style="padding-right: 7px;">
	            <a href="main.jsp" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none"
	                style="padding-right: 30px;">
	                StudyBuddy
	            </a>

	            <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
	              <li><a href="main.jsp" class="nav-link px-2 text-white">홈</a></li>
	              <li><a href="recruitBBS.jsp" class="nav-link px-2 text-white">모집게시판</a></li>
	              <li><a href="mystudy.jsp" class="nav-link px-2 text-white">나의스터디</a></li>
	            </ul>

            <% 
    			if(userID == null) {    //로그인이 되어있지 않다면 로그인과 회원가입 버튼을 표시, a태그 밑줄 없애고 색상변경
    		%>
	    		<div class="text-end">
	              <button type="button" class="btn btn-secondary me-2"><a href="login.jsp" style="color:#ffffff; text-decoration:none;">로그인</a></button>
	              <button type="button" class="btn btn-primary"><a href="join.jsp" style="color:#ffffff; text-decoration:none;">회원가입</a></button>
	            </div>
    				
    		<%	
    			} else {  //로그인이 되어있다면 로그아웃과 마이페이지 버튼을 표시
    		%>
    			<div class="text-end">
	              <button type="button" class="btn btn-secondary me-2"><a href="logoutAction.jsp" style="color:#ffffff; text-decoration:none;">로그아웃</a></button>
	              <button type="button" class="btn btn-primary"><a href="mypage.jsp" style="color:#ffffff; text-decoration:none;">마이페이지</a></button>
	            </div>
    			
    		<%  }
    		
    		%>
            </div>
        </div>
    </header>

    <div class="d-flex">
        <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px; height: auto;">
            <a href="roomMain.jsp?roomID=<%=room.getRoomID()%>" class="d-flex align-items-center link-dark text-decoration-none" style="margin: 10px;">
                <span class="fs-4" style="font-weight: bold;"><%=room.getRoomName()%></span>
            </a>
            <hr>
            <% if(roomID!=0) {  //모집게시판에선 안보이게 %>
            <ul class="nav nav-pills flex-column mb-auto">
            	<li class="nav-item"><a href="studyBBS.jsp?roomID=<%=roomID%>&postType=공지사항" class="nav-link link-dark" aria-current="page">· 공지사항 </a></li>
            	<li><a href="studyBBS.jsp?roomID=<%=roomID%>&postType=과제게시판" class="nav-link link-dark">· 과제게시판 </a></li>
            	<li><a href="studyBBS.jsp?roomID=<%=roomID%>&postType=QnA게시판" class="nav-link link-dark">· Q&A게시판 </a></li>
            	<li><a href="studyBBS.jsp?roomID=<%=roomID%>&postType=자유게시판" class="nav-link link-dark">· 자유게시판 </a></li>
            </ul>
            <% } %>
        </div>

		<!-- 사이드 바 옆 컨테이너 부분 -->
        <div class="container ms-3 mt-5" id="main">

            <div class="row">
					<div class="post-content">
						<h3> <%=post.getPostTitle()%> </h3>
						<hr>
						<div class="d-flex justify-content-between">
						<span>작성자: <%=post.getUserName() %></span><span></span><span>작성일자: <%=post.getPostDate()%> </span>
						</div>
						<hr>
						<div style="min-height:150px; white-space: pre-line;">  <!-- 개행 유지 -->
						<%=post.getPostContent() %>
						</div>
						<hr>
					</div>
					
					<div class="text-end">

						<br><br>
		<div class="container">
         <div class="row">
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
               <tbody>
               		<tr>
                  		<td align="left" bgcolor="skyblue">댓글</td>
               		</tr>
		       </tbody>
               </table>
           </div>
           <div class="container">
                  		<div class="row">
                  			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">                  	
                  				<tbody>
                  				<%
                     				CommentDAO commentDAO = new CommentDAO();
                     				ArrayList<Comment> list = commentDAO.getList(post.getPostID());
                     				for(int i=0; i<list.size(); i++){	%>
                  					
                  					<tr>
                  						<td align="left"><%= list.get(i).getUserName() %></td>
                  						<td align="right"><%= list.get(i).getCommentDate() %></td>
                  					</tr>
                  		
                  					<tr>
                  						<td align="left"><div style="white-space: pre-line;"><%= list.get(i).getCommentContent() %></div></td>
                  						<%
											if(userID != null && userID.equals(list.get(i).getUserID())){ //해당 댓글이 본인이라면 수정과 삭제가 가능
										%>
                  						<td align="right">
                  						<a href="commentUpdate.jsp?postIndex=<%=postIndex%>&roomID=<%=roomID%>&postType=<%=postType%>&commentID=<%=list.get(i).getCommentID()%>" 
                  						class="btn btn-primary">수정</a>
                  						<a href="commentDeleteAction.jsp?postIndex=<%=postIndex%>&roomID=<%=roomID%>&postType=<%=postType%>&commentID=<%=list.get(i).getCommentID()%>" 
                  						onclick="return confirm('정말로 삭제하시겠습니까?')" class="btn btn-secondary">삭제</a></td>
                  					</tr>
                  					<%}}%>
                  				</tbody>
                  			</table>
                  		</div>
            </div>
      </div>
      <br>
		<div class="container">
      		<div class="row">
            	<form method="post" action="commentUpdateAction.jsp?postIndex=<%=postIndex%>&roomID=<%=roomID%>&postType=<%=postType%>&commentID=<%=commentID%>"  enctype="multipart/form-data">
				<table class="table" style="text-align: center; border: 1px solid #dddddd; background-color: aliceblue;" >
					<tbody>
						<input type="hidden" name="userID" value="<%=comment.getUserID()%>">
    					<input type="hidden" name="postID" value="<%=comment.getPostID()%>">
						<tr>
							<td><textarea class="form-control" placeholder="수정할 내용을 입력하세요." style="width: 100%;" name="commentContent" maxlength="100"><%=comment.getCommentContent() %></textarea>
								<br>
								<input type="file" class="form-control" name="uploadfile">
									<input type="hidden" name="prefile" value="<%=comment.getFileName()%>">
	                        
                     		</td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary" value="댓글 수정" style="margin-bottom:30px;">
		</form>
      		</div>
   		</div>
		</div>
	</div>
	</div>
	</div>

    <!-- 부트스트랩 JS 및 jQuery 추가 -->
    <script type="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>

</html>