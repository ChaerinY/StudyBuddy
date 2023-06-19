<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>StudyBuddy</title>
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
<% 
		String userID = null;
		String userName = null;
		if(session.getAttribute("userID")!= null){      //세션이 있으면 userID값을 가지고 없다면 null값
			userID=(String) session.getAttribute("userID");
			userName=(String) session.getAttribute("userName");
		}
		
		if(userID == null){  //로그인이 되어있지 않다면
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp;'");   //로그인페이지로 이동
			script.println("</script>");
		}
				
	%>
    <header class="p-3 text-bg-dark">
        <div class="container">
          <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
            <img src="img/wig_whtie.png" width="30px" style="padding-right: 7px;">
            <a href="main.jsp" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none"
                style="padding-right: 30px;">
                StudyBuddy
            </a>
      </header>


  <main class="container mt-5">
    <section>
      <h2 style="font-weight: bold"><img src="img/wig_blue.png" width="50px" style="padding-right: 7px;">StudyBuddy</h2>
      <br>
      <h4 style="font-weight: bold">스터디 생성</h4>
      <br>
    </section>

    <section>
        <form method="post" action="createAction.jsp" enctype="multipart/form-data">
          <p>스터디룸 이름</p>
          <input type="text" class="form-control" placeholder="아이디를 입력하세요." style="width: 400px;" name="roomName" maxlength="50">
          <br>
      
          <p>스터디 소개</p>
          <textarea class="form-control" placeholder="간단한 소갯말을 입력하세요." style="width: 400px;" name="roomContent" maxlength="2000"></textarea>
          <br>

          <p>이미지 등록</p>
        	<img id="preview" src="upload/stdbd_empty_image.png" alt="Image preview" style="width: 200px; height: 200px;"/>
        	<br>
        	<input type="file" class="form-control" name="imgfile" id="imageUpload" style="width: 400px;" accept="image/*">
        	<br>

          <p>최대 인원수</p>
          <input type="number" class="form-control" placeholder="숫자를 입력하세요." style="width: 400px;" name="maximum" min="1" max="20">
          <br><br>

          <input type="submit" class="btn btn-primary" value="생성하기">
          <button type="button" class="btn btn-secondary" onclick="goBack()">뒤로가기</button>
          <br><br><br>
        </form>
    </section>
  </main>

  <script>
  document.getElementById("imageUpload").addEventListener("change", function(e) {
      let reader = new FileReader();
  
      reader.onload = function(e) {
          let preview = document.getElementById("preview");
          preview.src = e.target.result;
          preview.style.display = "block";
      }
  
      reader.readAsDataURL(this.files[0]);
  });
  
    function goBack() {
      window.history.back();
    }
  </script>

  <!-- 부트스트랩 JS 및 jQuery 추가 -->
    <script type="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>