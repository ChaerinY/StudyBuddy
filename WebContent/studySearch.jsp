<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="room.RoomDAO"%>
<%@ page import="room.Room"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>StudyBuddy</title>
  <!-- 부트스트랩 CSS 링크 추가 -->
  <!-- CSS only -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

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
							String userID=null; 
                        	String userName=null; 
                        	if(session.getAttribute("userID")!=null){ //세션이 있으면 userID값을 가지고 없다면 null값 
                        		userID=(String)session.getAttribute("userID"); 
                        	userName=(String)session.getAttribute("userName"); } %>

    <header class="p-3 text-bg-dark">
        <div class="container">
          <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
            <img src="img/wig_whtie.png" width="30px" style="padding-right: 7px;">
            <a href="main.jsp" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none"
                style="padding-right: 30px;">
                StudyBuddy
            </a>
            </div>
         </div>
      </header>


  <main class="container mt-5">
      <% 
        Integer searchid = 0;
        if (request.getParameter("searchid")!=null){
        	searchid=Integer.parseInt(request.getParameter("searchid"));
        }
        
        RoomDAO searchroomDAO=new RoomDAO(); 
		Room rs =searchroomDAO.getRoom(searchid);     //searchRoom에서 getRoom으로 변경. ArrayList<Room>대신 Room 객체 하나만 가져옵니다
    	%>
    	
    	
        <div class="card" style="width: 800px;">
        	<div class="card-header">
            	<h5 class="card-title" id="exampleModalLabel">스터디룸ID로 찾기</h5>
        	</div>
                <div class="card-body">
                  <h6>스터디룸ID: <%=searchid %></h6>
                  <div class="d-flex">
                  	<% if(rs!=null && searchid!=0 ){ %>               <!-- search room에서 getroom으로 바뀜에 따라 수정, 0은 모집게시판이므로 검색에서 제외 -->
                    <img src="upload/<%= rs.getFileName()%>" alt="Image" style="width: 200px; height: 200px; margin-right: 20px;"/>
                    <div>
                        <h5 id="study_name" style="margin-top: 10px;"><%= rs.getRoomName()%></h5>
                        <div id="study_content"><%= rs.getRoomContent()%>
                        </div>
                    </div>
                    <%}else{%>
                    	
                    	 <div>
                    	  해당 ID의 스터디룸이 존재하지 않습니다.<br>
                    	  검색 아이디를 다시 확인해주세요
                        </div>
                    	
                   <%} %>
                    
                  </div>
                </div>
                <div class="card-footer bg-transparent d-flex justify-content-end align-items-center">
                <% if(rs!=null){ %>               <!-- search room에서 getroom으로 바뀜에 따라 수정 -->
                    <p style="color: rgb(27, 67, 197); margin-right: 10px;">가입하시겠습니까?</p>
                  <button type="button" class="btn btn-secondary" onclick="goBack()">뒤로가기</button>
                   
                   <form method="post" action="enrolAction.jsp?roomid=<%=searchid%>">
	                  <button type="submit" class="btn btn-primary">
	                  	가입하기</a>
	                  </button>
	               </form>
                  <%}else{ %>
                  	<button type="button" class="btn btn-secondary" onclick="goBack()">뒤로가기</button>
                  	<%}%>
                </div>
              </div>


  <script>
    function goBack() {
      window.history.back();
    }
  </script>

  <!-- 부트스트랩 JS 및 jQuery 추가 -->
    <script type="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>