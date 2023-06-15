<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="comment" class="comment.Comment" scope="page"/>
<jsp:setProperty name="comment" property="postID"/>
<jsp:setProperty name="comment" property="userName"/>
<jsp:setProperty name="comment" property="commentContent" />

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
	
	int postID = 0;
	if(comment.getPostID()!= 0){
		postID = comment.getPostID();
	}
		
		
	if(postID == 0){
		 PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('유효하지 않은 글입니다.')");
         script.println("history.back()");
         script.println("</script>");
	}
	
	if(comment.getCommentContent() == null){
		 PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('입력되지 않은 사항이 있습니다.')");
         script.println("history.back()");
         script.println("</script>");
	}else{
		
		CommentDAO commentDAO = new CommentDAO();
        int result = commentDAO.write(postID, userID, comment.getUserName(), comment.getCommentContent());
        
        if (result == -1){
           PrintWriter script = response.getWriter();
           script.println("<script>");
           script.println("alert('댓글 쓰기에 실패했습니다.')");
           script.println("history.back()");
           script.println("</script>");
        }
        else{
           PrintWriter script = response.getWriter();
           script.println("<script>");
           script.println("location.href=document.referrer");	// 게시글
           script.println("</script>");
        }
    }
	
	%>
</body>
</html>