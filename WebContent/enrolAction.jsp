<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>      
<%@ page import="enrol.EnrolDAO" %>  
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
		
		 Integer roomID = 0;
	        if (request.getParameter("roomid")!=null){
	        	roomID=Integer.parseInt(request.getParameter("roomid"));
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
		
		else{
			
			EnrolDAO enrolDAO = new EnrolDAO();
			RoomDAO roomDAO = new RoomDAO();
			
			int cur_num = enrolDAO.memberNum(roomID);
			int max_num = roomDAO.maxMemberNum(roomID);
			
			if (cur_num >= max_num){   //현재 인원이 max_num을 넘기면 더이상 가입 못함
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('최대 인원수를 초과했습니다.')");
				script.println("location.href = 'mystudy.jsp;'");
				script.println("</script>");
			}
			
			else{
				
				Integer auth=0; //룸아이디 검색으로 가입하는 경우 방장x
				
				int result = enrolDAO.enrol(roomID, userID,auth) ;
				if(result == -1) {   //db오류, 중복 가입
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 가입한 스터디룸입니다.')");
					script.println("location.href = 'mystudy.jsp'");
					script.println("</script>");
				}
				else {   //가입 성공시 마이스터디 페이지로 이동
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'mystudy.jsp'");
					script.println("</script>");
				}
			}
		}
	%>

</body>
</html>