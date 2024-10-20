<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>감토 | 회원가입</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(function(){
		alert("중복된 아이디이거나 중복된 이메일입니다.");
	})
	$(document).ready(function() {
	  $("#u_email1").on("input", function() {
	    var inputText = $(this).val();

	    // 대문자 확인 정규식
	    var uppercasePattern = /^[A-Z]*$/;

	    if (uppercasePattern.test(inputText)) {
	    	$("#warningMessage").text("대문자는 입력이 불가능합니다.");
	    } else {
	      $("#warningMessage").text("");
	    }
	  });
	});
	function checkForm(){
		if(!document.newMember.u_id.value){
			alert("아이디를 입력하세요");
				return;
		}
		if(!document.newMember.u_pw.value){
			alert("비밀번호를 입력하세요");
			return;
		}
		document.newMember.submit();
	}	
	function checkEmail() { //도메인 자동 선택
		/* if (document.frm.emailList.value != "") {
			document.frm.email2.value = document.frm.emailList.value;
		} else {
			document.frm.email2.value = "";
			document.frm.email2.focus();
		} */
		if ($("#u_email3").val() != "") {
			document.querySelector("#u_email2").value = document.querySelector("#u_email3").value
		} else {
			document.querySelector("#u_email2").value = ""
				document.querySelector("#u_email2").focus();
		}
	}
</script>
<style>
	.c-bd{
		border:1px solid gray;
		padding:30px;
	}
	.logobox a>span, .offcanvas-title{
	font-family: "Yeongdo-Rg";
}
header > nav >ul>li>a{
	font-family: "116angmuburi";
	font-size: 2rem;
	font-weight: bold;
	letter-spacing: 3px;
	word-spacing: -6px;
}
.logobox .img{
	width:50px;
	height: 86.5px;
	background-repeat: no-repeat;
	background-image: url("../img/logo/logo1.png");
	background-size: contain;
}
/* header{
	width: 100%;
} */
</style>
</head>
<body>
	<div class="container mt-2">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="logobox pb-2">
			<a href="/" class="text-decoration-none d-flex align-items-end">
				<div class="img"></div> <span class="ms-3 link-dark display-5 mb-2"></span>
			</a>
		</div>
		</div>
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8 c-bd">
				<form action="newMember" method="post" name="newMember">
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label class="col-sm-3">회원 아이디</label> 
						<input type="text" class="form-control col-sm-7" name="u_id" placeholder="id">
					</div>
					<div class="form-group row">
					<div class="col-sm-1"></div>
						<label class="col-sm-3">회원 비밀번호</label> 
						<input type="text"class="form-control col-sm-7" name="u_pw"placeholder="password">
					</div>
					<div class="form-group row">
					<div class="col-sm-1"></div>
						<label class="col-sm-3">회원 이름</label> 
						<input type="text" class="form-control col-sm-7" name="u_name" placeholder="name">
					</div>
					<div class="form-group row">
					<div class="col-sm-1"></div>
						<label class="col-sm-3 ">이메일</label> 
						<input type="text" class="form-control col-sm-3 mr-3 smallletter" id="u_email1" name="u_email1" maxleng="50">@
						<input type="text" name="u_email2" id="u_email2" class="form-control col-sm-2"> 
						<select id="u_email3" size='1' onchange="return checkEmail()">
							<option value="">직접 입력</option>
							<option value="naver.com">naver.com</option>
							<option value="daum.net">daum.net</option>
							<option value="gmail.com">gmail.com</option>
							<option value="nate.com">nate.com</option>
						</select> 
						<div id="warningMessage" style="color: red;"></div>
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label class="col-sm-3">연락처</label> <input type="text"
							class="form-control col-sm-7" name="u_phone" placeholder="phone">
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<label class="col-sm-3">주소</label> 
						<input type="text" class="form-control col-sm-5" id="u_address" name="u_address" placeholder="주소">
						<input type="button" class="col-sm-2 text-center" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
					</div>
					<div class="form-group row">
					<input type="hidden" value="0"name="u_delete">
					</div>
					<div class="form-group row">
						<div class="col-sm-1"></div>
						<input class="col-sm-10 btn btn-secondary" type="button" onclick="checkForm()" value="회원가입" /> 
					</div>
				</form>
			</div>
		</div>
	</div><!-- container -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=발급받은 API KEY를 사용하세요&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });


    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("u_address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }
    
    ${u_id}
</script>
</body>
</html>