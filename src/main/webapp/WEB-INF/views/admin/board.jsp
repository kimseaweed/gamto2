<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.mrmr.gamto.member.dto.MyBoardDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>관리자 페이지 | 게시판 관리</title>
<style>
</style>
</head>
<body>
<div class="d-none">
	<jsp:include page="../header.jsp" />
</div>
	<main class="mx-auto p-3 mt-2">
		<div class="bg-light mb-5 px-2 py-xl-5 py-0">
			<div class="col-auto row pt-3">
				<jsp:include page="adminPageSideBar.jsp" />
				<div class=" container col pt-lg-3">

					<form id="boardOption" action="/admin/board/${onePageNo}/${pageNo}"
						method="get">
						<select id="changePageNo" name="changePageNo" class="form-select"
							onchange="viewPageNo()">
							<option value="20">20개씩 보기</option>
							<option value="50">50개씩 보기</option>
							<option value="70">70개씩 보기</option>
							<option value="100">100개씩 보기</option>
						</select>
					</form>
					<table class="table table-hover text-center mt-lg-2 mt-1">
						<thead>
							<tr class="text-bg-secondary ">
								<th scope="col" width=15%>분류</th>
								<th scope="col" width=10%>번호</th>
								<th scope="col" width=30%>제목</th>
								<th scope="col" width=20%>수정날짜</th>
								<th scope="col" width=15%>상태</th>
								<th scope="col" width=10%>변경</th>
							</tr>
						</thead>
						<tbody class="table-group-divider">
						<% if(request.getAttribute("boardList")==null){ %>
								<tr>
									<td colspan="6">검색결과가 없습니다.</td>
								</tr>
						<%}else{ %>
							<c:forEach var="list" items="${boardList}">
							
										<c:choose>
											<c:when test="${list.tablename eq '너의생각'}">
												<tr>
												<td class="align-middle text-primary">${list.tablename}</td>
												<td class="align-middle">${list.seq_number}</td>
												<td class="align-middle"><a class="" href="/report/view?r_seq_number=${list.seq_number}"> ${list.title}</a></td>
												<td class="align-middle">${list.regist_day}</td>
												<td class="align-middle">
													<c:choose>
													    <c:when test="${list.deleted==0}">게시중</c:when>
													    <c:otherwise>삭제</c:otherwise>
													</c:choose>
												</td>
											</c:when>
											<c:otherwise>
											<tr>

											</tr>
												<td class="align-middle" style="color:purple;">${list.tablename}</td>
												<td class="align-middle">${list.seq_number}</td>
												<td class="align-middle"> <a class="" href="/board/view?f_seq_number=${list.seq_number}"> ${list.title} </a></td>
												<td class="align-middle">${list.regist_day}</td>
												<td class="align-middle">
													<c:choose>
														<c:when test="${list.deleted==0}">게시중</c:when>
														<c:otherwise>삭제</c:otherwise>
													</c:choose>
												</td>
											</c:otherwise>
										</c:choose>
									<td class="align-middle"><button onclick="deleteboard('${list.seq_number}','${list.tablename}')" class="btn btn-warning">삭제/복구</button> </td>
								</tr>
							</c:forEach>
						<% } %>
						</tbody>
					</table>
					<div>
						<nav class="py-5">
							<ul id="" class="pagination d-flex justify-content-center">
								<li id="" class=" page-item1 mx-3"><a
									class="page-link" href="/admin/board/${onePageNo}/1"
									aria-label="Previous"><span aria-hidden="true">맨앞</span></a></li>
								<li id="prev" class="d-none page-item1 mx-3"><a
									class="page-link" href="/admin/board/${onePageNo}/${pageNo-1}"
									aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>

								<li>
									<ul id="page" class="pagination d-flex justify-content-center">
										<li id="thispage" class="page-link page-item active">${pageNo}</li>
									</ul>
								</li>

								<li id="next" class="d-none page-item2 mx-4"><a
									class="page-link" href="/admin/board/${onePageNo}/${pageNo+1}"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
							<% if(request.getAttribute("boardList")!=null){							
								List<MyBoardDTO> list = (List<MyBoardDTO>)request.getAttribute("boardList");
								double total = list.get(0).getTotal();
								int maxpageno = (int)Math.ceil(total / Double.parseDouble((String)request.getAttribute("onePageNo"))) ;%>
								<li id="" class="page-item2 mx-3"><a
									class="page-link" href="/admin/board/${onePageNo}/<%=maxpageno %>"
									aria-label="Next"> <span aria-hidden="true">맨뒤</span></a></li>
									<% } %>
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</main>
	<script type="text/javascript">
	function deleteboard(seq_number,board){	
		if(board=="너의생각"){	
			$.ajax({
				url: "/admin/report/"+seq_number,
				type: "PUT",
			}).done(function(res) {
				if(res==1){
					alert('변경완료');
					$('table').load(location.href+' table>*')
				}else if(res==2){
					alert('권한이 없습니다');
				}else{
					alert('수정실패');
				}
			}).fail(function(res){
				alert('서버요청실패'+res);
			});
		}else{
			$.ajax({
				url: "/admin/freeboard/"+seq_number,
				type: "PUT",
			}).done(function(res) {
				if(res==1){
					alert('변경완료');
					$('table').load(location.href+' table>*')
				}else if(res==2){
					alert('권한이 없습니다');
				}else{
					alert('수정실패');
				}
			}).fail(function(res){
				alert('서버요청실패'+res);
			});
		}
	}
		//페이징처리
		const pageno = ${pageNo};
		const onpageno = ${onePageNo};
		const maxcontent = ${boardList[0].total};
		const maxpageno = Math.ceil(maxcontent / onpageno);

		$(document).ready(function() {

			console.log(
					"pageno : " + pageno +
					" / onpageno : " + onpageno +
					" / maxcontent : " + maxcontent +
					" / maxpageno : " + maxpageno
			)

			//이전,다음 버튼 표시여부
			if (pageno > 1) {  $('#prev').removeClass('d-none');  }
			if (pageno < maxpageno) { $('#next').removeClass('d-none');	}

			var j = 0;
			for (var i = 1; i <= 4; i++) {
				if ((pageno - i) > 0) {
					$('#page').prepend(
						'<li class="thispage page-item"><a class="page-link" ' +
						'href="/admin/board/'	+ onpageno + '/' + (pageno - i) + '">' + (pageno - i) + '</a></li>');
				} else {
					j++;
				}

				if ((pageno + i) <= maxpageno) {
					$('#page').append(
						'<li class="thispage page-item"><a class="page-link" '+
						' href="/admin/board/' + onpageno + '/' + (pageno + i) + '">'	+ (pageno + i) + '</a></li>');
				}

				if (i == 4 && j>0) {
					//console.log(j+'개를 더 만들어야해요.')
					for (var k = 1; k <= j; k++) {
						if ((pageno+i+j) <= maxpageno) {
							$('#page').append(
								'<li class="thispage page-item"><a class="page-link" '+
								' href="/admin/board/' + onpageno + '/' + (pageno + i + k) + '">' + (pageno + i + k) + '</a></li>');
							//console.log((pageno + i + k)+'번을 만들었어요')
						}
					}
				}
			}

			//n개씩 보기 설정된경우 자동선택
			$('#changePageNo option[value="' + onpageno + '"]').attr( 'selected', true);
		})//레디 end
		
		//n개씩 보기 반응
		function viewPageNo() {
			$('#boardOption').submit();
		}
	</script>
	<jsp:include page="../footer.jsp" />
</body>
</html>