<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
<title>감토 | 주문내역</title>
<style>
	.c-p-t{
            padding-top: 100px;
        }
    .c-w100{
    	width: 100%;
    }
    th{
    	height: 100px;
    }
    td{
    	height: 60px;
    }
     .c-bd{
    	border-top: 1px solid black;
    	border-bottom: 1px solid black;
    	background-color: #D0D3D8;
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
                <div class="row ">
                    <jsp:include page="../myPageSideBar.jsp"/>
                    <div class="col-md-6 c-p-t text-center">
                        <table class="c-w100">
					 		<tr class="c-bd">
					 			<th>주문번호</th>
					 			<th>주문명</th>
					 			<th>주문주소</th>
					 			<th>가격</th>
					 		</tr>
					 		<c:forEach items="${purchaseList}" var="dto">
					 			<tr onclick="location='/kakaoPay/kakaoPaySuccess?o_order_number=${dto.o_order_number}'" style="cursor:pointer;">
					 				<td class="c-bd1 c-ht">${dto.o_order_number}</td>
					 				<td class="c-bd1">${dto.o_book_name}</td>
					 				<td class="c-bd1">${dto.o_address}</td>
					 				<td class="c-bd1">${dto.o_total}</td>
					 			</tr>
					 		</c:forEach>
					 	</table>
                    </div><!-- col-md-8 -->
                </div><!-- row -->
            </div><!-- container-fluid -->
	</main>
	<jsp:include page="../footer.jsp" />
</body>
</html>