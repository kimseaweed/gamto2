<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.mrmr.gamto.help.dto.AskDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>관리자 페이지 | 문의 확인</title>
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

					<form id="askOption" action="/admin/ask/${onePageNo}/${pageNo}"
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
								<th scope="col" width=10%>번호</th>
								<th scope="col" width=25%>분류</th>
								<th scope="col" width=10%>파일</th>
								<th scope="col" width=15%>답변요청</th>
								<th scope="col" width=25%>날짜</th>
								<th scope="col" width=15%>진행</th>
							</tr>
						</thead>
						<tbody class="table-group-divider">
						<% if(request.getAttribute("askList")==null){ %>
								<tr>
									<td colspan="6">검색결과가 없습니다.</td>
								</tr>
						<%}else{ %>
							<c:forEach var="list" items="${askList}">
								<tr
									onclick="location.href='/admin/ask/view/${list.a_seq_number}'">
									<td class="">${list.a_seq_number}</td>
									<td class="">${list.a_category}</td>
									<td class=""><c:if test="${not empty list.a_filename}">
											<a href="/img/help/ask/${list.a_filename}" target="_blank">
												<i class="bi bi-paperclip"></i>
											</a>
										</c:if></td>
												<td class="">${list.a_reception}</td>
									
									<td class="">${list.a_date}</td>
									<td class=""><c:choose>
											<c:when test="${list.a_complete eq '완료'}">
												<span class="fw-bold  text-muted">${list.a_complete} </span>
											</c:when>
											<c:when test="${list.a_complete eq '신규'}">
												<span class="fw-bold text-danger">${list.a_complete}</span>
											</c:when>
											<c:when test="${list.a_complete eq '처리완료'}">
												<span class="fw-bold text-warning">${list.a_complete}</span>
											</c:when>
											<c:otherwise>${list.a_complete}</c:otherwise>
										</c:choose></td>
								</tr>
							</c:forEach>
						<% } %>
						</tbody>
					</table>
					<div>
						<nav class="py-5">
							<ul id="" class="pagination d-flex justify-content-center">
									<li id="" class=" page-item1 mx-3"><a
									class="page-link" href="/admin/ask/${onePageNo}/1"
									aria-label="Previous"><span aria-hidden="true">맨앞</span></a></li>
								<li id="prev" class="d-none page-item1 mx-3"><a
									class="page-link" href="/admin/ask/${onePageNo}/${pageNo-1}"
									aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>

								<li>
									<ul id="page" class="pagination d-flex justify-content-center">
										<li id="thispage" class="page-link page-item active">${pageNo}</li>
									</ul>
								</li>

								<li id="next" class="d-none page-item2 mx-4"><a
									class="page-link" href="/admin/ask/${onePageNo}/${pageNo+1}"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
							<% if(request.getAttribute("askList")!=null){							
								List<AskDTO> list = (List<AskDTO>)request.getAttribute("askList");
								double a_total = list.get(0).getA_total();
								int maxpageno = (int)Math.ceil(a_total / Double.parseDouble((String)request.getAttribute("onePageNo"))) ;%>
								<li id="" class="page-item2 mx-3"><a
									class="page-link" href="/admin/ask/${onePageNo}/<%=maxpageno %>"
									aria-label="Next"> <span aria-hidden="true">맨뒤</span></a></li>
									<% } %>
							</ul>
						</nav>

					</div>
				</div>
				<!-- col-md-7 -->
			</div>
			<!-- row -->
		</div>
	</main>
	<script type="text/javascript">
		//페이징처리
		const pageno = ${pageNo};
		const onpageno = ${onePageNo};
		const maxcontent = ${askList[0].a_total};
		const maxpageno = Math.ceil(maxcontent / onpageno);

		$(document).ready(function() {
			//이전,다음 버튼 표시여부
			if (pageno > 1) {  $('#prev').removeClass('d-none');  }
			if (pageno < maxpageno) { $('#next').removeClass('d-none');	}
			
			var j = 0;
			for (var i = 1; i <= 4; i++) {
				if ((pageno - i) > 0) {
					$('#page').prepend( 
						'<li class="thispage page-item"><a class="page-link" ' + 
						'href="/admin/ask/'	+ onpageno + '/' + (pageno - i) + '">' + (pageno - i) + '</a></li>');
				} else {
					j++;
				}

				if ((pageno + i) <= maxpageno) {
					$('#page').append(
						'<li class="thispage page-item"><a class="page-link" '+
						' href="/admin/ask/' + onpageno + '/' + (pageno + i) + '">'	+ (pageno + i) + '</a></li>');
				}

				if (i == 4 && j>0) {
					//console.log(j+'개를 더 만들어야해요.')
					for (var k = 1; k <= j; k++) {
						if ((pageno+i+j) <= maxpageno) {
							$('#page').append(
								'<li class="thispage page-item"><a class="page-link" '+
								' href="/admin/ask/' + onpageno + '/' + (pageno + i + k) + '">' + (pageno + i + k) + '</a></li>');
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
			$('#askOption').submit();
		}
	</script>
	<jsp:include page="../footer.jsp" />
</body>
</html>