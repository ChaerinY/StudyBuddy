<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="enrol.EnrolDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>

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
		
		if (request.getParameter("roomID") != null && request.getParameter("postType") != null){
			roomID = Integer.parseInt(request.getParameter("roomID"));
			postType = request.getParameter("postType");
		}
		
		if(roomID == -1 || postType == null){  
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('잘못된 접근입니다.')");
			script.println("location.href = 'main.jsp;'");  
			script.println("</script>");
		}else if(roomID != 0){		// 권한이 없는데 생성된 스터디룸에 접근하려 할 때
			EnrolDAO enrolDAO = new EnrolDAO();
			int auth = enrolDAO.getAuth(roomID, userID);	// roomID, userID의 값이 정확하게 있어야 함
			
			if(auth == -1){  
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('잘못된 접근입니다.')");
				script.println("location.href = 'main.jsp;'");  
				script.println("</script>");
			}
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
    	<% if(postType.equals("모집게시판")){ %>
        <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px; height: calc(100vh - 75px);">
            <a href="recruitBBS.jsp" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none" style="padding: 20px;">
                <span class="fs-4"><%=postType%></span>
            </a>
        </div>
        <%}else{ %>
        <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px; height: calc(100vh - 75px);">
            <a href="studyBBS.jsp?roomID=<%=roomID%>&postType=<%=postType%>" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none" style="padding: 20px;">
                <span class="fs-4"><%=postType%></span>
            </a>
        </div>
        <%} %>

        <div class="container ms-3 mt-5" id="main">

            <div class="row">
				<form method="post" action="writeAction.jsp" enctype="multipart/form-data">
					<div class="post-content">
						<input type="hidden" name="roomID" value="<%=roomID%>">         <!-- 룸아이디랑 카테고리 안보이게 전달 -->
    					<input type="hidden" name="postType" value="<%=postType%>">
						<h3> 게시판 글쓰기 </h3>
						<hr>
						<input type="text" class="form-control" placeholder="글제목" name="postTitle" maxlength="50">
        				<br>
						<textarea class="form-control" placeholder="내용을 입력하세요." rows="15" name="postContent" maxlength="2000"></textarea>
						<br>
						<!-- 파일 첨부 -->
						<input type="file" class="form-control" name="uploadfile">
						<hr>
					</div>
					<div class="text-end">
					<input type="submit" class="btn btn-primary" value="글쓰기">
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