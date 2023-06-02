<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>StudyBuddy - login page</title>
  <!-- 부트스트랩 CSS 링크 추가 -->
  <!-- CSS only -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<!-- 구글 폰트 사용 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

<style>
	* {font-family: 'Nanum Gothic', sans-serif;}  /*페이지 전체에 나눔고딕 폰트 사용*/
</style>

</head>
<body>
  <header class="p-3 text-bg-dark">
    <div class="container">
      <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
        <img src="img/wig_whtie.png" width="30px" style="padding-right: 7px;">
        <a href="main.jsp" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none" style="padding-right: 30px;">
          StudyBuddy
        </a>
  </header>

  <main class="container mt-5 d-flex justify-content-center flex-column">
    <section class="d-flex flex-column align-items-center">
      <h2 style="font-weight: bold"><img src="img/wig_blue.png" width="50px" style="padding-right: 7px;">StudyBuddy</h2>
      <br>
      <h4>LOGIN</h4>
      <br>
    </section>

    <section class="d-flex flex-column align-items-center">
      <form method="post" action="loginAction.jsp">
	      <input type="text" class="form-control" placeholder="username" style="width: 400px;" name="userID" maxlength="20">
	      <br>
	      <input type="password" class="form-control" placeholder="password" style="width: 400px;" name="userPassword" maxlength="20">
	      <br>
	      <br>
	      <input type="submit" class="btn btn-primary" style="width: 400px;" value="LOGIN">
      </form>
      <br>
      <br>
      <p>계정이 없다면? <a href="join.jsp">회원가입 </a></p>
    </section>
  </main>

  <!-- 부트스트랩 JS 및 jQuery 추가 -->
  <script type="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

</body>
</html>
