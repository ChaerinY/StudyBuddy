<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스터디그룹 커뮤니티</title>
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
	<%   //로그인시에만 마이페이지에 접근할 수 있도록
	
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
		
		// 로그인한 유저의 정보들을 가져온다
		UserDAO searchDAO = new UserDAO();
		User nowUser = searchDAO.getUser(userID);
		
		String userPass = nowUser.getUserPassword();
		
		String userName = nowUser.getUserName();
		String userEmail = nowUser.getUserEmail();
		
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
            <div style="margin: 20px;">
                <span class="fs-4">마이페이지</span>
            </div>
        </div>

        <div class="container ms-3 mt-5">

            <h2>마이페이지</h2>
            <hr>

            <div class="user-info" style="margin: 10px;">
            <form method="post" action="UserUpdateAction.jsp">
                <p>아이디</p>
                <p id="user-id"><%=userID%></p>       <!-- 아이디는 변경불가 -->
                <br>
            
                <p>비밀번호</p>
                <input type="password" class="form-control" placeholder="비밀번호를 입력하세요." style="width: 400px;" value="<%=userPass%>" name="userPass">
                <br>
      
                <p>닉네임</p>
                <input type="text" class="form-control" placeholder="닉네임을 입력하세요." style="width: 400px;" value="<%=userName%>" name="userName">
                <br>
      
                <p>이메일</p>
                <input type="email" class="form-control" placeholder="이메일을 입력하세요." style="width: 400px;"  value="<%=userEmail%>" name="userEmail">
                <br><br>
      
                <div class="text-end">
                <input type="submit" class="btn btn-primary" value="수정완료">
                </div>
              </form>
            </div>
        </div>
    </div>


    <!-- 부트스트랩 JS 및 jQuery 추가 -->
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>

</html>