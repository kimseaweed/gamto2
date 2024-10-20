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
<title>관리자 페이지 | 관리자 등록</title>
<style>
div.form-signin {
	max-width: 500px;
	padding-top: 200px;
	padding-bottom: 200px;
}
</style>
</head>
<body>
	<div class="d-none">
		<jsp:include page="../header.jsp" />
	</div>
	<main class="mx-auto p-3 mt-2">
		<div class="bg-light mb-5 py-0">
			<div class="col-auto row pt-3 position-relative">
				<jsp:include page="adminPageSideBar.jsp" />
				<!--  -->
				<div class="container col pt-lg-3">
					<div class="form-signin m-auto">
					<h2> 관리자 등록 </h2>
						<form class="" method="post" action="/admin/new">
							<div class="row g-3" >
								<div class="col-sm-6">
									<label for="admin_id" class="form-label">아이디</label> <input
										type="text" class="form-control" id="admin_id" name="admin_id" placeholder="아이디">
								</div>

								<div class="col-sm-6" >
									<label for="admin_pw" class="form-label">비밀번호</label> <input
										type="password" class="form-control" id="admin_pw" name="admin_password" placeholder="비밀번호">
								</div>

								<div class="col-12" >
									<label for="admin_name" class="form-label">성함</label>
									<div class="input-group">
										<input type="text" class="form-control" id="admin_name" name="admin_name" placeholder="성함">
										</div>
								</div>

								<div class="col-12" >
									<label for="admin_number" class="form-label"> 사번 </label> 
									<input type="text"
										class="form-control" id="admin_number" name="admin_number" placeholder="사번">
									</div>

							<hr class="my-4">

							<button class="w-100 btn btn-primary btn-lg" type="submit">등록하기</button>
								</div>
						</form>
					</div>
				</div>
				<!--  -->
			</div>
		</div>
	</main>
	<jsp:include page="../footer.jsp" />
</body>
</html>