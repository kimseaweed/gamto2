<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>감토 | 문의 </title>
</head>
<body>
	<div>
		<div class="d-none">
			<jsp:include page="../header.jsp" />
		</div>


		<form action="/member/help/ask" method="post" class="p-5 pt-3" name="askForm" id="askForm" enctype="multipart/form-data">
			<h1 class="text-center py-3">
			
			<%  String c = (String)request.getParameter("c");
				String uId =(String) session.getAttribute("u_id");
			
			if(c!=null&&c.equals("1")) { %>
			 <i class="bi bi-patch-question-fill"></i> 제휴문의
			<% }else{ %>
			 <i class="bi bi-patch-question-fill"></i> 문의하기
			<% } %>
			</h1>
<hr>
			<div class="row mb-2 pt-2">
				<div class="col-sm-12">
				
				<% if(c!=null&&c.equals("1")) { %>
				<label for="a_id" class="col-form-label ">
				문의하시는 곳 </label>
				<% }else{ %>
				<label for="a_id" class="col-form-label ">
				문의하시는 분				
				</label>
				<% } %>
					<%if(uId==null){%>
					<input type="text" class="form-control" id="a_id"
					name="a_id" value="비회원">
					<%}else{ %>
					<input type="text" class="form-control" id="a_id"
					name="a_id" value="<%=uId%>"readonly>
					<%} %>
				</div>
			</div>

			<div class="pb-2">
				<label for="a_category" class="col-form-label "> 유형 </label> 
				<select id="a_category" name="a_category"	class="form-select" >
				<% if(c!=null&&c.equals("1")) { %>
					<option value="제휴/광고 문의" selected>제휴/광고 문의</option>
					<option value="기타">기타</option>
				<% }else{ %>
					<option value="0"selected>유형을 선택해주세요</option>
					<option value="제휴/광고 문의">제휴/광고 문의</option>
					<option value="서비스 이용문의">서비스 이용문의</option>
					<option value="건의사항">건의사항</option>
					<option value="기타">기타</option>
				<% } %>
				</select>
			</div>

			<div class="mb-3">
				<label for="a_content" class="form-label">문의내용</label>
				<textarea class="form-control" name="a_content"id="a_content"
					rows="5"></textarea>
			</div>

			<div class="mb-3">
				<label for="filename" class="form-label">파일,스크린샷 첨부</label> <input
					class="form-control form-control-sm" id="filename" name="filename" type="file" >
			</div>
			<div class="row row-cols-lg-auto g-3 align-items-center" >

				
					<% if(c!=null&&c.equals("1")) { %>
					<div class="col-12 mt-1">
					<label class="form-check-label" for="a_email">	답변받으실 메일을 알려주세요 </label>
					<input id="a_reception" name="a_reception" type="hidden" value="y">
				</div>
				<% }else{ %>
				<div class="col-12 mt-4">
					<input class="form-check-input" type="checkbox"
						id="a_rec" name="a_rec" onclick="aRec()">
					<label class="form-check-label"	for="a_rec"> 메일로 답변을 받으시겠습니까? </label>
				<input id="a_reception" name="a_reception" type="hidden">
				</div>
				<%} %>
				<div class="col-6">
					<input type="text" class="form-control" id="a_email1"
						placeholder="email" autocomplete="none">
				</div>
				<div class="col-6">
					<div class="input-group">
						<div class="input-group-text" onclick="aEmail2()">@</div>
						<select class="form-control" id="a_email2" name="a_email2" size='1'
							onchange="aEmail()">
							<option>선택</option>
							<option value="self">직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="daum.net">daum.net</option>
							<option value="gmail.com">gmail.com</option>
							<option value="nate.com">nate.com</option>
						</select>
						<input type="text"  id="a_email3" name="a_email3" class="d-none form-control" autocomplete="none">
						<input type="hidden" id="a_email" name="a_email">
					</div>
				</div>
			</div>
			<div class="row">
				<button type="button"
					class="py-2 px-4 my-5 mx-auto btn btn-warning text-end col-auto">전송</button>
			</div>
		</form>
		<script type="text/javascript"	src="/js/memberHelp.js"></script>
		<div class="d-none">
			<jsp:include page="../footer.jsp" />
		</div>
	</div>
</body>
</html>