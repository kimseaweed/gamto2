<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>감토 | 너의 생각</title>
<style>
	.out{
		outline: none;
		border: none;
	}
</style>
<%
	String r_writer = (String)session.getAttribute("u_id");
%>
</head>
<body>
<jsp:include page="../header.jsp" />
	<main class="container pt-5">
	<script type="text/javascript">
	var deleted = '${dto.r_delete}';
	if(deleted==1){
		alert('삭제된 게시물입니다');
		history.back();
	}
	</script>
	<div>
		<div class="row">
			<p>제목 : ${dto.r_title}</p> <span class="col col-lg-6" style="float: left;">작성자 : ${dto.r_writer}</span>
			<input type="hidden" id="r_seq_number" value="${dto.r_seq_number}" />
			<p id="good" class="text-end col col-lg-6">
				<span>추천 수 : ${dto.r_recommend} &nbsp;| &nbsp;조회 수 : ${dto.r_view}</span>
			</p>
		</div>
	</div>
	<hr>
	<div style="padding-bottom:200px;">
	<p class="col mt-2">${dto.r_content}<br></p>
	</div>
	<hr>
	<div class="row">
	<p class="col mt-2">
		작성 날짜 : ${dto.r_regist_day} <br>
		수정 날짜 : ${dto.r_update_day} <br>
	</p>
	<p class="col ms-auto text-end me-5">
		<c:set var="userId" value="<%=r_writer%>" />
				<c:if test="${dto.r_writer==userId}">
					<input type="button" value="수정"
						class="btnUpdate btn btn-outline-success">
					<input type="button" value="삭제"
						class="btnDelete btn btn-outline-danger">
				</c:if>
				<c:set var="l_number" value="${dto.r_seq_number}"/>
           		<c:set var="l_board" value="2"/>
          	    <c:choose>
            		<c:when test="${myLike.likeCheck(l_board,l_number,userId) eq '1'}">
            			<c:set var="likeCheck" value="btn btn-warning"/>
            		</c:when>
            		<c:otherwise>
            			<c:set var="likeCheck" value="btn btn-outline-warning"/>
            		</c:otherwise>	
            	</c:choose>
            	<span id="goodBtn">
            		<i class="bi bi-hand-thumbs-up btnGood ${likeCheck}">추천</i>
            	</span>
	</p>
	<br>
	</div>
	<div class="pb-2">
		<a href="/report" class="btn btn-outline-primary">목록보기</a>
	</div>
	<br>	
	</main>
	<jsp:include page="../footer.jsp" />
<script>
	 $(document).ready(function(){ 
		var btnDelete = $(".btnDelete");
		$(".btnUpdate").click(function(){
			if(!confirm("수정하시겠습니까?")){
				return false;
			}else{
				$(location).attr('href','/report/updateForm?r_seq_number=${dto.r_seq_number}');
			}
		})
		btnDelete.click(function(){
			if(!confirm("삭제하시겠습니까?")){
				return false;
			}else{
				alertR("삭제되었습니다.");
				$(location).attr('href','/report/delete?r_seq_number=${dto.r_seq_number}');
			}
		})
		$(document).on('click','.btnGood',function (e) {
		var l_number = document.getElementById('r_seq_number').value;
		
			$.ajax({
				type:'POST',
				url:'/report/updateLike',
				dataType : 'json',
				data : {'l_number': l_number,
						},	
				success : function(result){
					if(result=="3"){
						alertR('로그인이 필요합니다.');
					}else if(result=="1"){
						alertY('추천 성공');
					}else{
						alertY('추천 취소');
					}
					$('#good').load(window.location.href+" #good>span");
					$('#goodBtn').load(window.location.href+" #goodBtn>i"); 
				},
			error : function(){
				alert('좋아요 실패');
			} 
		})
	}) 
	window.onload = function(){
         setTimeout(function(){
            scrollTo(0,0);
         },100);
      }
})
</script>
</body>
</html>
