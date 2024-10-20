<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>감토 | 신고 </title>
</head>
<body>
	<div>
		<div class="d-none">
			<jsp:include page="../header.jsp" />
		</div>
<% String uId= (String)session.getAttribute("u_id"); 
if(uId==null){out.println("<script> alert('로그인이 필요합니다.'); window.close() </script>"); } %>

		<form action="/member/help/accuse" method="post" class="p-5 pt-3"enctype="multipart/form-data" id="accuseForm">
			<h1 class="text-center py-3" >
				<i class="bi bi-patch-exclamation-fill"></i> 신고하기
			</h1>
<hr>
			<div class="row mb-1">
			<input type="hidden" name="ac_id" id="ac_id" value="<%=uId%>">
				<label for="ac_title" class="col-sm-3 col-form-label  col-form-label">
					신고할 유저 / 게시물
				</label>
				<div class="col-12">
					<input type="text" class="form-control mt-2" id="ac_target"
						name="ac_target" value="">
				</div>
			</div>

			<div class="pb-2">
				<label for="ac_category" class="col-form-label "> 유형 </label> <select
					class="form-select" id="ac_category" name="ac_category">
					<option selected>유형을 선택해주세요</option>
					<option value="불법정보 / 스팸홍보 / 도배글 신고">불법정보 / 스팸홍보 / 도배글 신고</option>
					<option value="유해한 주제 / 음란물 신고">유해한 주제 / 음란물 신고</option>
					<option value="욕설, 혐오, 차별적 등 불쾌한 표현">욕설, 혐오, 차별적 등 불쾌한 표현</option>
					<option value="개인정보 노출">개인정보 노출</option>
					<option value="저작권 침해">저작권 침해</option>
				</select>
			</div>

			<div class="mb-3">
				<label for="exampleFormControlTextarea1" class="form-label">신고내용</label>
				<textarea class="form-control" id="ac_content" name="ac_content"
					rows="4"></textarea>
			</div>

			<div class="mb-3">
				<label for="filename" class="form-label">파일,스크린샷 첨부</label> <input
					class="form-control form-control-sm" id="filename" name="filename" type="file">
			</div>


			<div class="row">
				<button type="button" id="accuseForm"
					class="py-2 px-4 my-2 mx-auto btn btn-warning text-end col-auto">신고
					전송</button>
			</div>
		</form>
<script type="text/javascript"	src="/js/memberHelp.js"></script>
		<div class="d-none">
			<jsp:include page="../footer.jsp" />
		</div>
	</div>
</body>
</html>