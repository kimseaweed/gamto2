<%@page import="ch.qos.logback.core.model.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>감토 | 상점</title>
</head>
<body>
	<jsp:include page="../header.jsp" />
	<!-- main > 메인헤더 + 케로셀블럭 + 책상점 블럭 + 굿즈블럭  -->
	<main class="store container-md bg-light p-5">
		<!-- 메인헤더  -->
		<div class="">
			<h1 class="text-center pb-3 border-bottom mb-3">상점</h1>
		</div>
		<!-- 케로셀블럭  -->
		<div class="py-3 mb-5">
			<div id="carouselExampleDark" class="carousel carousel-dark slide"
				data-bs-ride="carousel">
				<div class="carousel-indicators">
					<button type="button" data-bs-target="#carouselExampleDark"
						data-bs-slide-to="0" class="active" aria-current="true"
						aria-label="Slide 1"></button>
					<button type="button" data-bs-target="#carouselExampleDark"
						data-bs-slide-to="1" aria-label="Slide 2"></button>
					<button type="button" data-bs-target="#carouselExampleDark"
						data-bs-slide-to="2" aria-label="Slide 3"></button>
				</div>
				<div class="carousel-inner">
					<!-- 케로셀1 -->
					<div class="carousel-item active" data-bs-interval="8000">
						<img src="../img/b_list/b_list_1.gif" alt="..."
							class="caro-img text-center">
						<div class="carousel-caption d-none d-md-block">
							<h5>제목</h5>
							<p>내용</p>
						</div>
					</div>
					<!-- 케로셀2 -->
					<div class="carousel-item" data-bs-interval="7000">
						<img src="../img/b_list/b_list_2.gif" class="caro-img text-center">
						<div class="carousel-caption d-none d-md-block">
							<h5>광고2</h5>
							<p>광고2의 내용</p>
						</div>
					</div>
					<!-- 케로셀3 -->
					<div class="carousel-item" data-bs-interval="7000">
						<img src="../img/b_list/b_list_3.gif" alt="..." class="caro-img">
						<div class="carousel-caption d-none d-md-block">
							<h5>광고3</h5>
							<p>광고3의 내용</p>
						</div>
					</div>
				</div>

				<button class="carousel-control-prev" type="button"
					data-bs-target="#carouselExampleDark" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="#carouselExampleDark" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>
		</div>
		<!--책상점 블럭  -->
		<div class=" py-3">
			<div class="border-bottom row">
				<h3 class=" ps-5 col">책 상점</h3>
				<p class="col text-end">감토에서 추천하는 책들을 만나보세요</p>
			</div>

			<div class="row mt-5 px-4 mb-5">
				<c:forEach var="dto" items="${store}" end="5">

					<div class="ribbon-wrapp col-xl-4 col-md-6 py-2 px-xl-4 px-1">
						<div class="ribbon">best</div>

						<div
							onclick="location='/store/view?b_code=${dto.b_code}'; return false;"
							class="row g-0 rounded overflow-hidden flex-md-row shadow-sm-hover h-md-250 position-relative px-3 py-2">
							<div class="col-6">
								<img src="../img/book/${dto.b_filename}"
									class="rounded b_list-thumbnail shadow-sm" width="" />
							</div>
							<div class="col px-md-3 px-5 d-flex flex-column position-static">
								<strong class="fs-7 d-inline-block mb-2 text-primary">[${dto.b_genre}]</strong>
								<h3 class="mb-0 fs-2">${dto.b_name}</h3>
								<div class="fs-7 ms-auto mt-2 text-muted">
									<b>${dto.b_author}</b> 저
								</div>
								<div class="fs-7 ms-auto mb-auto text-muted">
									<b>${dto.b_publisher} </b>출판
								</div>

								<div class="mb-1 text-muted text-end">
									<B>${dto.b_price}</B> 원
								</div>
								<a src="/store/addCart"
									class="btn btn-outline-primary text-center fs-6 addCart"
									onclick="event.stopPropagation();" id="${dto.b_code}">장바구니
								</a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="row">
				<form action="/store/SearchTotal" name="SearchTotal" method="post">
					<select name="item">
					    <option selected value="all">전체</option>
						<option value="b_name">제목</option>
						<option value="b_author">저자</option>
				        <option value="b_publisher">출판사</option>
				        <option value="b_code">ISBN코드</option>
					</select> 
					<input type="text" name="text" /> 
					<input type="submit" value="검색" />
				</form>
				<div class="text-center mt-2">
					<a href="?pageNo=1">&lt;&lt;</a>

					<c:if test="${page.startNo eq 1}">
						<a href="?pageNo=1">&lt;</a>
					</c:if>
					<c:if test="${page.startNo ne 1}">
						<a href="?pageNo=${page.pageNo-1}">&lt;</a>
					</c:if>

					<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
						<a href="?pageNo=${i}">${i}</a>
					</c:forEach>

					<a href="?pageNo=${page.pageNo+1}">&gt;</a> <a
						href="?pageNo=${page.totalPage}">&gt;&gt;</a>
				</div>
			</div>
			<!-- row -->
		</div>

	</main>
	<jsp:include page="../footer.jsp" />
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script>
		var linkElements = document.querySelectorAll('a.addCart'); // 모든 a 태그 선택

		linkElements.forEach(function(link) {
			link.addEventListener('click', function(event) {
				var linkId = link.id; // 클릭한 a 태그의 id 속성 값 가져오기
				$.ajax({
					url : "/store/addCart",
					dataType : 'json',
					type : "post",
					data : {
						'b_code' : linkId,
						'b_quantity' : '1'
					},
					success : function(result) {
						if (result == -1) {
							alert("로그인 하세요 ");
							location = '/member/login';
						} else {
							alertB("상품이 장바구니에 담겼습니다");
							
						}
					},
					error : function(result) {
						alert("fail");
					}
				})
			});
		});
	</script>
</body>
</html>