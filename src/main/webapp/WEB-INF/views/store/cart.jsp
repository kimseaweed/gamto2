<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
<%
String cartId = (String) session.getAttribute("u_id"); //세션에서 아이디 정보를 얻어와서 cartId로 사용함.
%>   

<style>
.custom-h1 {
	display: inline;
}

.custom-line {
	
}
</style>
<meta charset="UTF-8">
<title>감토 | 장바구니</title>
</head>
<body>
	<jsp:include page="../header.jsp" />
	<main>
		<div class="container">
			<div class="row bg-light">
				<section class="h-100 h-custom">
					<div class="container h-100 py-5">
						<div
							class="row d-flex justify-content-center align-items-center h-100">
							<div class="col">
								<div class="table-responsive">
									<table class="table">
										<thead>
											<tr>
												<th scope="col" class="h5">장바구니 목록</th>
												<th scope="col">수량</th>
												<th scope="col">가격</th>
												<th scope="col">합계</th>
												<th scope="col"><a href="/store/removeAllCart"
													class="custom-line my-auto">모두 비우기</a></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="dto" items="${cart}" varStatus="status">
												<c:set var="sum"
													value="${sum +(dto.cart_price * dto.cart_quantity)}" />
												<c:set value="${dto.cart_price}" var="price" />
												<c:set value="${dto.cart_quantity}" var="quantity" />
												<c:set value="${dto.cart_price * dto.cart_quantity}"
													var="total" />
												<c:set var="quantities" value="${quantities+quantity}"/>
												<input type="hidden" value="${quantites}"/>
												<c:set var="price" value="${price}"/>
												<input type="hidden" value="${price}"/>
												<tr>
													<th scope="row">
														<div class="d-flex align-items-center">
															<img src="../img/book/${dto.cart_filename}"
																class="img-fluid rounded-3" style="width: 120px;"
																alt="Book">
															<div class="flex-column ms-4">
																<p class="mb-2">${dto.cart_name}</p>
																<p class="mb-0">
																	<b>${dto.cart_author}</b> 저
																</p>
															</div>
														</div>
													</th>
													<td class="align-middle">
														<div class="d-flex flex-row" id="${dto.cart_code}">
															<button class="btn btn-link px-2 addCart"
																data-minus="${status.index}"
																onclick="this.parentNode.querySelector('input[type=number]').stepDown()">
																<i class="fas fa-minus"></i>
															</button>
															<input min="0" value="${dto.cart_quantity}"
																data-index="${status.index}" type="number"
																class="form-control form-control-sm addCart"
																style="width: 50px;" />
															<button class="btn btn-link px-2 addCart"
																data-plus="${status.index}" id="${dto.cart_code}"
																onclick="this.parentNode.querySelector('input[type=number]').stepUp()">
																<i class="fas fa-plus"></i>
															</button>
														</div>
													</td>
													<td class="align-middle"><span class="mb-0"
														style="font-weight: 500;" data-price="${status.index}">${price}</span><span>원</span>
													</td>

													<td class="align-middle"><span class="mb-0"
														style="font-weight: 500;" data-total="${status.index}">${total}</span>
													</td>
													<td class="align-middle ps-5"><a
														href="/store/removeCart?b_code=${dto.cart_code}">X</a></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>

								<div class="card shadow-2-strong mb-5 mb-lg-0"
									style="border-radius: 16px;">
									<div class="card-body p-4">
										<div class="row">

											<div class="col-lg-4 col-xl-3" id="cartSum">
												<div>
													<div class="d-flex justify-content-between"
														style="font-weight: 500;">
														<p class="mb-2">총합 금액</p>
														<p class="mb-2">${sum}원</p>
													</div>

													<hr class="my-4">

													<div class="d-flex justify-content-between mb-4"
														style="font-weight: 500;">
														<p class="mb-2">결제 금액</p>
														<p class="mb-2">${sum}원</p>
													</div>
													<div class="d-flex justify-content-between">
														<form method="post" action="/kakaoPay">
															<input type="hidden" value="${cart[0].cart_name}"
																name="bookName" /> 
															<input type="hidden"
																value="${price}" name="bookPrice" /> 
															<input type="hidden"
																value="${quantities}" name="bookQuantity" /> 
															<input
																type="hidden" value="${sum}" name="totalCost" />
															<input
																type="hidden" value="0" name="orderCode" />
															<button
																class="kkoPay btn btn-warning btn-lg me-lg-3 me-md-2 me-3"></button>
														</form>
													</div>
												</div>

											</div>
											<!-- cartSum -->
										</div>

									</div>
								</div>

							</div>
						</div>
					</div>
				</section>
			</div>
			<!-- row -->
		</div>
		<!-- container -->

	</main>
	<jsp:include page="../footer.jsp" />
</body>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
	//장바구니에서 상품 더하기 빼기 script
	const quantityIndex = $("[data-index]");

	for (let i = 0; i < quantityIndex.length; i++) {
		quantityIndex[i].addEventListener('change', function() {
			const cart_code = $(this).closest('div').attr('id');
			this.value = checkRange(this.value);
			const quantity = this.value;

			result(i, quantity, cart_code);
		})
	}

	const quantityMinus = $("[data-minus]");

	for (let i = 0; i < quantityIndex.length; i++) {
		quantityMinus[i].addEventListener('click', function() {
			let quantity = Number($("[data-index='" + i + "']")[0].value) - 1;
			const cart_code = $(this).closest('div').attr('id');
			quantity = checkRange(quantity);
			$("[data-index='" + i + "']")[0].value = quantity;

			result(i, quantity, cart_code);
		})
	}

	const quantityPlus = $("[data-plus]");

	for (let i = 0; i < quantityIndex.length; i++) {
		quantityPlus[i].addEventListener('click', function() {
			let quantity = Number($("[data-index='" + i + "']")[0].value) + 1;
			const cart_code = $(this).closest('div').attr('id');
			quantity = checkRange(quantity);
			$("[data-index='" + i + "']")[0].value = quantity;

			result(i, quantity, cart_code);
		})
	}

	function checkRange(quantity) {
		if (quantity < 1) {
			alert("1개 이상");

			return 1;
		} else if (quantity > 1000) {
			alert("1000개 이하");

			return 1000;
		} else {
			return quantity;
		}
	}

	function result(index, quantity, cart_code) {

		const price = $("[data-price='" + index + "']")[0].innerHTML;
		const total = quantity * price;

		$("[data-total='" + index + "']")[0].innerHTML = total;

		$.ajax({
			url : "/store/updateQuantity",
			dataType : 'json',
			type : "post",
			data : {
				'cart_code' : cart_code,
				'cart_quantity' : quantity
			},
			success : function(result) {
				if (result == -1) {
					alert("로그인 하세요 ");
					location = '/member/login';
				} else {
					console.log("상품이 담겼습니다.");
					cartBadge();
				}
				setTimeout(function() {
					$("#cartSum").load(location.href + " #cartSum>div");
				}, 100);
			},
			error : function(result) {
				console.log("fail");
			}
		})
	}
</script>
</html>