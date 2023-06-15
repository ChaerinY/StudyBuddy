<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Random" %>
<%@ page import="room.RoomDAO" %>  
<%@ page import="enrol.EnrolDAO" %>  
<%@ page import="java.io.PrintWriter" %>  
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="room" class="room.Room" scope="page" />
<jsp:setProperty name="room" property="roomID"/>
<jsp:setProperty name="room" property="hostID"/>
<jsp:setProperty name="room" property="roomName"/>		<!-- 로그인페이지에서 넘겨준 값들을 삽입 -->
<jsp:setProperty name="room" property="roomContent"/>
<jsp:setProperty name="room" property="maximum"/>     <!-- 모든 값들을 전달받음 -->
<jsp:setProperty name="room" property="fileName"/>     <!-- 모든 값들을 전달받음 -->

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
	 String saveDirectory = "C:/jsp-work/StudyBuddy/WebContent/upload/";	//업로드한 이미지가 저장될 디렉토리
	 int maxPostSize = 10 * 1024 * 1024; // 최대 업로드 파일 크기(10MB로 설정)
	 String encoding = "UTF-8"; // 인코딩 타입
	 
	//form으로부터 값 받아옴
	MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, new DefaultFileRenamePolicy());
	String roomName = multipartRequest.getParameter("roomName");
	String roomContent = multipartRequest.getParameter("roomContent");
	Integer Maximum =  Integer.parseInt(multipartRequest.getParameter("maximum"));
	String fileName = multipartRequest.getFilesystemName("imgfile");

	
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
	else {  //로그인이 되어있다면
		if (roomName == null || roomContent == null || Maximum <= 0 ) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력되지 않은 사항이 있습니다.')");
			script.println("history.back();");  //이전 페이지로 돌아감
			script.println("</script>");
		}
		else {

			RoomDAO roomDAO = new RoomDAO();
			Random random = new Random();
			

			int roomID;
			do {
			    roomID = random.nextInt(100000);       //랜덤으로 roomID생성
			} while(roomDAO.checkExists(roomID));      //roomID 존재여부 체크후 존재한다면 다시 랜덤으로 돌림
			
			
			String hostID = null;
			
			if(session.getAttribute("userID")!= null){
				hostID=(String) session.getAttribute("userID");
			}

			int result = roomDAO.create(roomID, hostID, roomName, roomContent, Maximum, fileName) ;
			
			if(result == -1) {   //db오류
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('스터디룸 생성에 실패했습니다.')");
				script.println("history.back();");
				script.println("</script>");
			}
			else {  
				
				EnrolDAO enrolDAO = new EnrolDAO();
				int auth = 1; //방장 권한
				int result2 = enrolDAO.enrol(roomID, userID,auth) ;
				if(result2 == -1) {   //db오류
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('db오류가 발생했습니다.')");
					script.println("location.href = 'main.jsp");
					script.println("</script>");
				}
				
				//가입 성공시 마이스터디 페이지로
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'mystudy.jsp'");   //스터디룸으로 이동
				script.println("</script>");
				}
			}
	}
	

	%>

</body>
</html>