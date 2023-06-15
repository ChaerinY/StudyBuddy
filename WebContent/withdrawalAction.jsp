<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="enrol.EnrolDAO" %> 
<%@ page import="room.RoomDAO" %> 
<%@ page import="room.RoomDAO" %>  
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
	String userName = null;
		
	Integer roomID = -1;
        if (request.getParameter("roomID")!=null){
        	roomID=Integer.parseInt(request.getParameter("roomID"));
        }
	
	if(session.getAttribute("userID")!= null){      //세션을 확인해서 userID의 세션이 존재하는 회원들은 userID에  세션값을 담을수 있도록
		userID=(String) session.getAttribute("userID");
		userName=(String) session.getAttribute("userName");
	}		
	
	if(userID == null) {  //로그인 되어있지 않다면
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp;'");
		script.println("</script>");
	}
	else{	//로그인 되어있을 경우
		EnrolDAO enrolDAO = new EnrolDAO();
		int auth = enrolDAO.getAuth(roomID, userID);
	
		if(auth == 0){	// 스터디룸 회원일 경우 - 탈퇴
			int result = enrolDAO.withdrawal(roomID, userID, auth);
			
			if(result == -1){	// db오류
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('db오류가 발생했습니다.')");
				script.println("location.href = 'roomMain.jsp?roomID="+roomID+"'");
				script.println("</script>");
			}else{	// 탈퇴
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('탈퇴하셨습니다.')");
				script.println("location.href = 'mystudy.jsp'");
				script.println("</script>");
			}
		}else if(auth == 1){	// 스터디룸 방장인 경우 - 스터디룸 삭제
			RoomDAO roomDAO = new RoomDAO();
			int result = roomDAO.delete(roomID);
			
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('db오류가 발생했습니다.')");
				script.println("location.href = 'roomMain.jsp?roomID="+roomID+"'");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('삭제되었습니다.')");
				script.println("location.href = 'mystudy.jsp'");
				script.println("</script>");
			}
		}else{	// db오류
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('db오류가 발생했습니다.')");
			script.println("location.href = 'roomMain.jsp?roomID="+roomID+"'");
			script.println("</script>");
		}
	}
	%>

</body>
</html>