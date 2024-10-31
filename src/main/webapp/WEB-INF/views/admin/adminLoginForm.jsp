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
<title>관리자 페이지 | 로그인</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
div.form-signin{
	max-width:500px;
	padding-top:200px;
	padding-bottom:200px;
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
<%  if(	session.getAttribute("admin_id")!=null){ %>
					<h1 class="text-center" style="margin-top:300px"><%=session.getAttribute("admin_id")%> 님, 안녕하세요  </h1>
<% }else{ %>
					<div class="form-signin m-auto">
						<form class="pe-5" method="post" action="/admin/login">
							<h1 class="h3 mb-3 fw-normal">로그인</h1>

							<div class="form-floating" >
								<input type="text" id="admin_id" name="admin_id" class="form-control"  autocomplete="off"> <label
									for="admin_id">아이디</label>
							</div>
							<div class="form-floating" >
								<input type="password" class="form-control"
									id="admin_pw" name="admin_password" autocomplete="off"> <label
									for="admin_pw">비밀번호</label>
							</div>

							<div class="checkbox mb-3" >
<%--								<label> <input type="checkbox" value="아이디 저장" id="checkId">--%>
<%--								 아이디 저장--%>
<%--								</label>--%>
							</div>
							<button class="w-100 btn btn-lg btn-primary" type="submit">Sign
								in</button>
						</form>
							<a href="/admin/new" class="text-end text-primary"> 새로 등록하기 </a>
					</div>
					<% }%>
				</div>
				<!--  -->
			</div>
		</div>
	</main>
<script>	
/* 	$(document).ready(function(){
		// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
	    var key = getCookie("admin_id");
	    $("#admin_id").val(key); 
	     
	    // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
	    if($("#admin_id").val() != ""){ 
	        $("#checkId").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	    }
	     
	    $("#checkId").change(function(){ // 체크박스에 변화가 있다면,
	        if($("#checkId").is(":checked")){ // ID 저장하기 체크했을 때,
	            setCookie("admin_id", $("#admin_id").val(), 7); // 7일 동안 쿠키 보관
	        }else{ // ID 저장하기 체크 해제 시,
	            deleteCookie("key");
	        }
	    });
	     
	    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
	    $("#admin_id").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
	        if($("#checkId").is(":checked")){ // ID 저장하기를 체크한 상태라면,
	            setCookie("admin_id", $("#admin_id").val(), 7); // 7일 동안 쿠키 보관
	        }
	    });

	// 쿠키 저장하기 
	// setCookie => saveid함수에서 넘겨준 시간이 현재시간과 비교해서 쿠키를 생성하고 지워주는 역할
	function setCookie(cookieName, value, exdays) {
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		var cookieValue = escape(value)
				+ ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
		document.cookie = cookieName + "=" + cookieValue;
	}

	// 쿠키 삭제
	function deleteCookie(cookieName) {
		var expireDate = new Date();
		expireDate.setDate(expireDate.getDate() - 1);
		document.cookie = cookieName + "= " + "; expires="
				+ expireDate.toGMTString();
	}
     
	// 쿠키 가져오기
	function getCookie(cookieName) {
		cookieName = cookieName + '=';
		var cookieData = document.cookie;
		var start = cookieData.indexOf(cookieName);
		var cookieValue = '';
		if (start != -1) { // 쿠키가 존재하면
			start += cookieName.length;
			var end = cookieData.indexOf(';', start);
			if (end == -1) // 쿠키 값의 마지막 위치 인덱스 번호 설정 
				end = cookieData.length;
			cookieValue = cookieData.substring(start, end);
		}
		return unescape(cookieValue);
	} */
</script>
	<jsp:include page="../footer.jsp" />
</body>
</html>