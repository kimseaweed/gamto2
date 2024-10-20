<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board.jsp</title>

<style>
	.c-p-t{
    	padding-top: 100px;
    }
    .c-tt-ct{
    	position: relative;
    	left:40%;
    }
     .c-bd{
    	border-top: 1px solid black;
    	border-bottom: 1px solid black;
    	background-color: #D0D3D8;
    }
    .c-w100{
    	width: 100%;
    }
    .c-bd1{
    	border-bottom: 1px solid gray;
    }
</style>
</head>
<body>
	<jsp:include page="../header.jsp" />
	<main class="main">
		<div class="container-fluid">
                <div class="row">
                <jsp:include page="../myPageSideBar.jsp"/>
                <div class="col-md-7 c-p-t">
                    	<table class="table table-hover text-center mt-3">
							<thead>
								<tr class="c-bd">
									<th scope="col" col width=10%>생각</th>
									<th scope="col" col width=40%>제목</th>
									<th scope="col" col width=20%>날짜</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list}" var="dto">
									<c:set var="day" value="${dto.regist_day}" />
									<c:set var="regist_day" value="${day.split(' ')[0]}" />
									<tr>
										<td class="c-bd1">${dto.tablename}</td>
										<td class="c-bd1">
 									 	<c:choose>
											<c:when test="${dto.tablename eq '우리생각'}">
												<a href="/board/view?f_seq_number=${dto.seq_number}">
											${dto.title}</a>
											</c:when>
											<c:otherwise>
												<a href="/report/view?r_seq_number=${dto.seq_number}">
												
												${dto.title}
										 </a>
											</c:otherwise>
										</c:choose>
										<%-- <a href="/report/view?r_seq_number=${dto.seq_number}">
										${dto.title}
										</a> --%>
										
										</td>
										<td class="c-bd1"><c:out value="${regist_day}" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<br>
						<div class="container">
							<div class="row">
								<div class="col-10"></div>
								<div class="col-2"><a href="board/writeForm" class="col-ms-2">글작성</a></div>
							</div>
						</div>
						<div class="c-tt-ct mt-2">
							<a href="?pageNo=1">&lt;&lt;</a>
							<c:if test="${page.startNo eq 1}">
								<a href="?pageNo=1">&lt;</a>
							</c:if>
							<c:if test="${page.startNo ne 1}">
								<a href="?pageNo=${page.pageNo-1}">&lt;</a>
							</c:if>
							<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
								<a href="?pageNo=${i}">${i}</a>
							</c:forEach>
				
							<a href="?pageNo=${page.pageNo+1}">&gt;</a> <a
								href="?pageNo=${page.totalPage}">&gt;&gt;</a>
						</div>
                </div><!-- col-md-7 -->
            </div><!-- row -->
        </div><!-- container-fluid -->
	</main>
	<jsp:include page="../footer.jsp" />
</body>
</html>