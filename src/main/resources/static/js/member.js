function mailSelect(value){
    document.querySelector('#u_mail2').value = value;
    if (value!==""){
        document.querySelector('#u_mail2').setAttribute('readonly','readonly');
    }else {
        document.querySelector('#u_mail2').removeAttribute('readonly');
    }
}

const u_idRegex = /^[a-z0-9]{4,20}$/;
const u_pwRegex = /^[a-zA-Z0-9]{4,20}$/;
const u_nameRegex = /^[\w가-힣]{2,6}$/;
const u_mail1Regex = /^[\w-]{2,20}$/;
const u_mail2Regex = /^([\w]{2,})+\.+[\w]{2,}$/;
const u_phoneRegex = /^[\d]{10,11}$/;
const u_address2Regex = /^[\w가-힣]{1,160}$/;


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
            validMassage.text(targetValue===$('#u_pw1').val()? "" : "일치하지 않습니다" );
            break;
        case 'u_name' :
            validMassage.text( u_nameRegex.test(targetValue)? "" : "유효하지 않습니다. (영문자,한글,숫자 2~6자)" );
            break;
        case 'u_mail1' :
            validMassage.text( u_mail1Regex.test(targetValue)? "" : "유효하지 않습니다." );
            break;
        case 'u_mail2' :
            validMassage.text( u_mail2Regex.test(targetValue)? "" : "유효하지 않습니다." );
            break;
        case 'u_phone' :
            validMassage.text( u_phoneRegex.test(targetValue)? "" : "-를 제외하고 숫자만 입력해주세요." );
            break;
    }
}

$("#newMember").on('submit', (event) => {
    event.preventDefault();

    if (
        u_idRegex.test($("input[name='u_id']").val()) &&
        u_pwRegex.test($("input[name='u_pw']").val()) &&
        $('#u_pw1').val()===$('#u_pw2').val() &&
        u_nameRegex.test($("input[name='u_name']").val()) &&
        u_mail1Regex.test($("input[name='u_mail1']").val()) &&
        u_mail2Regex.test($("input[name='u_mail2']").val()) &&
        u_phoneRegex.test($("input[name='u_phone']").val()) &&
        $("input[name='u_adress1']").val() != "" &&
        u_address2Regex.test($("input[name='u_adress2']").val())
    ){
        $(this)
            .append(
                $("<input>")
                    .attr("name", "u_mail")
                    .val($("input[name='u_mail1']").val() + '@' + $("input[name='u_mail2']").val()
                    ).append(
                    $("<input>")
                        .attr("name", "u_address")
                        .val($("input[name='address1']").val() +' '+ $("input[name='u_address2']").val()) ));
        $("#newMember").submit();
    }else {
        alert("유효하지 않은 입력이 있습니다.");
        return false;
    }
    return false;
});

