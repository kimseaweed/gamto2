<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mrmr.gamto.help.dto.AccuseDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>관리자 페이지 | 상점 등록</title>
<style>
</style>
</head>
<body>
<div class="d-none">
	<jsp:include page="../header.jsp" />
</div>
	<main class="mx-auto p-3 mt-2">
		<div class="bg-light mb-5 px-2 py-xl-5 py-0">
			<div class="col-auto row pt-3">
				<jsp:include page="adminPageSideBar.jsp" />
				<div class="container  col pt-lg-3 p-5">
					<!--  -->
					<c:choose>
						<c:when test="${empty command}">
							<form method="POST" action="/admin/store/new" id="storeInsertForm"
								name="storeInsertForm" enctype="multipart/form-data" class="">						
						</c:when>
						<c:otherwise>
							<form method="POST" action="/admin/store/edit/${book.b_code}" id="storeInsertForm"
								name="storeInsertForm" enctype="multipart/form-data" class="">
						</c:otherwise>
					</c:choose>
						<div class="container row">
							<c:choose>
								<c:when test="${empty command}">
							<div class="display-6 py-5"> 상품관리 | 상품등록 </div>
								</c:when>
								<c:otherwise>
								<div class="display-6 py-5"> 상품관리 | 상품수정 </div>
								</c:otherwise>
							</c:choose>
						
							<div class="mb-3 col-lg-6 col-12">
								<label for="b_code" class="form-label">도서코드</label> 
								<input type="text" class="form-control" id="b_code" name="b_code" placeholder="코드" value="${book.b_code}">
							</div>

							<div class="mb-3 col-lg-6 col-12">
								<label for="b_name" class="form-label">상품명</label> 
								<input type="text" class="form-control" id="b_name" name="b_name" placeholder="상품명" value="${book.b_name}">
							</div>							
							
							<div class="mb-3 col-lg-6 col-12">
								<label for="b_author" class="form-label">저자</label> 
								<input type="text" class="form-control" id="b_author" name="b_author" placeholder="저자" value="${book.b_author}">
							</div>			
											
							<div class="mb-3 col-lg-6 col-12">
								<label for="b_genre" class="form-label">장르</label> 
								<input type="text" class="form-control" id="b_genre" name="b_genre" placeholder="장르" value="${book.b_genre}">
							</div>
							
							<div class="mb-3 col-lg-6 col-12">
								<label for="b_publisher" class="form-label">출판사</label> 
								<input type="text" class="form-control" id="b_publisher" name="b_publisher" placeholder="출판사" value="${book.b_publisher}">
							</div>
							
							<div class="mb-3 col-lg-6 col-12">
								<label for="b_release" class="form-label">출판일</label> 
								<input type="text" class="form-control" id="b_release" name="b_release"  placeholder="출판일" value="${book.b_release}">
							</div>
							
							<div class="mb-3 col-lg-6 col-12">
								<label for="b_stock" class="form-label">재고</label> 
								<input type="number" class="form-control" id="b_stock" name="b_stock" placeholder="재고" value="${book.b_stock}">
							</div>
							
							<div class="mb-3 col-lg-6 col-12">
								<label for="b_price" class="form-label">가격</label> 
								<input type="number" class="form-control" id="b_price" name="b_price" placeholder="가격" value="${book.b_price}">
							</div>
							
							
							<div class="mb-3 col-12">
								<label for="b_description" class="form-label">책 설명</label>
								<textarea class="form-control" id="b_description" name="b_description" rows="3"> ${book.b_description}</textarea>
							</div>

							<div class="mb-3 col-12">
								<label for="filename" class="form-label">책 이미지</label>
								<input class="form-control" type="file" id="filename" name="filename" >
								<c:if test="${not empty command}">
								<div class="text-center py-3">
								<label for="filename" class="form-label">기존 이미지</label>
								<img src="/img/book/${book.b_filename}"/>
								<input class="" type="hidden" id="b_filename" name="b_filename" value="${book.b_filename}">	
								</div>						
								</c:if>
							</div>


						</div>



						<div class="py-5">
							<c:choose>
								<c:when test="">
									<input type="button" value="등록하기" class="col-12 btn btn-secondary" onclick="storesubmit()">
								</c:when>
								<c:otherwise>
									<input type="button" value="수정하기" class="col-12 btn btn-secondary" onclick="storesubmit()">
								</c:otherwise>
							</c:choose>
						</div>

					</form>


					<!--  -->
				</div>
			</div>
		</div>
	</main>
<script type="text/javascript">
//유효성 검사 : 파일업로드
var fileinput = document.querySelector('input[type="file"]');
fileinput.addEventListener("input", function(){
	const fileForm = /(.*?)\.(jpg|jpge|png|gif|bmp|pdf)$/;
	const maxSize = 1024*1024*5;
		if(!fileinput.value.match(fileForm)){
			alertY('이미지파일 만 선택할 수 있습니다'); 
			fileinput.value = "";
			return;
		}else if(document.querySelector('input[type="file"]').files[0].size >= maxSize){
			alertY('5mb 이하 만 선택할 수 있습니다'); 
			fileinput.value = "";
			return;
		}else if(fileinput.value.length>300){
			fileinput.value = "";
			return
		}//if end
})//event end

//유효성 검사 : 업로드전 입력값 확인
function storesubmit(){
	if(b_code.value==""){
		alertY('도서코드가 비었습니다');
		b_code.focus();
	}else if(b_name.value==""){
		alertY('상품명이 비었습니다');
		b_name.focus();
	}else if(b_genre.value==""){
		alertY('장르가 비었습니다');
		b_genre.focus();
	}else if(b_publisher.value==""){
		alertY('출판사가 비었습니다');
		b_publisher.focus();
	}else if(b_release.value==""){
		alertY('출판일이 비었습니다');
		b_release.focus();
	}else if(b_stock.value==""){
		alertY('재고가 비었습니다');
		b_stock.focus();
	}else if(b_price.value==""){
		alertY('가격이 비었습니다');
		b_price.focus();
	}else if(b_description.value==""){
		alertY('책설명이 비었습니다');
		b_description.focus();
	}else if(filename.value==""){
		alertY('사진이 비었습니다');
		filename.focus();
		/////////////////////////
	}if(b_code.value.length>20){
		alertY('도서코드가 너무 깁니다');
		b_code.focus();
	}else if(b_name.value.length>50){
		alertY('상품명이 너무 깁니다');
		b_name.focus();
	}else if(b_genre.value.length>20){
		alertY('장르가 너무 깁니다');
		b_genre.focus();
	}else if(b_publisher.value.length>20){
		alertY('출판사가 너무 깁니다');
		b_publisher.focus();
	}else if(b_release.value.length>20){
		alertY('출판일이 너무 깁니다');
		b_release.focus();
	}else if(b_description.value.length>1000){
		alertY('책설명이 너무 깁니다');
		b_description.focus();
	}
	
	storeInsertForm.submit();
}


</script>
	<jsp:include page="../footer.jsp" />
</body>
</html>