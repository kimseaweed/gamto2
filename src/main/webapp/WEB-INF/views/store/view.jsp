<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String cartId = (String) session.getAttribute("u_id"); //세션에서 아이디 정보를 얻어와서 cartId로 사용함.

String bookName = (String)request.getParameter("bookName");
String bookQuantity = (String)request.getParameter("bookQuantity");
String stotalCost = (String)request.getParameter("totalCost");
String orderCode = (String)request.getParameter("orderCode");
//System.out.println("bookName: "+bookName);
//System.out.println("bookQuantity: "+bookQuantity);
//System.out.println("stotalCost: "+stotalCost);
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>감토 | 책 자세히 보기</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<jsp:include page="../header.jsp" />
	<main class="b_view container-md bg-light px-5 pt-4 rounded shadow-sm">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item link-primary"><a href="/store">상점</a></li>
				<li class="breadcrumb-item link-primary"><a href="#">책</a></li>
				<li class="breadcrumb-item link-primary"><a href="#">${dto.b_genre}</a></li>
				<li class="breadcrumb-item active" aria-current="page">${dto.b_name}</li>
			</ol>
		</nav>
		<hr class="pb-5" />
		<form action="" name="buyForm" class="buyForm">
			<div class="move-block row">
				<div class="col-md-7 col-12 text-center mb-5">
					<img src="../img/book/${dto.b_filename}" class="move-img shadow" />
				</div>
				<div class="col-md-5 col-12">
					<h3 class="fs-1 fw-semibold py-3">${dto.b_name}</h3>
					<div class="fs-7 ms-auto mt-2 pb-3 text-muted border-bottom">
						<b>${dto.b_author}</b> 저 &nbsp;| &nbsp; <b>${dto.b_publisher}
						</b>출판
					</div>
					<table class="row mt-5 mb-3">
						<tr class="text-muted row mb-1">
							<td class="col-6 fw-bold ">출간일</td>
							<td class="col-6 text-end">${dto.b_release}</td>
						</tr>
						<tr class="text-muted row pb-3">
							<td class="col fw-bold ">가격</td>
							<td class="col b_price text-end"><b><fmt:formatNumber
										value="${dto.b_price}" /></b> 원</td>
						</tr>
						<tr class="countPrice border-top border-bottom py-3 row">
							<td class="col-lg-8 col-md-4 col-8 fw-bold ">구매수량</td>
							<td class="col"><div class="input-group row draggable">
									<button class="input-group-text  text-center" type="button"
										onclick="downCount();">-</button>
									<input type="text" name="b_quantity"
										class="form-control text-center" max="${dto.b_stock}"
										value="1" onchange="getPrice();" />
									<button class="input-group-text  text-center" type="button"
										onclick="upCount();">+</button>
								</div></td>
						</tr>
						<tr class="row my-3">
							<td class="fw-bold col-6">총 상품금액</td>
							<td class="b_priceTot col-6 text-end"><b><fmt:formatNumber
										value="${dto.b_price}" /></b> 원</td>
						</tr>
						<tr class="row mt-5 mt-lg-5 mt-md-4 mb-3">
							<td class="b_priceTot col text-end">
								<a class="btn btn-primary btn-lg addCart" id="${dto.b_code}">장바구니
									담기</a>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</form>
		<hr class="mt-3 md-5" />
		<div class="pt-5 px-5">
			<div class=" pb-5">
				<h3 class="border-bottom pb-2 mb-2">상품 소개</h3>
				<p class="px-3">${dto.b_description}</p>
			</div>
			<div class=" pb-3">
				<h3 class="border-bottom pb-2 mb-2">상품 정보</h3>
				<div class="p-5">
					<table
						class="b-table table table-hover border-secondary border-opacity-25">
						<tr>
							<th class="bg-gray">책 제목</th>
							<td>${dto.b_name}</td>
						</tr>
						<tr>
							<th class="bg-gray">장르</th>
							<td>${dto.b_genre}</td>
						</tr>
						<tr>
							<th class="bg-gray">책 코드</th>
							<td>${dto.b_code}</td>
						</tr>
						<tr>
							<th class="bg-gray">저자</th>
							<td>${dto.b_author}저</td>
						</tr>
						<tr>
							<th class="bg-gray">출판사</th>
							<td>${dto.b_publisher}</td>
						</tr>
						<tr>
							<th class="bg-gray">출판일</th>
							<td>${dto.b_release}</td>
						</tr>
						<tr>
							<th class="bg-gray">가격</th>
							<td>${dto.b_price}원</td>
						</tr>
						<tr>
							<th class="bg-gray">보유재고</th>
							<td>${dto.b_stock}개</td>
						</tr>
					</table>
				</div>
			</div>
		</div>

	</main>
	<script>
		function validateCount() {
			let b_quantity = document.buyForm.b_quantity.value;
			const isValid = /^\d+$/.test(b_quantity)
					&& parseInt(b_quantity) >= 1;
			if (!isValid) {
				alert(' 1 이상의 숫자만 입력해주세요');
				document.buyForm.b_quantity.value = 1;
				return;
			}
		}
		function getPrice() {
			validateCount();
			var b_priceTot = parseInt(document.buyForm.b_quantity.value)
					* parseInt(document.querySelector('.b_price').innerText
							.replace(/,/g, ''));
			document.querySelector('.b_priceTot b').innerHTML = b_priceTot
					.toLocaleString();
		}
		function upCount() {
			document.buyForm.b_quantity.value = parseInt(document.buyForm.b_quantity.value) + 1;
			getPrice();
		}
		function downCount() {
			document.buyForm.b_quantity.value = parseInt(document.buyForm.b_quantity.value) - 1;
			getPrice();
		}
	</script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script>
		var linkElements = document.querySelectorAll('a.addCart'); // 모든 a 태그 선택

		linkElements.forEach(function(link) {
			link.addEventListener('click', function(event) {
				var linkId = link.id; // 클릭한 a 태그의 id 속성 값 가져오기
				var b_quantity = document.buyForm.b_quantity.value;
				$.ajax({
					url : "/store/addCart",
					dataType : 'json',
					type : "post",
					data : {
						'b_code' : linkId,
						'b_quantity' : b_quantity
					},
					success : function(result) {
						if (result == -1) {
							alert("로그인 하세요 ");
							location = '/member/login';
						} else if (result == 0) {
							
						} else {
							alertB('장바구니에 담겼습니다.');
							cartBadge();
						}
					},
					error : function(result) {
						alert("fail");
					}
				})
			});
		});
		
	</script>
	<jsp:include page="../footer.jsp" />
</body>
</html>