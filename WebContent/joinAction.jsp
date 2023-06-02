<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="user.UserDAO" %>  
<%@ page import="java.io.PrintWriter" %>  
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />   <!-- 자바빈즈 사용, 현재 페이지안에서만 빈즈사용-->
<jsp:setProperty name="user" property="userID"/>		<!-- 로그인페이지에서 넘겨준 값들을 삽입 -->
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userEmail"/>     <!-- 모든 값들을 전달받음 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>StudyBuddy</title>
</head>
<body>
	<%
	
		//이미 로그인한 사람은 회원가입할수없도록
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
		
		
		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserEmail() == null ) {       //하나라도 빠트린 입력값이 있다면
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력되지 않은 사항이 있습니다.')");
			script.println("history.back();");  //이전 페이지로 돌아감
			script.println("</script>");
		}
		else {

			UserDAO userDAO = new UserDAO();    //db에 접근 가능한 객체를 하나 만들어서
			int result = userDAO.join(user) ;   //join함수를 실행하여 userlist에 레코드 추가
				

			if(result == -1) {   //db오류, 해당 아이디가 존재하는 경우
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디 입니다.')");
				script.println("history.back();");
				script.println("</script>");
			}
			else {   //가입 성공시 메인페이지 이동
				
				session.setAttribute("userID", user.getUserID());   //세션을 부여, userID를 세션값으로 넣어줌으로써 로그인 유지
				session.setAttribute("userName", userDAO.searchName(user.getUserID()));
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
			
		}
	

	%>

</body>
</html>