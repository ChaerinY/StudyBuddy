<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="post.Post" %>
<%@ page import="post.PostDAO" %>  
<%@ page import="java.io.PrintWriter" %>  
<%@ page import="java.io.File" %>
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
		
		//파일 설정
		String relativePath = "/upload/";       //상대경로
		String saveDirectory = request.getServletContext().getRealPath(relativePath);      //getServletContext() -> 루트디렉토리 가져옴
		
		// 디렉토리가 존재하는지 확인하고, 없으면 생성
		File uploadDir = new File(saveDirectory);
		if (!uploadDir.exists()) {
		    uploadDir.mkdir();
		}
				
		int maxPostSize = 10 * 1024 * 1024; // 최대 업로드 파일 크기(10MB로 설정)
		String encoding = "UTF-8"; // 인코딩 타입
				 
		//form으로부터 값 받아옴
		MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, new DefaultFileRenamePolicy());
		Integer getRoomID = Integer.parseInt(multipartRequest.getParameter("roomID"));
		Integer getPostIndex = Integer.parseInt(multipartRequest.getParameter("postIndex"));
		String getPostType = multipartRequest.getParameter("postType");
		String postTitle = multipartRequest.getParameter("postTitle");
		String postContent = multipartRequest.getParameter("postContent");
		String fileName = multipartRequest.getParameter("prefile");
				
		//수정할 파일이 있을 경우에만 변경
		if(multipartRequest.getFilesystemName("uploadfile")!=null){
			fileName = multipartRequest.getFilesystemName("uploadfile");
		}

		
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
		
		if (getRoomID != null && getPostType != null
				&& getPostIndex != null){
			roomID = getRoomID;
			postType = getPostType;
			postIndex = getPostIndex;  
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

			if (postTitle == null || postContent == null ) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 사항이 있습니다.')");
				script.println("history.back();");  //이전 페이지로 돌아감
				script.println("</script>");
			}
			else {

				PostDAO postDAO = new PostDAO();    //db에 접근 가능한 객체를 하나 만들어서
				
				//int update(int roomID, String postType, int postIndex, String postTitle, String postContent) 
				
				int result = postDAO.update(roomID, postType, postIndex, postTitle, postContent, fileName);   //update 함수 실행
					
				if(result == -1) {   //db오류
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.')");
					script.println("history.back();");
					script.println("</script>");
				}
				else {   //글수정 성공
					if (roomID==0){   //모집게시판이면
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