<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>  
<%@ page import="java.io.PrintWriter" %>  
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>StudyBuddy</title>
</head>
<body>
	<%
		
		String userID = null;
		
		if(session.getAttribute("userID")!= null){      //세션을 확인해서 userid의 세션이 존재하는 회원들은 userID에  세션값을 담을수 있도록
			userID=(String) session.getAttribute("userID");
		}
		
		if(userID == null) {  //로그인 되어있지 않다면
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp;'");
			script.println("</script>");
		}
		
		
		String userPass = null;
		String userName = null;
		String userEmail = null;
		
		if (request.getParameter("userPass") == null || request.getParameter("userName") == null
				|| request.getParameter("userEmail") == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력되지 않은 사항이 있습니다.')");
			script.println("history.back();");  //이전 페이지로 돌아감
			script.println("</script>");
		}
		else{

			userPass = request.getParameter("userPass");
			userName = request.getParameter("userName");
			userEmail = request.getParameter("userEmail");   
			/* <form method="post" action="UserUpdateAction.jsp">에서 받아옴 */
					
			UserDAO userDAO = new UserDAO();
			
			int result = userDAO.update(userID,userPass,userName,userEmail);   //update 함수 실행
			
			if(result == -1) {   //db오류
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원 정보 수정에 실패했습니다.')");
				script.println("history.back();");
				script.println("</script>");
			}
			else {   //회원정보 수정 성공
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'mypage.jsp'");  //마이페이지로 이동
				script.println("</script>");
			}
		
		
			
		}
	

	%>

</body>
</html>
</html>