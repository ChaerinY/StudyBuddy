<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.io.PrintWriter" %>  
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="comment" class="comment.Comment" scope="page" />
<jsp:setProperty name="comment" property="commentContent"/>	
<jsp:setProperty name="comment" property="userID"/>
<jsp:setProperty name="comment" property="postID"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>StudyBuddy</title>
</head>
<body>
	<%
		String userID = null;
		
		if(session.getAttribute("userID")!= null){      //세션을 확인해서 userID의 세션이 존재하는 회원들은 userID에  세션값을 담을수 있도록
			userID=(String) session.getAttribute("userID");
		}		
		
		if(userID == null) {  //로그인 되어있지 않다면
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp;'");
			script.println("</script>");
		}
		
		int commentID = 0;
		int postIndex = 0;
		int roomID = -1;
		String postType = null;
		
		if(request.getParameter("commentID")!= null && request.getParameter("postIndex")!= null &&
				request.getParameter("roomID")!= null && request.getParameter("postType")!= null){
			commentID = Integer.parseInt(request.getParameter("commentID"));
			postIndex = Integer.parseInt(request.getParameter("postIndex"));
			roomID = Integer.parseInt(request.getParameter("roomID"));
			postType = request.getParameter("postType");
		}
		
		if(commentID == 0){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글입니다.')");
			script.println("location.href='study_View.jsp?postIndex="+postIndex+"&roomID="+roomID+"&postType="+postType+"'");
			script.println("</script>");
		}
		
		if(!userID.equals(comment.getUserID())){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			if(comment.getCommentContent()==null){
					PrintWriter script=response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else{
					CommentDAO commentDAO=new CommentDAO();
					int result=commentDAO.update(commentID, comment.getCommentContent());
					if(result == -1){//db 오류
						PrintWriter script=response.getWriter();
						script.println("<script>");
						script.println("alert('댓글 수정에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					else{
						PrintWriter script=response.getWriter();
						script.println("<script>");
						script.println("location.href='study_View.jsp?postIndex="+postIndex+"&roomID="+roomID+"&postType="+postType+"'");
						script.println("</script>");
					}
		}
		}
	%>

</body>
</html>