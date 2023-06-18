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
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.ArrayList" %>    

<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StudyBuddy - 모집게시판</title>
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
	<% 
		String userID = null;
		String userName = null;
		if(session.getAttribute("userID")!= null){      //세션이 있으면 userID값을 가지고 없다면 null값
			userID=(String) session.getAttribute("userID");
			userName=(String) session.getAttribute("userName");
		}
		
		int roomID = 0; // roomID 0번은 모집게시판 의미.
		String postType = "모집게시판";
		
		int postIndex=0;
		
		
		if (request.getParameter("postIndex") != null){
			postIndex = Integer.parseInt(request.getParameter("postIndex"));   
			/* a태그 링크타고 올때 recruit_view.jsp?postIndex=<%= list.get(i).getPostIndex() ~~~~에서 postIndex받아옴 */
			
		}
		
		if (postIndex==0){
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='recruitBBS.jsp'");
			script.println("</script>");			
			
		}
		
		Post post = new PostDAO().getPost(roomID, postType, postIndex);   //현재 보려는 post객체 가져오기
		
	%>

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
            <a href="recruitBBS.jsp" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none" style="padding: 20px;">
                <span class="fs-4">모집게시판</span>
            </a>
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
						<br>
							<% if (post.getFileName()!=null){	//파일이 이미지인 경우
							if(post.getFileName().contains(".png")||post.getFileName().contains(".jpg")){%>
								<img src="upload/<%=post.getFileName()%>" style="width: 600px;"/>
							<%}else{%>
							<h6><span style="color:gray; font-weight:bold">[ 첨부파일 ] </span><a href="./filedownload.jsp?filename=<%=post.getFileName() %>"><%=post.getFileName() %></a></h6>
							<%}} %>
						<hr>
					</div>
					
					<div class="text-end">
					<a href="recruitBBS.jsp" class="btn btn-primary"> 목록으로 </a>

					<% 
						if(userID != null && userID.equals(post.getUserID())) {    //작성자와 현재 로그인한사람이 같으면 수정삭제 버튼출력됨
							
					%>
						<a href="update.jsp?roomID=<%=roomID%>&postType=<%=postType%>&postIndex=<%=postIndex%>" class="btn btn-primary"> 수정 </a>
						<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?roomID=<%=roomID%>&postType=<%=postType%>&postIndex=<%=postIndex%>" class="btn btn-secondary"> 삭제 </a>
					<% 		
						}
					
					%>
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
                  						<td align="left"><div style="white-space: pre-line;"><%= list.get(i).getCommentContent() %></div>
                  						
                  						
                  						<% if (list.get(i).getFileName()!=null){	//파일이 이미지인 경우
							if(list.get(i).getFileName().contains(".png")||list.get(i).getFileName().contains(".jpg")){%>
								<img src="upload/<%=list.get(i).getFileName()%>" style="width: 600px;"/>
							<%}else{%>
							<br>
							<h6><span style="color:gray; font-weight:bold">[ 첨부파일 ] </span><a href="./filedownload.jsp?filename=<%=list.get(i).getFileName() %>"><%=list.get(i).getFileName() %></a></h6>
							<%}} %>
                  						
                  						</td>
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
            	<form method="post" action="submitAction.jsp" enctype="multipart/form-data">
            		<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd; background-color: aliceblue;"" >
               			<tbody>
                  			<tr>
                     			<td align="left">댓글 작성</td>
                  			</tr>
                  			<tr>
                     			<td>
                     			<input type="hidden" name="userName" value="<%=userName%>">
                     			<input type="hidden" name="postID" value="<%=post.getPostID()%>">
                     			<textarea class="form-control" placeholder="댓글 쓰기" style="width: 100%;" name="commentContent" maxlength="100"></textarea>
                     			
                     			<!-- 파일 첨부 -->
                     			<input type="file" class="form-control" name="uploadfile" style="margin-top:10px;">
                     			</td>
                  			</tr>
               			</tbody>
            		</table>
            		<input type="submit" class="btn btn-primary" value="댓글 쓰기" style="margin-bottom:30px;">
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