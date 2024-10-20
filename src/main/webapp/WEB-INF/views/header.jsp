<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>감토 | 신개념 독서토론</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<link rel="stylesheet" href="/css/gamto.css" />
</head>
<body>

	<!-- 중앙상단 alert 토스트 -->
	<div
		class="toast-container position-fixed start-50 translate-middle-x p-3">
		<div id="msgToastR" class="toast align-items-center text-bg-danger"
			role="alert" aria-live="assertive" aria-atomic="true"
			data-bs-delay="3000">
			<div class="d-flex" style="">
				<div class="toast-body">
					<div class="spinner-grow spinner-grow-sm me-2" role="status">
						<span class="visually-hidden">Loading...</span>
					</div>
					<span id="msgboxR"></span>
				</div>
				<button type="button" class="btn-close me-2 m-auto"
					data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
		</div>
	</div>
	<div
		class="toast-container position-fixed start-50 translate-middle-x p-3">
		<div id="msgToastB" class="toast align-items-center text-bg-primary"
			role="alert" aria-live="assertive" aria-atomic="true"
			data-bs-delay="3000">
			<div class="d-flex" style="">
				<div class="toast-body">
					<div class="spinner-grow spinner-grow-sm me-2" role="status">
						<span class="visually-hidden">Loading...</span>
					</div>
					<span id="msgboxB"></span>
				</div>
				<button type="button" class="btn-close me-2 m-auto"
					data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
		</div>
	</div>
	<div
		class="toast-container position-fixed start-50 translate-middle-x p-3">
		<div id="msgToastY" class="toast align-items-center text-bg-warning"
			role="alert" aria-live="assertive" aria-atomic="true"
			data-bs-delay="3000">
			<div class="d-flex" style="">
				<div class="toast-body">
					<div class="spinner-grow spinner-grow-sm me-2" role="status">
						<span class="visually-hidden">Loading...</span>
					</div>
					<span id="msgboxY"></span>
				</div>
				<button type="button" class="btn-close me-2 m-auto"
					data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
		</div>
	</div>
	<!-- 데스크탑 사이드바  -->
	<div id="sidebar">
		<button type="button"
			class="btn btn-outline-dark btn-lg rounded-circle" id="shareLink"
			onclick="copyLink()">
			<span class="material-symbols-outlined"> share </span>
		</button>
		<script type="text/javascript">
			
		</script>
		<button type="button"
			class="btn btn-outline-dark btn-lg rounded-circle" id="searchSite">
			<span class="material-symbols-outlined"> search </span>
		</button>
		<button type="button"
			class="btn btn-outline-dark btn-lg rounded-circle"
			id="btn-back-to-top">
			<span class="material-symbols-outlined"> expand_less </span>
		</button>
		<!-- 검색 토스트  -->
		<div
			class="toast-container position-fixed bottom-0 end-0 p-3 mb-5 me-5 pe-5">
			<div id="searchToast" class="toast" role="alert"
				aria-live="assertive" aria-atomic="true">
				<div class="toast-header">
					<strong class="me-auto">사이트내 검색하기</strong>
					<button type="button" class="btn-close me-5 pe-5"
						data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body ps-4 pe-2">
					<form action="" method="post" id="searchform">
						<div class="input-group mb-1">
							<select class="form-select" id="searchCategory1" aria-label=""
								onchange="boardCategory()">
								<option value="0" selected>게시판 선택</option>
								<option value="1">너의 생각</option>
								<option value="2">우리 생각</option>
								<option value="3">상점</option>
							</select> <select class="form-select" id="searchCategory2" aria-label=""
								disabled="disabled" name="item">
								<option selected>선택</option>
								<option value="1">너의 생각</option>
								<option value="2">우리 생각</option>
								<option value="3">상점</option>
							</select>
						</div>
						<div class="input-group mb-3">
							<input type="text" class="form-control" placeholder="검색어를 입력해주세요"
								id="searchQuery" name="text"> <span
								class="input-group-text px-5" onclick="searchsite()"
								style="cusor: pointer;">검색</span>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 당근커서. 데스크탑용  -->
	<div class="carrot d-none d-lg-block"></div>
	<!-- 데스크탑헤더 : lg 이상 환경 : 992px이상 -->
	<header
		class="d-none d-lg-block position-fixed top-0 d-flex justify-content-between px-5">
		<nav class="flex-wrap justify-content-between pt-3 pb-2 d-flex">
			<div class="logobox pb-2">
				<a href="/" class="text-decoration-none d-flex align-items-end">
					<div class="img"></div> <span class="ms-3 link-dark display-5 mb-2">감토</span>
				</a>
			</div>
			<ul class="nav-pills d-flex align-items-end mb-1">
				<li class="nav-item"><a href="/report/new"
					class="px-3 mx-1 link-dark link2 link2_green"
					data-bs-placement="left" data-bs-html="true"
					data-bs-toggle="tooltip" data-bs-title="| 글쓰기 |<br>나의 생각을 적어보세요">나의
						생각</a></li>
				<li class="nav-item"><a href="/report"
					class="px-3 mx-1 link-dark link2 link2_blue"
					data-bs-placement="left" data-bs-html="true"
					data-bs-toggle="tooltip"
					data-bs-title="| 독후감 |<br>다른 감토님의 생각도 <br>확인해 보세요">너의 생각</a></li>
				<li class="nav-item"><a href="/board"
					class="px-3 mx-1 link-dark link2 link2-purple link"
					data-bs-placement="left" data-bs-html="true"
					data-bs-toggle="tooltip"
					data-bs-title="| 게시판 |<br>감토님들과 생각을 <br>나눠보세요">우리 생각</a></li>
				<li class="nav-item ms-5 pb-1"><a href="/store"
					class="link-dark" data-bs-placement="bottom" data-bs-html="true"
					data-bs-toggle="tooltip" data-bs-title="상점 "> <span
						class="material-symbols-outlined fs-1">local_mall</span></a></li>
				<li class="nav-item"><a href="/store/cart"
					class="ms-1 me-5 link-dark  position-relative"
					data-bs-placement="bottom" data-bs-html="true"
					data-bs-toggle="tooltip" data-bs-title="장바구니"> <span
						class="material-symbols-outlined fs-1">shopping_cart </span> <span
						class="badge position-absolute start-100 translate-middle cartBadge rounded-pill bg-danger d-none"><span></span></span>
				</a></li>
				<%
				if (session.getAttribute("u_id") == null) {
				%>
				<li class="nav-item dropdown"><a
					class="dropdown-toggle link-dark" href="/member/login"
					role="button" data-bs-toggle="dropdown" aria-expanded="false">
						<span class="material-symbols-outlined fs-1">input</span>
				</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="/member/login">로그인</a></li>
						<li><a class="dropdown-item" href="/member/addMember">회원가입</a></li>
					</ul></li>
				<%
				} else {
				%>
				<li class="nav-item dropdown"><a
					class="dropdown-toggle link-dark" href="/member" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> <span
						class="material-symbols-outlined fs-1">account_circle</span>
				</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="/member/logoutMember">로그아웃</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item" href="/member/myPage">나의 공간</a></li>
						<li><a class="dropdown-item" href="/store/purchaseList">구매내역</a></li>
						<li><a class="dropdown-item" href="/myboard">내 글보기</a></li>
						<li><a class="dropdown-item" href="/member/updateMember">회원
								수정</a></li>
					</ul></li>
				<%
				}
				%>

			</ul>
		</nav>
	</header>
	<!-- 랩탑,태블릿,모바일 헤더 : md 이상 환경 : 991px이하 -->
	<header class="d-block d-lg-none">
		<nav class="navbar bg-light fixed-top px-5">
			<div class="container-fluid">
				<div class="logobox me-auto">
					<a href="/" class="d-flex">
						<div class="img"></div> <span class="fs-1 pt-3 ps-1">감토</span>
					</a>
				</div>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
					aria-controls="offcanvasNavbar">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="offcanvas offcanvas-end" tabindex="-1"
					id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
					<div class="offcanvas-header logobox">
						<div class="img"></div>
						<h3 class="offcanvas-title fs-1 me-auto pt-3"
							id="offcanvasNavbarLabel">감토</h3>
						<button type="button" class="btn-close"
							data-bs-dismiss="offcanvas" aria-label="Close"></button>
					</div>
					<div class="offcanvas-body">
						<ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
							<!-- active -->
							<li class="nav-item"><a class="nav-link fs-2 fw-bold"
								aria-current="page" href="/report/new"><i
									class="bi bi-blockquote-left me-3"></i>나의 생각</a></li>
							<li class="nav-item"><a class="nav-link fs-2 fw-bold"
								href="/report"><i class="bi bi-blockquote-left me-3"></i>너의
									생각</a></li>
							<li class="nav-item"><a class="nav-link fs-2 fw-bold"
								href="/board"><i class="bi bi-blockquote-left me-3"></i>우리
									생각</a></li>
							<hr />
							<li class="nav-item"><a class="nav-link fs-2 fw-bold"
								href="/store"> <span
									class="material-symbols-outlined fs-1 align-middle me-3">local_mall</span>상점
							</a></li>
							<li class="nav-item"><a
								class="position-relative nav-link fs-2 fw-bold"
								href="/store/cart"> <span
									class="material-symbols-outlined fs-1 align-middle me-3">shopping_cart</span>
									<span
									class="badge position-absolute t-0 translate-middle cartBadge rounded-pill bg-danger p-1 d-none">
								</span> 장바구니
							</a></li>
							<%
							if (session.getAttribute("u_id") == null) {
							%>
							<li class="nav-item dropdown fs-2 fw-bold"><a
								class="nav-link dropdown-toggle"  role="button"
								data-bs-toggle="dropdown" aria-expanded="false"> <span
									class="material-symbols-outlined fs-1 align-middle me-3">input</span>로그인
							</a>
								<ul class="dropdown-menu">
									<li><a class="dropdown-item fw-bold fs-3 fw-bold"
										href="/member/login">로그인</a></li>
									<li><a class="dropdown-item fw-bold fs-3 fw-bold"
										href="/member/addMember">회원가입</a></li>
								</ul></li>
							<%
							} else {
							%>
							<li class="nav-item dropdown fs-1 fw-bold"><a
								class="nav-link dropdown-toggle fs-2 fw-bold" 
								role="button" data-bs-toggle="dropdown" aria-expanded="false">
									<span class="material-symbols-outlined fs-1 align-middle me-3">account_circle</span>나의
									공간
							</a>
								<ul class="dropdown-menu">
									<li><a class="dropdown-item fs-3 fw-bold"
										href="/member/logoutMember">로그아웃</a></li>
									<li><hr class="dropdown-divider"></li>
									<li><a class="dropdown-item fs-3 fw-bold"
										href="/member/myPage">나의공간</a></li>
									<li><a class="dropdown-item fs-3 fw-bold"
										href="/store/purchaseList">구매내역</a></li>
									<li><a class="dropdown-item fs-3 fw-bold" href="/myboard">내글보기</a></li>
									<li><a class="dropdown-item fs-3 fw-bold"
										href="/member/updateMember">회원수정</a></li>
								</ul></li>
							<%
							}
							%>
							<hr />
						</ul>
						<form class="d-flex mt-3" role="search">
							<input class="form-control me-2" type="search"
								placeholder="Search" aria-label="Search">
							<button class="btn btn-outline-success" type="submit">Search</button>
						</form>
					</div>
				</div>
			</div>
		</nav>
	</header>
</body>
</html>