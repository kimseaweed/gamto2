<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>--%>
<%--<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>감토 | 회원가입</title>


    <script>
        $(document).ready(function () {
            $("#u_email1").on("input", function () {
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

        function checkForm() {
            if (!document.newMember.u_id.value) {
                alert("아이디를 입력하세요");
                return;
            }
            if (!document.newMember.u_pw.value) {
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
    <%--<style>--%>
    <%--	.c-bd{--%>
    <%--		border:1px solid gray;--%>
    <%--		padding:30px;--%>
    <%--	}--%>
    <%--	.logobox a>span, .offcanvas-title{--%>
    <%--	font-family: "Yeongdo-Rg";--%>
    <%--}--%>
    <%--header > nav >ul>li>a{--%>
    <%--	font-family: "116angmuburi";--%>
    <%--	font-size: 2rem;--%>
    <%--	font-weight: bold;--%>
    <%--	letter-spacing: 3px;--%>
    <%--	word-spacing: -6px;--%>
    <%--}--%>
    <%--.logobox .img{--%>
    <%--	width:50px;--%>
    <%--	height: 86.5px;--%>
    <%--	background-repeat: no-repeat;--%>
    <%--	background-image: url("../img/logo/logo1.png");--%>
    <%--	background-size: contain;--%>
    <%--}--%>
    <%--/* header{--%>
    <%--	width: 100%;--%>
    <%--} */--%>
    <%--</style>--%>
</head>
<body>
<jsp:include page="../header.jsp"/>

<main class="container-md bg-light px-5 pt-5 rounded shadow-sm" style="margin-top: 200px;">
    <div class="px-5 mx-5 pt-5">
        <h3>회원가입</h3>
        <p>감토회원이 되어 감상토론을 나눠보세요.</p>
        <div>
            <h5>로그인 정보</h5>
            <form action="newMember" method="post" name="newMember">
                <div class="col-12">
                    <label for="u_id" class="form-label">아이디</label>
                    <div class="input-group has-validation">
                        <input type="text" class="form-control" id="u_id" name="u_id" placeholder="아이디" required="">
                        <div class="invalid-feedback">
                            아이디를 입력해주세요.
                        </div>
                    </div>
                </div>
                <div class="d-flex">
                    <div class="col-6 pe-3">
                        <label for="u_pw" class="form-label">비밀번호</label>
                        <div class="input-group has-validation">
                            <input type="password" class="form-control" id="u_pw" name="u_pw" placeholder="비밀번호"
                                   required="">
                            <div class="invalid-feedback">
                                비밀번호를 입력해주세요.
                            </div>
                        </div>
                    </div>
                    <div class="col-6">
                        <label for="u_pw" class="form-label">비밀번호 확인</label>
                        <div class="input-group has-validation">
                            <input type="password" class="form-control" placeholder="비밀번호 확인" required="">
                            <div class="invalid-feedback">
                                비밀번호를 입력해주세요.
                            </div>
                        </div>
                    </div>
                </div>

                <h5>회원 정보</h5>
                <div class="col-12">
                    <label for="name" class="form-label">이름(닉네임)</label>
                    <div class="input-group has-validation">
                        <input type="text" class="form-control" id="name" name="u_name" placeholder="이름(닉네임)"
                               required="">
                        <div class="invalid-feedback">
                            이름(닉네임)를 입력해주세요.
                        </div>
                    </div>
                </div>

                <div class="">
                    <label for="email" class="form-label">이메일</label>
                    <div class="row">
                        <div class="input-group has-validation pe-3 col">
                            <input type="email" class="form-control" id="email" name="u_mail1" placeholder="이메일"
                                   required="">
                            <div class="invalid-feedback">
                                이메일을 입력해주세요.
                            </div>
                        </div>
                        <div class="input-group col">
                            <span class="input-group-text">@</span>
                            <input type="text" class="form-control" id="email2" placeholder="example.com" required="">
                            <div class="invalid-feedback">
                                메일주소를 선택해주세요.
                            </div>
                        </div>
                        <div class="input-group col">
                            <select class="form-select" id="email3" required="">
                                <option value="">메일주소선택</option>
                                <option>직접입력</option>
                                <option>gmail.com</option>
                                <option>naver.com</option>
                                <option>daum.net</option>
                            </select>
                            <div class="invalid-feedback">
                                메일주소를 선택해주세요.
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12">
                    <label for="name" class="form-label">연락처</label>
                    <div class="input-group has-validation">
                        <input type="text" class="form-control" id="phone" name="u_phone" placeholder="연락처"
                               required="">
                        <div class="invalid-feedback">
                            연락처를 입력해주세요.
                        </div>
                    </div>
                </div>

                <div class="col-12">
                    <label for="name" class="form-label">주소</label>
                    <div class="input-group has-validation">
                        <input type="text" class="form-control" id="name" name="u_name" placeholder="이름(닉네임)"
                               required="">
                        <div class="invalid-feedback">
                            주소를 입력해주세요.
                        </div>
                    </div>
                </div>
                <div>

                </div>
                <input type="button" onclick="checkForm()">

            </form>
        </div>
    </div>
</main>

<%--<div class="container mt-2">--%>
<%--    <div class="row">--%>
<%--        <div class="col-md-2"></div>--%>
<%--        <div class="logobox pb-2">--%>
<%--            <a href="/" class="text-decoration-none d-flex align-items-end">--%>
<%--                <div class="img"></div>--%>
<%--                <span class="ms-3 link-dark display-5 mb-2"></span>--%>
<%--            </a>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <div class="row">--%>
<%--        <div class="col-md-2"></div>--%>
<%--        <div class="col-md-8 c-bd">--%>
<%--            <form action="newMember" method="post" name="newMember">--%>
<%--                <div class="form-group row">--%>
<%--                    <div class="col-sm-1"></div>--%>
<%--                    <label class="col-sm-3">회원 아이디</label>--%>
<%--                    <input type="text" class="form-control col-sm-7" name="u_id" placeholder="id">--%>
<%--                </div>--%>
<%--                <div class="form-group row">--%>
<%--                    <div class="col-sm-1"></div>--%>
<%--                    <label class="col-sm-3">회원 비밀번호</label>--%>
<%--                    <input type="text" class="form-control col-sm-7" name="u_pw" placeholder="password">--%>
<%--                </div>--%>
<%--                <div class="form-group row">--%>
<%--                    <div class="col-sm-1"></div>--%>
<%--                    <label class="col-sm-3">회원 이름</label>--%>
<%--                    <input type="text" class="form-control col-sm-7" name="u_name" placeholder="name">--%>
<%--                </div>--%>
<%--                <div class="form-group row">--%>
<%--                    <div class="col-sm-1"></div>--%>
<%--                    <label class="col-sm-3 ">이메일</label>--%>
<%--                    <input type="text" class="form-control col-sm-3 mr-3 smallletter" id="u_email1" name="u_email1"--%>
<%--                           maxleng="50">@--%>
<%--                    <input type="text" name="u_email2" id="u_email2" class="form-control col-sm-2">--%>
<%--                    <select id="u_email3" size='1' onchange="return checkEmail()">--%>
<%--                        <option value="">직접 입력</option>--%>
<%--                        <option value="naver.com">naver.com</option>--%>
<%--                        <option value="daum.net">daum.net</option>--%>
<%--                        <option value="gmail.com">gmail.com</option>--%>
<%--                        <option value="nate.com">nate.com</option>--%>
<%--                    </select>--%>
<%--                    <div id="warningMessage" style="color: red;"></div>--%>
<%--                </div>--%>
<%--                <div class="form-group row">--%>
<%--                    <div class="col-sm-1"></div>--%>
<%--                    <label class="col-sm-3">연락처</label> <input type="text"--%>
<%--                                                               class="form-control col-sm-7" name="u_phone"--%>
<%--                                                               placeholder="phone">--%>
<%--                </div>--%>
<%--                <div class="form-group row">--%>
<%--                    <div class="col-sm-1"></div>--%>
<%--                    <label class="col-sm-3">주소</label>--%>
<%--                    <input type="text" class="form-control col-sm-5" id="u_address" name="u_address" placeholder="주소">--%>
<%--                    <input type="button" class="col-sm-2 text-center" onclick="sample5_execDaumPostcode()"--%>
<%--                           value="주소 검색"><br>--%>
<%--                </div>--%>
<%--                <div class="form-group row">--%>
<%--                    <input type="hidden" value="0" name="u_delete">--%>
<%--                </div>--%>
<%--                <div class="form-group row">--%>
<%--                    <div class="col-sm-1"></div>--%>
<%--                    <input class="col-sm-10 btn btn-secondary" type="button" onclick="checkForm()" value="회원가입"/>--%>
<%--                </div>--%>
<%--            </form>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div><!-- container -->--%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
            oncomplete: function (data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("u_address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function (/* results, status */) {
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