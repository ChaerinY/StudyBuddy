<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>StudyBuddy</title>
</head>
<body>
	<% session.invalidate(); %>   <!-- 세션을 해제하고  -->
	
	<script>
		location.href = 'main.jsp';   //메인페이지로 이동
	</script>
</body>
</html>