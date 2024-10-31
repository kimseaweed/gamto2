<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.mrmr.gamto.freeboard.dto.CommentDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>관리자 페이지 | 댓글 관리</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
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

					<form id="commentOption" action="/admin/comment/${onePageNo}/${pageNo}"
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
								<th scope="col" width=10%>댓글번호</th>
								<th scope="col" width=15%>해당 게시물번호</th>
								<th scope="col" width=30%>내용</th>
								<th scope="col" width=15%>작성자</th>
								<th scope="col" width=10%>마지막 수정날짜</th>
								<th scope="col" width=10%>상태</th>
								<th scope="col" width=10%>삭제</th>
							</tr>
						</thead>
						<tbody class="table-group-divider">
						<% if(request.getAttribute("commentList")==null){ %>
								<tr>
									<td colspan="6">검색결과가 없습니다.</td>
								</tr>
						<%}else{ %>
							<c:forEach var="list" items="${commentList}">
								<tr>
									<td style="cursor: pointer"class="align-middle">${list.c_seq_number}</td>
									<td style="cursor: pointer"class="align-middle">${list.c_freeboard}</td>
									<td style="cursor: pointer"class="align-middle"><a class="" href="/board/view?f_seq_number=${list.c_freeboard}"> ${list.c_content} </a></td>
									<td style="cursor: pointer"class="align-middle">${list.c_writer}</td>
									<td style="cursor: pointer"class="align-middle">${list.c_update_day}</td>
									<td style="cursor: pointer"class="align-middle">
										<c:choose>
											<c:when test="${list.c_delete==0}">게시중</c:when>
											<c:otherwise>삭제</c:otherwise>
										</c:choose>
									</td>
									<td style="cursor: pointer"class="align-middle"><button class="btn btn-success" onclick="deletecomment('${list.c_seq_number}')">삭제/복구하기</button> </td>
								</tr>
							</c:forEach>
						<% } %>
						</tbody>
					</table>
					<div>
						<nav class="py-5">
							<ul id="" class="pagination d-flex justify-content-center">
									<li id="" class=" page-item1 mx-3"><a
									class="page-link" href="/admin/comment/${onePageNo}/1"
									aria-label="Previous"><span aria-hidden="true">맨앞</span></a></li>
								<li id="prev" class="d-none page-item1 mx-3"><a
									class="page-link" href="/admin/comment/${onePageNo}/${pageNo-1}"
									aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>

								<li>
									<ul id="page" class="pagination d-flex justify-content-center">
										<li id="thispage" class="page-link page-item active">${pageNo}</li>
									</ul>
								</li>

								<li id="next" class="d-none page-item2 mx-4"><a
									class="page-link" href="/admin/comment/${onePageNo}/${pageNo+1}"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
							<% if(request.getAttribute("commentList")!=null){							
								List<CommentDTO> list = (List<CommentDTO>)request.getAttribute("commentList");
								double total = list.get(0).getC_total_count();
								int maxpageno = (int)Math.ceil(total / Double.parseDouble((String)request.getAttribute("onePageNo"))) ;%>
								<li id="" class="page-item2 mx-3"><a
									class="page-link" href="/admin/comment/${onePageNo}/<%=maxpageno %>"
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
	function deletecomment(c_seq_number){
		$.ajax({
			url: "/admin/comment/"+c_seq_number,
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
	
	
		//페이징처리
		const pageno = ${pageNo};
		const onpageno = ${onePageNo};
		const maxcontent = ${commentList[0].c_total_count};
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
						'href="/admin/comment/'	+ onpageno + '/' + (pageno - i) + '">' + (pageno - i) + '</a></li>');
				} else {
					j++;
				}

				if ((pageno + i) <= maxpageno) {
					$('#page').append(
						'<li class="thispage page-item"><a class="page-link" '+
						' href="/admin/comment/' + onpageno + '/' + (pageno + i) + '">'	+ (pageno + i) + '</a></li>');
				}

				if (i == 4 && j>0) {
					//console.log(j+'개를 더 만들어야해요.')
					for (var k = 1; k <= j; k++) {
						if ((pageno+i+j) <= maxpageno) {
							$('#page').append(
								'<li class="thispage page-item"><a class="page-link" '+
								' href="/admin/comment/' + onpageno + '/' + (pageno + i + k) + '">' + (pageno + i + k) + '</a></li>');
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
			$('#commentOption').submit();
		}
	</script>
	<jsp:include page="../footer.jsp" />
</body>
</html>