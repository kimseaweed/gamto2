<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>감토 | 우리 생각</title>
<%
	String f_writer = (String)session.getAttribute("u_id");
%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css">

</head>
<body>
	<jsp:include page="../header.jsp" />
	<script>
		$(document).ready(function(){
			${alertLogin}
		})
	</script>
	<main class="container-md bg-light px-5 pt-4 rounded shadow-sm">
		<form id="writeForm" action="/board/write" method="post" class="p-5 mb-4 bg-light rounded-3 needs-validation" novalidate>
			<input type="hidden" name="f_writer" value="<%=f_writer %>" />
			<div class="mb-5">
				<h3>우리생각 | 자유롭게 작성해주세요</h3>
				<h6>작성자 : <%=f_writer %></h6>
			</div>
			<div class="mb-2">
				<select name="f_category">
					<option value="토론회 모집">토론회 모집</option>
					<option value="토론">토론</option>
					<option value="책추천">책추천</option>
					<option value="책교환">책교환</option>
					<option value="자유로운 이야기" selected>자유로운 이야기</option>
				</select>
			</div>
			<div class="mb-3">
				<input name="f_title" class="form-control" type="text"
					id="validationCustomUsername" placeholder="제목을 입력해주세요"
					aria-label="default input example" required>
				<div class="invalid-feedback">제목을 입력해주세요</div>
			</div>
			<textarea name="f_content" class="form-control" id="summernote" required></textarea>
			<div class="invalid-feedback text-end mt-3 fs-5">내용이 비어있어요!</div>
			<div class="col-12 pt-4 d-grid gap-2 d-md-flex">
				<button class="btn btn-warning me-md-3" onclick="location='/board'; return false;">목록으로 이동</button>
				<button class="btn btn-primary ms-md-auto p-2 mt-3 mt-md-0" type="submit">작성하기</button>
			</div>
		</form>
	</main>
	<jsp:include page="../footer.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/lang/summernote-ko-KR.min.js"></script>
	<script>
		$('#summernote').summernote({
			placeholder : '감토님의 생각을 자유롭게 표현해보세요.',
			tabsize : 2,
			height : 500,
			lang : 'ko-KR',
			focus : true,
			disableGrammar: false,
			toolbar: [
				    ['fontname',['fontname']],
				    ['fontsize', ['fontsize']],
				    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
				    ['color', ['forecolor','color']],
				    ['table', ['table']],
				    ['para', ['ul', 'ol', 'paragraph']],
				    ['height', ['height']],
				    ['insert',['link','hr']],
				  ],
				fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
				fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
			,
			});	
		
		// Example starter JavaScript for disabling form submissions if there are invalid fields
		(() => {
		  'use strict'

		  // Fetch all the forms we want to apply custom Bootstrap validation styles to
		  const forms = document.querySelectorAll('.needs-validation')

		  // Loop over them and prevent submission
		  Array.from(forms).forEach(form => {
		    form.addEventListener('submit', event => {
		      if (!form.checkValidity()) {
		        event.preventDefault()
		        event.stopPropagation()
		      }

		      form.classList.add('was-validated')
		    }, false)
		  })
		})()
	</script>
</body>
</html>