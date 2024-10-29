
// 메일주소 뒷부분 자동채우기
function emailSelect(value){
    document.querySelector('#u_email2').value = value;
    if (value!==""){
        document.querySelector('#u_email2').setAttribute('readonly','readonly');
    }else {
        document.querySelector('#u_email2').removeAttribute('readonly');
    }
}

// 정규식
const u_idRegex = /^[a-z0-9]{4,20}$/;
const u_pwRegex = /^[a-zA-Z0-9]{4,20}$/;
const u_nameRegex = /^[\w가-힣]{2,6}$/;
const u_email1Regex = /^[\w-]{2,20}$/;
const u_email2Regex = /^([\w]{2,})+\.+[\w]{2,}$/;
const u_phoneRegex = /^[\d]{10,11}$/;
const u_address2Regex = /^[\w가-힣]{1,160}$/;


// 실시간 유효성검사
function validateInput(input) {
    const targetName = input.name;
    const targetValue = input.value;
    const validMassage = $(`span.validationMessage.${targetName}`);
    switch (targetName) {
        case 'u_id' :
            validMassage.text( u_idRegex.test(targetValue)? "" : "유효하지 않습니다(영소문자, 숫자 4~20자)" );
            break;
        case 'u_pw1' :
            validMassage.text( u_pwRegex.test(targetValue)? "" : "유효하지 않습니다. (영문자, 숫자 4~20자)" );
            break;
        case 'u_pw2' :
            validMassage.text(targetValue===$('#u_pw').val()? "" : "일치하지 않습니다" );
            break;
        case 'u_name' :
            validMassage.text( u_nameRegex.test(targetValue)? "" : "유효하지 않습니다. (영문자,한글,숫자 2~6자)" );
            break;
        case 'u_email1' :
            validMassage.text( u_email1Regex.test(targetValue)? "" : "유효하지 않습니다." );
            break;
        case 'u_email2' :
            validMassage.text( u_email2Regex.test(targetValue)? "" : "유효하지 않습니다." );
            break;
        case 'u_phone' :
            validMassage.text( u_phoneRegex.test(targetValue)? "" : "-를 제외하고 숫자만 입력해주세요." );
            break;
    }
}

// submit 유효성 검사
$("#newMember").on("submit", (event) => {
    event.preventDefault();

    try {
        const u_id = $("input[name='u_id']").val();
        const u_pw = $("input[name='u_pw']").val();
        const u_pw2 = $("#u_pw2").val();
        const u_name = $("input[name='u_name']").val();
        const u_email1 = $("input[name='u_email1']").val();
        const u_email2 = $("input[name='u_email2']").val();
        const u_phone = $("input[name='u_phone']").val();
        const u_address1 = $("input[name='u_address1']").val();
        const u_address2 = $("input[name='u_address2']").val();

        if (
            u_idRegex.test(u_id) &&
            u_pwRegex.test(u_pw) &&
            u_pw === u_pw2 &&
            u_nameRegex.test(u_name) &&
            u_email1Regex.test(u_email1) &&
            u_email2Regex.test(u_email2) &&
            u_phoneRegex.test(u_phone) &&
            u_address1 !== "" &&
            u_address2Regex.test(u_address2)
        ) {

            const u_email = `${u_email1}@${u_email2}`;
            const u_address = `${u_address1} ${u_address2}`;

            $("<input>", { type: "hidden", name: "u_email", value: u_email }).appendTo("#newMember");
            $("<input>", { type: "hidden", name: "u_address", value: u_address }).appendTo("#newMember");

            $("#newMember").off("submit").submit();
            return true;
        }
        alertR('유효하지 않은 입력이 있습니다.');
        return false;

    } catch (error) {
        console.error("에러발생 :", error);
        alertR("일시적인 오류가 발생했습니다. 다시 시도해 주세요.");
    }
});

function dupVailCheck(){
    $.ajax({
        type : 'get',
        url : '/member/api/dupVailCheck',
        dataType : text,

    })
}