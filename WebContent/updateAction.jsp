<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="post.Post" %>
<%@ page import="post.PostDAO" %>  
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
		
		if(session.getAttribute("userID")!= null){      //세션을 확인해서 userid의 세션이 존재하는 회원들은 userID에  세션값을 담을수 있도록
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
		
		
		int roomID = -1;
		String postType = null;
		int postIndex=0;
		
		if (request.getParameter("roomID") != null && request.getParameter("postType") != null
				&& request.getParameter("postIndex") != null){
			roomID = Integer.parseInt(request.getParameter("roomID"));
			postType = request.getParameter("postType");
			postIndex = Integer.parseInt(request.getParameter("postIndex"));   
		}
		
		
		if (postIndex==0){
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");			
			
		}
		
		Post post = new PostDAO().getPost(roomID, postType, postIndex);   //수정할 포스트 객체 가져옴
		
		if(!userID.equals(post.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		
		else {  //권한이 있다면 수정

			if (request.getParameter("postTitle") == null || request.getParameter("postContent") == null ) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 사항이 있습니다.')");
				script.println("history.back();");  //이전 페이지로 돌아감
				script.println("</script>");
			}
			else {

				PostDAO postDAO = new PostDAO();    //db에 접근 가능한 객체를 하나 만들어서
				
				//int update(int roomID, String postType, int postIndex, String postTitle, String postContent) 
				
				int result = postDAO.update(roomID, postType, postIndex, request.getParameter("postTitle"), request.getParameter("postContent"));   //update 함수 실행
					
				if(result == -1) {   //db오류
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.')");
					script.println("history.back();");
					script.println("</script>");
				}
				else {   //글수정 성공
					if (post.getRoomID()==0){   //모집게시판이면
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'recruitBBS.jsp'");  //모집게시판으로 이동
						script.println("</script>");
					}
					else {     //그외 스터디룸 게시판이면
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'studyBBS.jsp?roomID="+post.getRoomID()+"&postType="+post.getPostType()+"'");   //스터디룸으로 이동
						script.println("</script>");
					}

				}
			
			
			}
		
			
		}
	

	%>

</body>
</html>