<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="user.UserDAO" %> 
<%@ page import="java.io.PrintWriter" %>  
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />   <!-- 자바빈즈 사용, 현재 페이지안에서만 빈즈사용-->
<jsp:setProperty name="user" property="userID"/>		<!-- 로그인페이지에서 넘겨준 유저아이디를 받아서 유저아이디 값을 넣어줌 -->
<jsp:setProperty name="user" property="userPassword"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>StudyBuddy</title>
</head>
<body>
	<%
	
		//이미 로그인한 사람은 또다시 로그인 할 수 없도록
		String userID = null;
		String userName = null;
		
		if(session.getAttribute("userID")!= null){      //세션을 확인해서 userID의 세션이 존재하는 회원들은 userID에  세션값을 담을수 있도록
			userID=(String) session.getAttribute("userID");
			userName=(String) session.getAttribute("userName");
		}
		if(userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp;'");
			script.println("</script>");
		}
	
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword()) ;   //로그인 함수에 넣어서 실행
		
		if(result == 1) {   //로그인 성공
			
			session.setAttribute("userID", user.getUserID());   //세션을 부여, 해당회원의 아이디를 세션값으로 넣어줌 - 7강
			session.setAttribute("userName", userDAO.searchName(user.getUserID()));
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		else if(result == 0) {   //비밀번호 오류
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back();");
			script.println("</script>");
		}
		else if(result == -1) {   //아이디 존재x
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('아이디가 존재하지않습니다.')");
			script.println("history.back();");
			script.println("</script>");
		}
		else if(result == -2) {   //db오류
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('db오류가 발생했습니다.')");
			script.println("history.back();");
			script.println("</script>");
		}
	%>

</body>
</html>