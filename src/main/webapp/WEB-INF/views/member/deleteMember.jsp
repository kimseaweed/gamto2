<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	.pd{
		padding:5px;
		position: absolute;
		right: 40px;
	}
	.c-p-t{
		margin-top:100px;
	}
	.t-bd{
		border-top: 1px solid gray;
		padding-top:30px;
	}
	.bd{
		border:1px solid black;
		padding:20px 20px 100px 20px;
		
	}
</style>
<title>감토 | 회원탈퇴 </title>
</head>
<body>
	<jsp:include page="../header.jsp" />
	<main class="main">
			<div class="container-fluid">
                <div class="row">
                    <jsp:include page="../myPageSideBar.jsp"/>
                    <div class="col-4">
                    	<div class="bd c-p-t">
                    		<form action="delete">
							<h4>정말로 탈퇴하시겠습니까?</h4>
							<label class="col-sm-12 t-bd">삭제할 아이디</label> 
							<input type="text" class="form-control col-md-12" name="u_id" />
							<label class="col-sm-12">삭제할 비밀번호</label> 
							<input type="text" class="form-control col-md-12" name="u_pw" />
							<input type="submit" class="pd" value="확인" />
						</form>
                    	</div>
                    </div>
                </div><!-- row -->
            </div><!-- container-fluid -->
	</main>
	<jsp:include page="../footer.jsp" />
</body>
</html>