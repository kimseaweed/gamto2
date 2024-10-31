<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>감토 | 나의생각</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<style>
</style>
</head>
<body>
	<jsp:include page="../header.jsp" />

	<main class="container-md bg-light px-5 pt-4 rounded shadow-sm">

		<form id="writeForm" name="writeForm" method="post" class="p-5 mb-4 bg-light rounded-3 needs-validation"
			enctype="multipart/form-data">
			<div class="mb-1">
				<c:choose>
					<c:when test="${empty requestType}">
						<h3>나의생각 | 독후감 작성하기</h3>
					</c:when>
					<c:otherwise>
						<h3>나의생각 | 독후감 수정하기</h3>
						<input type="hidden" name="_method" value="PUT">
						<input type="hidden" name="r_filename" value="${updateForm.r_filename}">
					</c:otherwise>
				</c:choose>
				<input type="hidden" name="r_writer" value="${u_id}" />
				<c:if test="${not empty requestType}">
					<input type="hidden" name="r_seq_number"
						value="${updateForm.r_seq_number}" />
				</c:if>
			</div>

			<div class="text-center mt-5 mb-2 fs-5">
				<div class="form-check  form-check-inline">
					<input class="form-check-input addbookinfo" type="radio"
						name="select" id="all" value="" checked> <label
						class="form-check-label" for="all"> 전체 검색 </label>
				</div>
				<div class="form-check form-check-inline">
					<input class="form-check-input addbookinfo" type="radio"
						name="select" id="title" value="title"> <label
						class="form-check-label" for="title"> 제목 검색 </label>
				</div>
				<div class="form-check form-check-inline">
					<input class="form-check-input addbookinfo" type="radio"
						name="select" id="person" value="person"> <label
						class="form-check-label" for="person"> 작가 검색 </label>
				</div>
				<div class="form-check form-check-inline">
					<input class="form-check-input addbookinfo" type="radio"
						name="select" id="publisher" value="publisher"> <label
						class="form-check-label" for="publisher"> 출판사 검색 </label>
				</div>
				<div class="form-check form-check-inline">
					<input class="form-check-input addbookinfo" type="radio"
						name="select" id="isbn" value="isbn"> <label
						class="form-check-label" for="isbn"> 도서코드 검색 </label>
				</div>
			</div>
			<div class="input-group input-group-lg mb-5 row">
				<button class="btn btn-secondary col-xl-2 col-md-3 col-12 fs-6"
					type="button" onclick="resetFooter()">책 정보 삭제</button>
				<input type="text" class="form-control-lg col-xl-7 col-md-6 col-9"
					name="reportFooter" id="reportFooter-query"
					enterkeyhint="search"
					placeholder="책 정보를 검색해보세요.">
				<button class="btn btn-primary col-3" type="button"
					id="reportFooter-submit" data-bs-toggle="modal"
					data-bs-target="#exampleModal">검색하기</button>
			</div>


			<div class="input-group input-group-lg mt-2 mb-2">
				<input name="r_title" class="form-control" type="text" placeholder="제목을 입력해주세요" autocomplete="off" maxlength="300" value="${updateForm.r_title}">
			</div>

				<c:choose>
					<c:when test="${empty requestType}">
						<div class="input-group mb-0">
						<input name="filename" class="form-control" id="inputGroupFile02"
							type="file" accept="image/*," />
						<label class="input-group-text" for="inputGroupFile02">썸네일을
							골라주세요!</label>
					</div>
						<p class="text-muted mb-2">
						썸네일을 선택하지 않으면 기본 썸네일이 선택됩니다.</p>
					</c:when>
					<c:otherwise>
					<div class="input-group mb-3" id="checkImg">
						 <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">메뉴</button>
							  <ul class="dropdown-menu">
							    <li><button type="button" id="resetImg" class="dropdown-item" > 썸네일 삭제(기본 썸네일 선택) </button></li>
							    <li><button type="button" id="changeImg" class="dropdown-item" > 새로운 썸네일 선택 </button></li>
							  </ul>
							  <input type="text" class="form-control" name="showImg" value="${updateForm.r_filename}" readonly="readonly">
						<button type="button" class="btn btn-secondary" id="viewImg">기존 썸네일 확인하기</button>
					</div>
					<div class="mb-3 newfile d-none">
						<input name="filename" class="form-control" id="filename"
							type="file" accept="image/*," />
						  <label for="filename" class="form-label text-primary">새로운 썸네일을 선택하지 않으면 기존 썸네일로 유지됩니다.</label>
					</div>
					</c:otherwise>
				</c:choose>
			<div class="invalid-feedback text-end mt-3 fs-5">내용이 비어있어요!</div>
			<input type="text" name="r_content" class="form-control" id="summernote" ${updateForm.r_content} >
			<input type="hidden" name="footer" id="footer">
			<div id="reportFooter-preview" class="d-none"></div>

			<div class="col-12 pt-4 d-grid gap-2 d-md-flex">
				<button class="btn btn-warning me-md-3" type="button"
					onclick="location='/report'; return false;">너의생각으로 이동</button>
				<button class="btn btn-warning me-md-3" type="button"
					onclick="location='/board'; return false;">우리생각으로 이동</button>
				<button class="btn btn-primary ms-md-auto p-2 mt-3 mt-md-0"
					type="submit">작성하기</button>
			</div>
		</form>
		<script>
			$(document).ready(function(){
				const requestType= '${requestType}';
				const no = '${updateForm.r_seq_number}'
				if(requestType==''){
					$('#writeForm').attr('action','/report');
				}else{
					$('#writeForm').attr('action','/reportupdate/'+no);
				}
			})
		</script>
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div
				class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">책정보 검색</h1>
						<button type="button" class="btn-close searchClose"
							data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body"></div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary searchClose"
							data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>

	</main>

	<jsp:include page="../footer.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/lang/summernote-ko-KR.min.js"></script>
	<script src="../js/key.js"></script>
	<script src="../js/write.js"></script>
</body>
</html>