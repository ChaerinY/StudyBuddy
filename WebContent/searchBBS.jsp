<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.PostDAO" %>  
<%@ page import="post.Post" %>
<%@ page import="room.RoomDAO" %>
<%@ page import="room.Room" %>
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
		
		int roomID = -1;
		String postType = null;
		
		// 룸 메인페이지 연결
		if (request.getParameter("roomID") != null && request.getParameter("postType") != null){
			roomID = Integer.parseInt(request.getParameter("roomID"));
			postType = request.getParameter("postType");
		}
		
		EnrolDAO enrolDAO = new EnrolDAO();
		int auth = enrolDAO.getAuth(roomID, userID); // 방장이나 회원만 열람 가능
		
		if(roomID == -1 || postType == null || auth == -1){  
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('잘못된 접근입니다.')");
			script.println("location.href = 'main.jsp;'");  
			script.println("</script>");
		}
		
		String searchOption = null;
		String searchBBS = null;
		
		if ( request.getParameter("searchOption") != null && request.getParameter("searchBBS") != null ) {
			searchOption = request.getParameter("searchOption");
			searchBBS = request.getParameter("searchBBS");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력되지 않은 사항이 있습니다.')");
			script.println("history.back();");  //이전 페이지로 돌아감
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

            <div class="mt-auto">
            <hr>
			<form method="post" action="searchBBS.jsp?roomID=<%=roomID%>&postType=<%=postType%>">
                	<div style="margin-bottom: 15px;" class="d-flex justify-content-between">
                		<span class="fs-5">게시글 검색 </span>
                		<span></span>
                    	<select name="searchOption">
									<option value="postTitle" selected>제목</option>
									<option value="postContent">내용</option>
									<option value="userName">작성자</option>
						</select>
                	</div>
                  	<div class="input-group mb-3"> 
								<input type="text" name="searchBBS" placeholder="검색어를 입력하세요." style="width:wrap-content;" maxlength="30" class="form-control">
	                    		<button type="submit" class="btn btn-primary">검색</button>
                	</div>
               </form>
						</div>
        </div>

        <div class="container ms-3 mt-5" id="main">

            <h2><%=postType%></h2>
            <hr>

            <!-- 이부분에 게시판 표시 -->
            	<div class="container">
					<div class="row">
						<table class="table" style="text-align:center; border: 1px solid #dddddd">
								<thead>
			                        <tr>
			                            <th style="width: 10%; background-color: #eeeeee; text-align: center;">번호</th>
			                            <th style="width: 50%; background-color: #eeeeee; text-align: center;">제목</th>
			                            <th style="width: 10%; background-color: #eeeeee; text-align: center;">작성자</th>
			                            <th style="width: 30%; background-color: #eeeeee; text-align: center;">작성일</th>
			                        </tr>
			                    </thead>
			                    <tbody id="post-list">
			                        <!-- 게시글이 들어갈 부분 -->
			                        
			                    <% 
		                        PostDAO postDAO = new PostDAO();		                        	
		                        ArrayList<Post> list = postDAO.getSearchList(roomID, postType, searchOption, searchBBS);
   	
		                        if(list.size()==0){
		                        	PrintWriter script = response.getWriter();
		                			script.println("<script>");
		                			script.println("alert('일치하는 내용이 존재하지 않습니다.')");
		                			script.println("history.back();");
		                			script.println("</script>");
		                        }
		                        
		                        for (int i = 0; i < list.size(); i++){
		                        %>		
		                        <tr>
		                        	<td><%= list.get(i).getPostIndex()%></td>
		                        	<td><a href="study_View.jsp?postIndex=<%=list.get(i).getPostIndex()%>&roomID=<%= list.get(i).getRoomID()%>&postType=<%= list.get(i).getPostType()%>"><%=list.get(i).getPostTitle() %></a></td>
		                        	<td><%= list.get(i).getUserName()%></td>
		                        	<td><%= list.get(i).getPostDate()%></td>
		                        </tr>
		                        <%			
		                        	}
		                        %>
			
			                    </tbody>			
						</table>
						
						<%
						if(postType.equals("공지사항") || postType.equals("과제게시판")){		// 해당 게시판에서는 hostID만 게시글 작성 가능
							if(userID != null && userID.equals(room.getHostID())){
						%>
						<div class="text-end" style="padding-top:10px">
							<a href="write.jsp?roomID=<%=roomID%>&postType=<%=postType%>" class="btn btn-primary" role="button">글쓰기</a>
						</div>
						<%}}else{%>
							<div class="text-end" style="padding-top:10px">
							<a href="write.jsp?roomID=<%=roomID%>&postType=<%=postType%>" class="btn btn-primary" role="button">글쓰기</a>
							</div>
						<%} %>
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