<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>  
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	String nowUserID = null;
	String userName = null;
	
	if(session.getAttribute("userID")!= null){      //세션이 있으면 userID값을 가지고 없다면 null값
		nowUserID=(String) session.getAttribute("userID");   //현재 로그인한 유저아이디
		userName=(String) session.getAttribute("userName");
	}
	
	String userID = request.getParameter("userID");     //탈퇴하려는 유저아이디
	
	if(!userID.equals(nowUserID)){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
	
	else {  //회원탈퇴 처리
		UserDAO userDAO = new UserDAO();
		
		int result = userDAO.delete(userID);   //탈퇴 함수 실행
		
		if(result == -1) {   //db오류
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('탈퇴에 실패했습니다.')");
			script.println("history.back();");
			script.println("</script>");
		}
		else {   //회원정보 수정 성공
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('탈퇴하였습니다.')");
			script.println("location.href = 'logoutAction.jsp'");  //로그아웃처리
			script.println("</script>");
		}
		
	}
	
	
%>
</body>
</html>