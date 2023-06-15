<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.PrintWriter" %>  
<%@ page import="room.RoomDAO" %>
<%@ page import="room.Room" %>
<%@ page import="enrol.EnrolDAO" %>
<%@ page import="java.util.ArrayList" %>
<% request.setCharacterEncoding("UTF-8"); %>    
<!DOCTYPE html>
<html lang="en">
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
		
		int roomID = -1; // -1은 존재하지 않음
		
		if (request.getParameter("roomID") != null)
			roomID = Integer.parseInt(request.getParameter("roomID"));
		
		EnrolDAO enrolDAO = new EnrolDAO();
		int auth = enrolDAO.getAuth(roomID, userID);
		
		if(roomID == -1 || auth == -1){  
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('잘못된 접근입니다.')");
			script.println("location.href = 'main.jsp;'");  
			script.println("</script>");
		}
		
		Room room = new RoomDAO().getRoom(roomID);
		
	%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StudyBuddy - <%=room.getRoomName()%></title>
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
	#post-list a, a:hover {        /* post-list의 자식 a태그는 색상 변경과 밑줄 제거 */
		color:#000000;
		text-decoration: none;
	}
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
        <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px; height: calc(100vh - 75px);">
            <a href="roomMain.jsp?roomID=<%=room.getRoomID()%>" class="d-flex align-items-center link-dark text-decoration-none" style="margin: 10px;">
                <span class="fs-4" style="font-weight: bold;"><%=room.getRoomName()%></span>
            </a>
            <hr>
           <ul class="nav nav-pills flex-column mb-auto">
            	<li class="nav-item"><a href="studyBBS.jsp?roomID=<%=roomID%>&postType=공지사항" class="nav-link link-dark" aria-current="page">· 공지사항 </a></li>
            	<li><a href="studyBBS.jsp?roomID=<%=roomID%>&postType=과제게시판" class="nav-link link-dark">· 과제게시판 </a></li>
            	<li><a href="studyBBS.jsp?roomID=<%=roomID%>&postType=QnA게시판" class="nav-link link-dark">· Q&A게시판 </a></li>
            	<li><a href="studyBBS.jsp?roomID=<%=roomID%>&postType=자유게시판" class="nav-link link-dark">· 자유게시판 </a></li>
            </ul>
        </div>

        <div class="container ms-3 mt-5" id="main">
        	<section>
        		<div class="d-flex justify-content-between align-items-end">
        			<img src="upload/<%=room.getFileName()%>" style="width: 300px; height: 300px;"/>	<!--  등록한 이미지 불러오도록 -->
        			<span style="text-align: right;">룸ID: <%=room.getRoomID()%></span>
        		</div>
        	</section>

            <div class="bg-light p-5 rounded mt-3">
            		<h2 style="text-align: left;"> <%=room.getRoomName()%> </h2>
            		<p class="lead"><%=room.getRoomContent()%></p>
            </div>
					
			<% if(auth == 0){%>
			<div class="d-flex justify-content-end">
					<a onclick="return confirm('정말로 탈퇴하시겠습니까?')" href="withdrawalAction.jsp?roomID=<%=roomID%>" class="btn btn-secondary" role="button">탈퇴하기</a>
					<!-- 탈퇴 Action하는 곳으로 -->
			</div>
			<%}else{ %>
			<div class="d-flex justify-content-end">
					<a onclick="return confirm('정말로 삭제하시겠습니까?\n삭제된 스터디룸은 복구되지 않습니다.')"
					href="withdrawalAction.jsp?roomID=<%=roomID%>" class="btn btn-secondary" role="button">삭제하기</a>
					<!-- 삭제 Action하는 곳으로 -->
			</div>
			<%} %>
					
		</div>

       </div>


    <!-- 부트스트랩 JS 및 jQuery 추가 -->
    <script type="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>

</html>