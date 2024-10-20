<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>감토 | 로그인</title>
<link href="/css/member.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../header.jsp" />

	<main class="loginform container animate__animated animate__fadeIn">
		<div class="col-md-11 my-5 py-5 mx-md-auto">
			<div class="login-box bg-white pl-lg-5 pl-0">
				<div class="row no-gutters align-items-center">
					<div class="col-md-6">
						<div class="form-wrap bg-body shadow ms-xl-5">
							<h2 class="btm-sep pb-3 fw-bold">로그인</h2>
							<form class="form" method="post"
								action="/member/processLoginMember">
								<input type="hidden" name=connect value="${connect}">
								<div class="row">
									<div class="col-12 py-3">
										<div class="form-group position-relative ">
											<span class="zmdi zmdi-account m-auto"> <i
												class="bi bi-person-fill"></i>
											</span> <input type="text" name="u_id" id="u_id"
												class="form-control form-control-lg" placeholder="ID">
										</div>
									</div>
									<div class="col-12 pb-3">
										<div class="form-group position-relative">
											<span class="zmdi zmdi-email m-auto"> <i
												class="bi bi-key-fill"></i>
											</span> <input type="password" id="u_pw" name="u_pw"
												class="form-control form-control-lg" placeholder="Password">
										</div>
									</div>
									<div class="col-12 text-lg-right">
										<a href="/member/help/id">아이디 찾기</a> | <a
											href="/member/help/pw">비밀번호 찾기</a>
									</div>
									<div class="col-12 mt-3 text-end">
										<button type="submit" id="submit" class="btn btn-lg">로그인
										</button>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="col-md-6">
						<div class="content text-center">
							<div class="border-bottom pt-5 pb-5 mb-5">
								<h3 class="c-black">
									<span class="fs-1 fw-bold">감토</span>가 처음이신가요?
								</h3>
								<a href="addMember"
									class="btn btn-custom link2 link2-purple link"> <i
									class="bi bi-arrow-right-short"></i> 회원가입 하러가기
								</a>
							</div>
							<h5 class="c-black mb-4 mt-n1"></h5>
							<div class="socials pe-3">
							<% if(request.getParameter("error")!=null){
								int error=Integer.parseInt(request.getParameter("error")); 
								if(error==0){
									out.println("<div class='alert alert-danger'> 로그인이 필요한 서비스입니다. </div>");
								}else if(error==1){
									out.println("<div class='alert alert-danger'> 아이디와 비밀번호를 입력해주세요 </div>");
								}else if(error==2){
									out.println("<div class='alert alert-danger'> 아이디와 비밀번호를 확인해주세요 </div>");
								}else if(error==3){
									out.println("<div class='alert alert-danger'> 탈퇴한 회원입니다</div>");
								}else if(error==4){
									out.println("<div class='alert alert-danger'> 정지된 회원입니다</div>");
								}
							}
							%>
								<c:if test="${not empty error}">
									<div class='alert alert-danger'>
										<c:choose>
											<c:when test="${error eq 0}">로그인이 필요한 서비스입니다. </c:when>
											<c:when test="${error eq 1}"> 아이디와 비밀번호를 입력해주세요 </c:when>
											<c:when test="${error eq 2}"> 아이디와 비밀번호를 확인해주세요</c:when>
											<c:when test="${error eq 3}"> 탈퇴한 회원입니다 </c:when>
											<c:when test="${error eq 4}"> 정지된 회원입니다 </c:when>
											<c:otherwise> ${error} </c:otherwise>
										</c:choose>
									</div>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<jsp:include page="../footer.jsp" />
</body>
</html>