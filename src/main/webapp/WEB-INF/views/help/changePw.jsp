<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>감토 | 비밀번호 찾기</title>
<style>
main{
padding:200px;
}
main>div {
	max-width: 600px !important;
	margint-top:500px;
	margin-left:auto;
	margin-right:auto;
}
form{
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" />

	<main class="container-md ">
	<div class="bg-light rounded shadow-sm p-5">
		<form action="/member/help/pw/token" method="post" class="m-3"
			id="form">
			<input type="hidden" value="${u_id}" name="u_id" />

			
			<div class="mb-3 row nput-group input-group-lg">
				<label for="staticEmail" class="col col-form-label w-100">이메일</label>
				<div class="col">
					<input type="text" value="${u_id}" disabled="disabled" class="ms-auto form-control" />
				</div>
			</div>
			
			<div class="mb-3 row nput-group input-group-lg">
				<label for="inputPassword" class="col-sm-6 col-form-label">변경할
					비밀번호</label>
				<div class="col-sm-6">
					<input type="password" name="u_pw" autocomplete="off" class="ms-auto form-control"/>
				</div>
			</div>




		
<div class="row">
							<input class="btn btn-primary" type="submit"
				value="비밀번호 변경하기">
</div>
		</form>
		<script src="/js/memberHelp.js"></script>
</div>
	</main>
	<jsp:include page="../footer.jsp" />
</body>
</html>