<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.mrmr.gamto.member.dto.MemberDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>관리자 페이지 | 회원 관리</title>
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

					<form id="memberOption" action="/admin/member/${onePageNo}/${pageNo}"
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
								<th scope="col" width=20%>아이디</th>
								<th scope="col" width=20%>이름</th>
								<th scope="col" width=20%>메일</th>
								<th scope="col" width=20%>상태</th>
								<th scope="col" width=20%>변경</th>
							</tr>
						</thead>
						<tbody class="table-group-divider align-middle">
						<% if(request.getAttribute("memberList")==null){ %>
								<tr>
									<td colspan="6">검색결과가 없습니다.</td>
								</tr>
						<%}else{ %>
							<c:forEach var="list" items="${memberList}">
								<tr>
									<td class="">${list.u_id}</td>
									<td class="">${list.u_name}</td>
									<td class="">${list.u_email}</td>
									<td class="">${list.u_delete}</td>
							<td class="">
							<select class="form-select" id="${list.u_id}" onchange="updatemember('${list.u_id}')">
							<c:choose>
								<c:when test="${list.u_delete eq 0}">
									<option value="0"selected>(0)정상</option>
									<option value="1">(1)탈퇴</option>
									<option value="2">(2)정지</option>
								</c:when>
									<c:when test="${list.u_delete eq 1}">
									<option value="0">(0)정상</option>
									<option value="1"selected>(1)탈퇴</option>
									<option value="2">(2)정지</option>
								</c:when>
								<c:otherwise>
									<option value="0">(0)정상</option>
									<option value="1">(1)탈퇴</option>
									<option value="2" selected>(2)정지</option>
								</c:otherwise>
							</c:choose>
								</select>
							</c:forEach>
						<% } %>
						</tbody>
					</table>
					<div>
						<nav class="py-5">
							<ul id="" class="pagination d-flex justify-content-center">
									<li id="" class=" page-item1 mx-3"><a
									class="page-link" href="/admin/member/${onePageNo}/1"
									aria-label="Previous"><span aria-hidden="true">맨앞</span></a></li>
								<li id="prev" class="d-none page-item1 mx-3"><a
									class="page-link" href="/admin/member/${onePageNo}/${pageNo-1}"
									aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>

								<li>
									<ul id="page" class="pagination d-flex justify-content-center">
										<li id="thispage" class="page-link page-item active">${pageNo}</li>
									</ul>
								</li>

								<li id="next" class="d-none page-item2 mx-4"><a
									class="page-link" href="/admin/member/${onePageNo}/${pageNo+1}"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
							<% if(request.getAttribute("adminList")!=null){							
								List<MemberDTO> list = (List<MemberDTO>)request.getAttribute("memberList");
								double a_total = list.get(0).getU_total();
								int maxpageno = (int)Math.ceil(a_total / Double.parseDouble((String)request.getAttribute("onePageNo"))) ;%>
								<li id="" class="page-item2 mx-3"><a
									class="page-link" href="/admin/member/${onePageNo}/<%=maxpageno %>"
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
	
	//수정버튼 액션
	function updatemember(u_id){
		var role={"state" : document.getElementById(u_id).value, };
		$.ajax({
			url: "/admin/member/state/"+u_id,
			type: "PUT",
			data:JSON.stringify(role),
            contentType:'application/json;charset=UTF-8',
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
		const maxcontent = ${memberList[0].u_total};
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
						'href="/admin/member/'	+ onpageno + '/' + (pageno - i) + '">' + (pageno - i) + '</a></li>');
				} else {
					j++;
				}

				if ((pageno + i) <= maxpageno) {
					$('#page').append(
						'<li class="thispage page-item"><a class="page-link" '+
						' href="/admin/member/' + onpageno + '/' + (pageno + i) + '">'	+ (pageno + i) + '</a></li>');
				}

				if (i == 4 && j>0) {
					//console.log(j+'개를 더 만들어야해요.')
					for (var k = 1; k <= j; k++) {
						if ((pageno+i+j) <= maxpageno) {
							$('#page').append(
								'<li class="thispage page-item"><a class="page-link" '+
								' href="/admin/member/' + onpageno + '/' + (pageno + i + k) + '">' + (pageno + i + k) + '</a></li>');
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
			$('#memberOption').submit();
		}
	</script>
	<jsp:include page="../footer.jsp" />
</body>
</html>