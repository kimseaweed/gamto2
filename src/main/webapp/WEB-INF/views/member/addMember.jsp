<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>감토 | 회원가입</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<jsp:include page="../header.jsp"/>

<main class="container bg-light px-5 py-4 mb-5 rounded shadow-sm " style="margin-top:150px; max-width: 800px">
    <div class=" px-md-5 px-1 mx-md-5 py-5">

        <div>
           <div class="logobox d-flex justify-content-center">
               <div class="img2"></div>
               <span class="fs-1 ps-2 mt-auto mb-0" style="font-family:'Yeongdo-Rg';">감토</span>
           </div>
            <div class="pt-5 pb-4">
                <h3>회원가입</h3>
                <p class="">감토회원이 되어 감상토론을 나눠보세요.</p>
            </div>

            <form id="newMember" name="newMember" method="post" action="/member">
                <fieldset>
                    <legend>로그인 정보</legend>
                    <div class="pe-2 col-12 ">
                        <label for="u_id" class="form-label">아이디</label>
                        <div class="input-group has-validation">
                            <input type="text"
                                   class="form-control " id="u_id" name="u_id"
                                   placeholder="아이디" required="" autocomplete="off"
                                   oninput="validateInput(this)"
                                   style="border-top-right-radius: 0; border-bottom-right-radius: 0">
                            <button type="button" class="btn btn-primary" onclick="dupVailCheck('u_id', $('#u_id').val())">중복확인</button>
                        </div>
                            <span class="validationMessage u_id"></span>
                    </div>
                    <div class="pe-2 d-lg-flex ">
                        <div class="col-lg-6 col-12 pe-lg-3 pe-1">
                            <label for="u_pw" class="form-label">비밀번호</label>
                            <div class="input-group has-validation">
                                <input type="password"
                                       class="form-control" id="u_pw" name="u_pw"
                                       placeholder="비밀번호"
                                       required oninput="validateInput(this)">
                            </div>
                            <span class="validationMessage u_pw1"></span>
                        </div>
                        <div class="col-lg-6 col-12">
                            <label for="u_pw2" class="form-label">비밀번호 확인</label>
                            <div class="input-group has-validation">
                                <input type="password"
                                       id="u_pw2" name="u_pw2"
                                       class="form-control"
                                       placeholder="비밀번호 확인"
                                       required oninput="validateInput(this)">
                            </div>
                            <span class="validationMessage u_pw2"></span>
                        </div>
                    </div>
                </fieldset>

                <fieldset class="py-5">
                    <legend>회원 정보</legend>
                    <div class="col-12">
                        <label for="name" class="form-label">이름(닉네임)</label>
                        <div class="input-group has-validation">
                            <input type="text"
                                   class="form-control" id="name" name="u_name"
                                   placeholder="이름(닉네임)" required="" autocomplete="off" maxlength="6"
                                   oninput="validateInput(this)">
                        </div>
                        <span class="validationMessage u_name"></span>
                    </div>
                    <div class="">
                        <label for="u_email1" class="form-label">이메일</label>
                        <div class="row">
                            <div class="input-group px-2 col-md col-12 mb-md-0 mb-2">
                                <input type="text" class="form-control" id="u_email1" name="u_email1" placeholder="이메일"
                                       required maxlength="20" oninput="validateInput(this)">
                            </div>
                            <div class="input-group col px-md-0 pe-1">
                                <span class="input-group-text">@</span>
                                <input type="text" class="form-control rounded-end" id="u_email2" name="u_email2"
                                       placeholder="example.com"
                                       required maxlength="20" oninput="validateInput(this)">
                            </div>
                            <div class="input-group ps-1 col">
                                <select class="form-select form-control rounded-end" id="email3" onchange="emailSelect(this.value)">
                                    <option value="">직접입력</option>
                                    <option value="gmail.com" >gmail.com</option>
                                    <option value="naver.com" >naver.com</option>
                                    <option value="daum.net" >daum.net</option>
                                </select>
                            </div>
                        </div>
                            <span class="validationMessage u_email1 u_email2"></span>
                    </div>

                    <div class="col-12 ">
                        <label for="u_phone" class="form-label">연락처</label>
                        <div class="input-group has-validation">
                            <input type="text" class="form-control" id="u_phone" name="u_phone" placeholder="연락처"
                                   required maxlength="11" oninput="validateInput(this)">
                        </div>
                        <span class="validationMessage u_phone"></span>
                    </div>

                    <div class="col-12">
                        <label for="u_address1" class="form-label">주소</label>
                        <div class="input-group has-validation" >
                            <input type="text" class="form-control " id="u_address1" name="u_address1" placeholder="주소"
                                   required maxlength="166" onclick="daumPostcode()" readonly>
                            <input type="text" class="form-control rounded-start " id="u_address2" name="u_address2" placeholder="상세주소"
                                   required maxlength="166">
                        </div>

                        <!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
                        <div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
                            <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
                        </div>

                        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
                        <script>
                            // 우편번호 찾기 화면을 넣을 element
                            var element_layer = document.getElementById('layer');

                            function closeDaumPostcode() {
                                // iframe을 넣은 element를 안보이게 한다.
                                element_layer.style.display = 'none';
                            }

                            function daumPostcode() {
                                new daum.Postcode({
                                    oncomplete: function(data) {
                                        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                                            document.getElementById("u_address1").value = data.roadAddress;
                                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
                                            document.getElementById("u_address1").value = data.jibunAddress
                                        }

                                        // 커서를 상세주소 필드로 이동한다.
                                        document.getElementById("u_address2").focus();

                                        // iframe을 넣은 element를 안보이게 한다.
                                        // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                                        element_layer.style.display = 'none';
                                    },
                                    width : '100%',
                                    height : '100%',
                                    maxSuggestItems : 5
                                }).embed(element_layer);

                                // iframe을 넣은 element를 보이게 한다.
                                element_layer.style.display = 'block';

                                // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
                                initLayerPosition();
                            }

                            // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
                            // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
                            // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
                            function initLayerPosition(){

                                if ( document.documentElement.clientWidth > 500) {
                                    var width = 500;
                                } else {
                                    var width = 300;
                                }
                                //우편번호서비스가 들어갈 element의 width
                                var height = 500; //우편번호서비스가 들어갈 element의 height
                                var borderWidth = 2; //샘플에서 사용하는 border의 두께

                                // 위에서 선언한 값들을 실제 element에 넣는다.
                                element_layer.style.width = width + 'px';
                                element_layer.style.height = height + 'px';
                                element_layer.style.border = borderWidth + 'px solid';
                                // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
                                element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
                                element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
                            }
                        </script>


                    </div>
                </fieldset>
                <input type="hidden" name="u_delete" value="0">
                <div class="pt-2 pb-4 d-md-flex justify-content-md-end d-grid">
                    <button class="btn btn-primary px-5 py-2" type="submit">가입하기</button>
                </div>

            </form>
        </div>
    </div>
</main>

<jsp:include page="../footer.jsp"/>

<script src="../js/member.js"></script>
</body>
</html>