// 이메일

// 유효성체크





    $("#u_email1").on("input", function () {
    var inputText = $(this).val();

    // 대문자 확인 정규식
    var uppercasePattern = /^[A-Z]*$/;

    if (uppercasePattern.test(inputText)) {
    $("#warningMessage").text("대문자는 입력이 불가능합니다.");
} else {
    $("#warningMessage").text("");
}
})

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