<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>


<style>
@import url('https://fonts.googleapis.com/css?family=Open+Sans');
        .text2-5vw{
            font-size: 2.5vw;
        }
        .text-1vw{
            font-size: 1vw;
        }
        .c-text{
            font-size: 1.3em;
            padding: 15px;
        }
        .c-p{
            padding: 15px;
        }
        .c-lh{
            line-height: 80px;
        }
        .c-p-t5{
            padding-top:3%;
        }
        .c-h{
            height: 100%;
        }
        .c-m-20{
            margin-bottom: 10%;
        }
        .c-m-80{
            margin-bottom: 10%;
        }
        .c-p-t{
            padding-top: 100px;
        }
        .c-bo{
        	margin-bottom: 4px;
        }
        .D0D3D8{
        	background-color: #D0D3D8;
        }
        .E4E4E4{
        	background-color:#E4E4E4;
        }
        .c-w100{
        	width: 100%;
        }
        </style>
<meta charset="UTF-8">
<title>감토 | 마이페이지</title>
</head>
<body>
	<jsp:include page="../header.jsp" />
	<main class="main">
			<div class="container-fluid">
                <div class="row">
                    <jsp:include page="../myPageSideBar.jsp"/>
                    <div class="col-md-7 c-t-200 text-1vw c-p-t c-w100">
                        <div class="row c-bo">
                            <div class="col-4 D0D3D8">
                                <h1 class="c-lh c-m-20 text2-5vw">Gamto ID</h1>
                            </div>
                            <div class="col-6 c-p-t5 E4E4E4">
                                <span>${rows.u_id}</span>
                            </div>
                        </div>
                        <div class="row c-bo">
                            <div class="col-4 D0D3D8">
                                <h1 class="c-lh c-m-20 text2-5vw">Email<br></h1>
                            </div>
                            <div class="col-6 c-p-t5 E4E4E4">
                                <span>${rows.u_email}</span>
                            </div>
                        </div>
                        <div class="row c-bo">
                            <div class="col-4 D0D3D8">
                               <h1 class="c-lh c-m-20 text2-5vw">Phone<br></h1>
                            </div>
                            <div class="col-6 c-p-t5 E4E4E4">
                                <span>${rows.u_phone}</span>
                            </div>
                        </div>
                        <div class="row c-bo">
                            <div class="col-4 D0D3D8">
                               <h1 class="c-lh c-m-20 text2-5vw">Address<br></h1>
                            </div>
                            <div class="col-6 c-p-t5 E4E4E4">
                                <span>${rows.u_address}</span>
                            </div>
                        </div>
                    </div><!-- col-md-8 -->
                </div><!-- row -->
            </div><!-- container-fluid -->
	</main>
	<jsp:include page="../footer.jsp" />
</body>
</html>