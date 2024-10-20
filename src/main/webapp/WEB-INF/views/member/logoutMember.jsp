<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 17-10)세션 무효화하고 로그인 페이지로 보냄=>updateMember.jsp로 이동 -->
    <%
    	session.invalidate();
    	response.sendRedirect("login");
    %>