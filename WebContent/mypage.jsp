<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스터디그룹 커뮤니티</title>
    <!-- 부트스트랩 CSS 링크 추가 -->
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

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
                <a href="main.jsp" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none"
                    style="padding-right: 30px;">
                    StudyBuddy
                </a>

                <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                    <li><a href="main.jsp" class="nav-link px-2 text-white">홈</a></li>
                    <li><a href="recruitBBS.jsp" class="nav-link px-2 text-white">모집게시판</a></li>
                    <li><a href="mystudy.jsp" class="nav-link px-2 text-white">나의스터디</a></li>
                </ul>

                <div class="text-end">
					<button type="button" class="btn btn-secondary me-2">
						<a href="logoutAction.jsp"
							style="color: #ffffff; text-decoration: none;">로그아웃</a>
					</button>
					<button type="button" class="btn btn-primary">
						<a href="mypage.jsp" style="color: #ffffff; text-decoration: none;">마이페이지</a>
					</button>
                </div>
            </div>
        </div>
    </header>

    <div class="d-flex">
        <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px; height: calc(100vh - 75px);">
            <div style="margin: 20px;">
                <span class="fs-4">마이페이지</span>
            </div>
        </div>

        <div class="container ms-3 mt-5">

            <h2>마이페이지</h2>
            <hr>

            <!-- 이부분에 게시판 표시 -->

        </div>
    </div>


    <!-- 부트스트랩 JS 및 jQuery 추가 -->
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>

</html>