<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>감토 | </title>
<style>

main.result{
	min-height:65vh;
}
main.result>div{
	max-width:800px;
	max-height:500px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />

	<main class="result container p-md-5 p-3 position-relative">
		<div class="m-auto bg-light rounded shadow-sm text-center py-5 px-4  position-absolute top-50 start-50 translate-middle">
			<p class="fs-1 px-md-5 py-md-5 py-3"> ${script} ${message}<br></p><a href="/member/login" class="btn btn-warning mx-2">로그인하기</a><a href="/" class="mx-2 btn btn-primary">메인으로</a>
		</div>
	</main>
	
	<jsp:include page="footer.jsp" />
</body>
</html>