<%@page import="java.net.http.HttpClient.Redirect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
<script type="text/javascript">
${alert}
</script>
	<div id="navdiv"class=" col-lg-2 col-12 p-3">
<% 
	String admin_id="";
	String admin_name="";
	String u_id="";
	int admin_role=100;
	
	if(session.getAttribute("admin_id")!=null){
		admin_id= (String) session.getAttribute("admin_id");
		admin_name = (String) session.getAttribute("admin_name");
		admin_role = ((Integer) session.getAttribute("admin_role")).intValue();
	}else{
		if( ( !request.getRequestURI().equals("/WEB-INF/views/admin/adminLoginForm.jsp") && !(request.getRequestURI().equals("/WEB-INF/views/admin/adminJoinForm.jsp")) ) ){			
			out.println("<script> alert('권한이 없습니다.'); location.href='/'; </script>");
		}
	}
%>
		<h1 class="navbar-expand-lg  text-center pt-3 pb-2">관리자<br>페이지<br>
			<% if(!admin_id.equals("")){ %>
			<span class="text-muted text-end fs-7"><%=admin_name %>님</span>		
			<%} %>	
		</h1>
		<nav class="">
			<ul class=" fs-4 d-flex d-lg-block ps-1 text-center">
			<% if(admin_id.equals("")){ %>			
			<li class="py-lg-4 flex-fill"> <a href="/admin/login">로그인</a> </li>
			<%}else{ %>
			<li class="py-lg-4 flex-fill"> <a href="/admin/logout">로그아웃</a> </li>
			<%} %>
			<li class="py-lg-4 flex-fill">
				회원 관리
					<ul>
						<li class="py-1 fs-5 flex-fill text-secondary "><a href="/admin/member">회원관리</a> </li>
					</ul>	
			</li>
			<li class="py-lg-4 flex-fill">
				클레임 관리
					<ul>
						<li class="py-1 fs-5 flex-fill text-secondary "><a href="/admin/ask">문의내역</a> </li>
						<li class="py-1 fs-5 flex-fill text-secondary "><a href="/admin/accuse">신고내역</a> </li>
					</ul>				
			</li>
			<li class="py-lg-4 flex-fill">
								게시판 관리
					<ul>
						<li class="py-1 fs-5 flex-fill text-secondary "><a href="/admin/board">게시물 관리</a> </li>
						<li class="py-1 fs-5 flex-fill text-secondary "><a href="/admin/comment">댓글 관리</a> </li>
					</ul>	
			</li>
			<li class="py-lg-4 flex-fill">
				상품 관리
					<ul>
						<li class="py-1 fs-5 flex-fill text-secondary "><a href="/admin/store">상품리스트</a> </li>
						<li class="py-1 fs-5 flex-fill text-secondary "><a href="/admin/store/new">상품등록</a> </li>
					</ul>	
			</li>
			
		<% 	if(admin_role<=1){ %>
			<li class="py-lg-4 flex-fill"><a href="/admin/admin-member"> 감토지기 관리 </a></li>
		<% } %>
			</ul>
		</nav>
	</div>

</body>
</html>