<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="post.PostDAO" %>  
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="post" class="post.Post" scope="page" />   <!-- 자바빈즈 사용, 현재 페이지안에서만 빈즈사용-->
<jsp:setProperty name="post" property="postTitle"/>		<!-- 로그인페이지에서 넘겨준 유저아이디를 받아서 한명의 사용자에 유저아이디를 넣어줌 -->
<jsp:setProperty name="post" property="postContent"/>
<jsp:setProperty name="post" property="roomID"/>
<jsp:setProperty name="post" property="postType"/>
<jsp:setProperty name="post" property="fileName"/> 

<%@ page import="user.UserDAO" %> 
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
		Integer roomID = Integer.parseInt(multipartRequest.getParameter("roomID"));
		String postType = multipartRequest.getParameter("postType");
		String postTitle = multipartRequest.getParameter("postTitle");
		String postContent = multipartRequest.getParameter("postContent");
		String fileName = multipartRequest.getFilesystemName("uploadfile");

		if(session.getAttribute("userID")!= null){      //세션을 확인해서 userid의 세션이 존재하는 회원들은 userID에  세션값을 담을수 있도록
			userID=(String) session.getAttribute("userID");
			UserDAO userDAO = new UserDAO();
			userName=userDAO.searchName(userID);        //0613 마이페이지에서 회원정보 수정후에도 로그인 시의 userName으로 글이 작성되는 문제가 있어 수정
		}
		
		if(userID == null) {  //로그인 되어있지 않다면
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp;'");
			script.println("</script>");
		}
		else {  //로그인이 되어있다면

			if (postTitle == null || postContent == null ) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 사항이 있습니다.')");
				script.println("history.back();");  //이전 페이지로 돌아감
				script.println("</script>");
			}
			else {

				PostDAO postDAO = new PostDAO();    //db에 접근 가능한 객체를 하나 만들어서
				//write(int roomID, String postType, String postTitle, String userID, String postContent, String userName)
				
				int result = postDAO.write(roomID, postType, postTitle, userID, postContent, userName, fileName);   //write함수 실행
					
				if(result == -1) {   //db오류
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back();");
					script.println("</script>");
				}
				else {   //글쓰기 성공
					if (roomID==0){   //모집게시판이면
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'recruitBBS.jsp'");  //모집게시판으로 이동
						script.println("</script>");
					}
					else {     //그외 스터디룸 게시판이면
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'studyBBS.jsp?roomID="+roomID+"&postType="+postType+"'");   //스터디룸으로 이동
						script.println("</script>");
					}

				}
			
			
			}
		
			
		}
	

	%>

</body>
</html>