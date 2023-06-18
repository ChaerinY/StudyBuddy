<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="post.PostDAO" %>  
<%@ page import="post.Post" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StudyBuddy 글작성</title>
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
		
		if (request.getParameter("roomID") != null && request.getParameter("postType") != null
				&& request.getParameter("postIndex") != null){
			roomID = Integer.parseInt(request.getParameter("roomID"));
			postType = request.getParameter("postType");
			postIndex = Integer.parseInt(request.getParameter("postIndex"));   
			/* href 링크타고 올때 recruit_view.jsp?postIndex=<%= list.get(i).getPostIndex() ~~~~에서 postIndex받아옴 */
		}
		
		
		if (postIndex==0){
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");			
			
		}
		
		Post post = new PostDAO().getPost(roomID, postType, postIndex);   //현재 수정하려는 post객체 가져오기
		
		if(!userID.equals(post.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		
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

    			<div class="text-end">
	              <button type="button" class="btn btn-secondary me-2"><a href="logoutAction.jsp" style="color:#ffffff; text-decoration:none;">로그아웃</a></button>
	              <button type="button" class="btn btn-primary"><a href="mypage.jsp" style="color:#ffffff; text-decoration:none;">마이페이지</a></button>
	            </div>
    			
            </div>
        </div>
    </header>

    <div class="d-flex">
        <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px; height: calc(100vh - 75px);">
            <a href="#" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none" style="padding: 20px;">
                <span class="fs-4"><%=postType%></span>
            </a>
        </div>

        <div class="container ms-3 mt-5" id="main">

            <div class="row">
				<form method="post" action="updateAction.jsp" enctype="multipart/form-data">
				<table class="table" style="text-align:center; border: 1px solid #dddddd">
						<thead>
	                        <tr>
	                            <th style="background-color: #eeeeee; text-align: left; font-size:20pt">게시글 수정</th>
	                            <input type="hidden" name="roomID" value="<%=roomID%>">         <!-- 룸아이디랑 카테고리 안보이게 전달 -->
    							<input type="hidden" name="postType" value="<%=postType%>">
    							<input type="hidden" name="postIndex" value="<%=postIndex%>">
	                        </tr>
	                    </thead>
	                    <tbody id="post-list">
	                        <!-- 게시글양식이 들어갈 부분 -->
	                        <tr>
	                        	<td><input type="text" class="form-control" placeholder="글제목" name="postTitle" maxlength="50" value="<%=post.getPostTitle()%>"></td>
	                        </tr>

	                        <tr>
	                        	<td style="height:300px"><textarea class="form-control" placeholder="글내용" name="postContent" maxlength="2048" rows="15"><%=post.getPostContent()%></textarea></td>
	                        </tr>
	                        
	                        <tr>
	                        	<td><input type="file" class="form-control" name="uploadfile"></td>
	                        	<input type="hidden" name="prefile" value="<%=post.getFileName()%>">
	                        </tr>
	                    </tbody>			
				</table>
					<div class="text-end">
					<input type="submit" class="btn btn-primary" value="글수정">
					</div>
				</form>
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