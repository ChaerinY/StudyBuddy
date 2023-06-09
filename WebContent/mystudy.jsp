<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="room.RoomDAO"%>
<%@ page import="room.Room"%>
<%@ page import="enrol.EnrolDAO"%>
<%@ page import="enrol.Enrol"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.lang.Integer" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>StudyBuddy - 나의스터디</title>
<!-- 부트스트랩 CSS 링크 추가 -->
<!-- CSS only -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">

<!-- 구글 폰트 사용 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap"
	rel="stylesheet">

<style>
* {
	font-family: 'Nanum Gothic', sans-serif;
}

/*페이지 전체에 나눔고딕 폰트 사용*/
#post-list a, a:hover {
	/* post-list의 자식 a태그는 색상 변경과 밑줄 제거 */
	color: #000000;
	text-decoration: none;
}
</style>

</head>

<body>
	<%
							String userID=null; 
                        	String userName=null; 
                        	if(session.getAttribute("userID")!=null){ //세션이 있으면 userID값을 가지고 없다면 null값 
                        		userID=(String)session.getAttribute("userID"); 
                        	userName=(String)session.getAttribute("userName"); } %>

	<header class="p-3 text-bg-dark">
		<div class="container">
			<div
				class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
				<img src="img/wig_whtie.png" width="30px"
					style="padding-right: 7px;"> <a href="main.jsp"
					class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none"
					style="padding-right: 30px;"> StudyBuddy </a>

				<ul
					class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
					<li><a href="main.jsp" class="nav-link px-2 text-white">홈</a></li>
					<li><a href="recruitBBS.jsp" class="nav-link px-2 text-white">모집게시판</a></li>
					<li><a href="mystudy.jsp" class="nav-link px-2 text-white">나의스터디</a></li>
				</ul>

				<% if(userID==null) { //로그인이 되어있지 않다면 로그인과 회원가입 버튼을 표시, a태그 밑줄 없애고 색상변경 %>
				<div class="text-end">
					<button type="button" class="btn btn-secondary me-2">
						<a href="login.jsp" style="color: #ffffff; text-decoration: none;">로그인</a>
					</button>
					<button type="button" class="btn btn-primary">
						<a href="join.jsp" style="color: #ffffff; text-decoration: none;">회원가입</a>
					</button>
				</div>

				<% } else { //로그인이 되어있다면 로그아웃과 마이페이지 버튼을 표시 %>
				<div class="text-end">
					<button type="button" class="btn btn-secondary me-2">
						<a href="logoutAction.jsp"
							style="color: #ffffff; text-decoration: none;">로그아웃</a>
					</button>
					<button type="button" class="btn btn-primary">
						<a href="mypage.jsp" style="color: #ffffff; text-decoration: none;">마이페이지</a>
					</button>
				</div>

				<% } %>
			</div>
		</div>
	</header>

	<div class="d-flex">
		<!-- 사이드바 -->
        <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px; height: calc(100vh - 75px);">
            <div style="margin-left: 20px;">
                <span class="fs-4">나의 스터디</span>
            </div>
            <hr>
            <a href="createroom.jsp" class="btn btn-primary" role="button">스터디 생성하기</a>
            <div class="mt-auto">
                <hr>
                <div class="text-center" style="margin-bottom: 15px;">
                    <span class="fs-4">스터디룸ID로 찾기</span>
                </div>
                <form method="post" action="studySearch.jsp">
                  <div class="input-group mb-3">
               
	                    <input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
	                    	class="form-control" placeholder="ID검색" id="searchid" name="searchid" >
	                    
	                    <button type="submit" class="btn btn-primary">
	                        검색
	                    </button>
              
                </div>
               </form>
            </div>
        </div>
       
          
          
		<div class="container ms-3 mt-5" id="main">

			<h2>나의 스터디</h2>
			<hr>

			<!-- 이부분에 스터디 리스트 표시 -->

			<div class="container">
				<div class="row">
					<table class="table"
						style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th style="background-color: #eeeeee; text-align: center;">ID
								</th>
								<th style="background-color: #eeeeee; text-align: center;">스터디룸
								</th>
								<th style="background-color: #eeeeee; text-align: center;">소개
								</th>
							</tr>
						</thead>
						<tbody id="room-list">
							<% RoomDAO roomDAO=new RoomDAO(); 
							ArrayList<Room> list =roomDAO.getMyList(userID);
                                  for (int i = 0; i < list.size(); i++){ %>
							<tr>
								<td><%= list.get(i).getRoomID()%></td>
								<td><a href="roomMain.jsp?roomID=<%= list.get(i).getRoomID()%>"><%= list.get(i).getRoomName()%></a></td>      <!-- href수정. roomMain.jsp?roomID= -->
								<td><%= list.get(i).getRoomContent()%></td>
							</tr>
							<% } %>

						</tbody>
					</table>

				</div>

			</div>

		</div>
	
	</div>

	<!-- 부트스트랩 JS 및 jQuery 추가 -->
	<script type="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>

</html>