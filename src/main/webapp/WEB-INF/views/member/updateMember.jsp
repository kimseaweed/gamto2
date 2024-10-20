<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>감토 | 회원정보수정</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" />
	<%
		String u_id = (String)session.getAttribute("u_id");
	%>
<style>
	.c-p-t{
            padding-top: 100px;
        }
	.D0D3D8{
		background-color: #D0D3D8;
	}
	.l-bd{
		border-left:1px solid black;
	}
	.c-wid{
		width: 70px;
	}
	.c-wid-100{
		width: 100%;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
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
function checkEmail() { //도메인 자동 선택
	/* if (document.frm.emailList.value != "") {
		document.frm.email2.value = document.frm.emailList.value;
	} else {
		document.frm.email2.value = "";
		document.frm.email2.focus();
	} */
	if ($("#u_email3").val() != "") {
		document.querySelector("#mail2").value = document.querySelector("#u_email3").value
	} else {
		document.querySelector("#mail2").value = ""
			document.querySelector("#u_email2").focus();
	}
}
</script>
</head>

<body onload="init()">
	<c:set var="row" value="${rows}" />
	<c:set var="mail" value="${row.u_email}" />
	<c:set var="mail1" value="${mail.split('@')[0]}" />
	<c:set var="mail2" value="${mail.split('@')[1]}" />
	<jsp:include page="../header.jsp" />
	<main class="main">
			<div class="container-fluid">
                <div class="row">
                    <jsp:include page="../myPageSideBar.jsp"/>
                    <div class="col-md-8 c-p-t">
					<div class="container">
						<div class="row l-bd">
							<div class="col-12 c-wid-100">
								<form action="processUpdateMember" method="post" name="newMember">
									<div class="row g-3 align-items-center">
									  <div class="col-auto">
									  <label class="c-wid">아이디</label>
									  </div>
									  <div class="col-auto">
									  	<input type="text" name="u_id" placeholder="id" class="form-control" readonly aria-describedby="passwordHelpInline" value="<c:out value='${row.u_id}'/>">
									  </div>
									</div><!-- row -->
									<div class="row g-3 align-items-center">
									  <div class="col-auto">
									  <label class="c-wid">비밀번호</label>
									  </div>
									  <div class="col-auto">
<%--										  <c:out value='${row.u_pw}'/>--%>
									  	<input type="password" name="u_pw" placeholder="password" class="form-control" aria-describedby="passwordHelpInline" value="">
									  </div>
									</div>
									<div class="row g-3 align-items-center">
									  <div class="col-auto">
									  <label for="inputPassword6" class="c-wid">이름</label>
									  </div>
									  <div class="col-auto">
									  	<input type="text" name="u_name" placeholder="name" class="form-control" aria-describedby="passwordHelpInline" value="<c:out value='${row.u_name}'/>">
									  </div>
									</div><!-- row -->
									<div class="row g-3 align-items-center">
										<div class="col-auto">
											<label class="c-wid">이메일</label>
										</div>
										<div class="col-auto">
											<input type="text" id="mail1" name="mail1" class="form-control" value="${mail1}">
										</div>@
										<div class="col-auto">
											<input type="text" name="mail2" id="mail2" class="form-control" value="${mail2}"> 
										</div>
										<div class="col-auto">
											<select id="u_email3" size='1' onchange="return checkEmail()">
													<option value="">직접입력</option>
													<option value="naver.com">naver.com</option>
													<option value="daum.net">daum.net</option>
													<option value="gmail.com">gmail.com</option>
													<option value="nate.com">nate.com</option>
											</select>
										</div>
										<div id="warningMessage" style="color: red;"></div>
									</div><!-- row -->
									<div class="g-3 align-items-center row">
										<div class="col-auto">
											<label class="c-wid">연락처</label>
										</div>
										<div class="col-auto">
											<input type="text" class="form-control" name="u_phone" placeholder="phone" value="<c:out value='${row.u_phone}'/>">
										</div>
									</div>
									<div class="g-3 align-items-center row">
										<div class="col-auto">
											<label class="c-wid">주소</label>
										</div>
										<div class="col-auto">
											<input type="text" class="form-control" id="u_address" name="u_address" placeholder="주소" value="<c:out value='${row.u_address}'/>">
										</div>
										
										<div class="col-auto">
											<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색" class="btn btn-secondary">
										</div>
										
									</div>
									<input type="hidden" name="u_delete"
										value="<c:out value='${row.u_delete}'/>">	
									<input class="btn btn-outline-secondary mx-2" type="submit" value="회원수정" />
								</form>
							</div>
						</div>
					</div>
				</div><!-- col-md-8 -->
                </div><!-- row -->
            </div><!-- container-fluid -->
	</main>
	<jsp:include page="../footer.jsp" />
	<script>
		function init() {

			setComboMailValue("${mail2}");

		}

		function setComboMailValue(val) {
			var selectMail = document.getElementById('mail2');
			for (i = 0, j = selectMail.length; i < j; i++) {
				if (selectMail.options[i].value == val) {
					selectMail.options[i].selected = true;
					break;
				}
			}
		}
		function checkForm() {
			if (!document.newMember.u_id.value) {
				alert("아이디를 입력하세요.");
				return false;
			}
			if (!document.newMember.u_pw.value) {
				alert("비밀번호를 입력하세요.");
				return false;
			}
		}
	</script>
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
</script>
</body>
</html>