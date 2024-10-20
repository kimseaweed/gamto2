

//아이디인증 :  아이디이름 확인 ajax
$('.findid #submit').click(function() {
	$('#spinner').load(location.href + ' #spinner>div');
	if ($('#u_name').val() == "") {
		alertR('이름을 입력해주세요');
		return false;
	} else if ($('#u_email').val() == "") {
		alertR('이메일을 입력해주세요');
		return false;
	} else {
	$('#spinner').css('display', 'block');
		console.log('ajax1.메일발송 시작');
		$.ajax({
			url: "/member/help/id/check",
			dataType: 'json',
			type: "post",
			data: {
				"u_name": $('#u_name').val(),
				"u_email": $('#u_email').val()
			},
			success: function(result) {
				console.log('아이디인증: 성공0,이름불일치1,이메일불일치2 -> ' + result);
				setTimeout(function() {
					if (result == '2') {
						$('#spinner').html('존재하지않는 이메일입니다');
					} else if (result == '1') {
						$('#spinner').html('회원가입시 입력한 이름과 일치하지 않습니다');
					} else { //리턴0
						$('.sendmail').addClass('d-none');
						$('.checkCode').css('display', 'block');
					}
				}, 500);
			},
			error: function() {
				alert("서버 요청에 실패했습니다. 다시 시도해주세요");
				location = '/';
			}
		});
	}
})

//아이디인증 : 인증코드확인 ajax
$('.findid #authSummit').click(function() {
	$('#ceckCode').load(location.href + ' #ceckCode>span');
	$('#ceckCode').css('display', 'block');
	var input = parseInt($('#code').val());
	if (input == "") { return; }
	console.log('아이디인증 : ajax2.인증코드 확인시작');
	$.ajax({
		url: "/member/help/id/check",
		dataType: 'json',
		type: "get",
		data: {
			"code": input,
			"u_email": $('#u_email').val()
		},
		success: function(result) {
			console.log('아이디인증 : 성공0,불일치1,세션만료2:' + result);
			if (result == '0') {
				setTimeout(function() {
					var authSummit = document.getElementById("authSummit");
					var form = document.querySelector('form');
					form.action = "/member/help/id/res";
					form.method = "post";
					form.submit();
				}, 500);

			} else {
				setTimeout(function() {
					var message;
					if (result == '1') {
						message = '인증번호가 틀렸습니다.';
					} else {
						message = '세션이 만료되었거나 잘못된 접근입니다';
					}
					$('#ceckCode').html(message + '<br> 다시 진행해주세요');
					return;
				}, 500);
			}
		},
		error: function() {
			alert("서버 요청에 실패했습니다. 다시 시도해주세요");
			return;
		}
	});
})
//비밀번호 찾기 : 폼제출시 작업
$('.findpw #submit').click(function() {
	$('#spinner').load(location.href + ' #spinner>div');
	if ($('#u_id').val() == "") {
		alert('아이디를 입력해주세요');
		return false;
	} else if ($('#u_email').val() == "") {
		alert('이메일을 입력해주세요');
		return false;
	} else {
		$('#spinner').css('display', 'block');
		$.ajax({
			url: "/member/help/pw/check",
			dataType: 'json',
			type: "post",
			data: {
				"u_id": $('#u_id').val(),
				"u_email": $('#u_email').val()
			},
			success: function(result) {
				setTimeout(function() {
					if (result == '2') {
						$('#spinner').html('<p class="text-danger"> 존재하지않는 아이디입니다<p>');
						return false;
					} else if (result == '1') {
						$('#spinner').html('<p class="text-danger"> 가입시 입력한 이메일과<br>일치하지 않습니다 <p>');
						return false;
					} else {
						location = "/member/help/pw/send";
					}
				}, 500)
			},
			error: function() {
				alert("서버 요청에 실패했습니다.");
				location = '/';
			}
		});
	}
})


//ask 작동 및 유효성검사
function aEmail() {
	if ($('#a_email2').val() == "self") {
		$('#a_email3').removeClass('d-none');
		$('#a_email3').focus();
		$('#a_email2').addClass('d-none');
	}
}
function aEmail2() {
	$('#a_email3').addClass('d-none');
	$('#a_email2').removeClass('d-none');
}

$('#askForm button').click(function() {
	$('#a_email').val('');

	if ($('#askForm #a_id').val() == "" || $('#askForm #a_id').val() == "비회원") {
		if (!confirm('성함을 입력하지 않고 제출하시겠습니까?')) {
			return ;
		}
	}
	if ($('#askForm #a_id').val().length > 20) {
		alert('성함이 너무 깁니다');
		$('#askForm #a_id').focus();
		return ;
	} else if ($('#a_category').val() == "0") {
		alert('유형을 선택해주세요');
		return ;
	} else if ($('#a_content').val() == "") {
		alert('내용을 입력해주세요');
		$('#a_content').focus();
		return ;
	} else if ($('#a_content').val().length > 4000) {
		alert('내용이 너무 길어요');
		return ;
	}else if ($('#a_reception').val()=='y' || document.querySelector('#a_rec').checked ) {
		$('#a_reception').val('y');
		askEmailcheck()		
	}else{
		$('#a_reception').val('n');
		$('#askForm').submit();
	}
})
//이메일 검사
function askEmailcheck(){
		if ($('#a_email1').val() == "") {
			alert('이메일을 입력해주세요');
			$('#a_email1').focus();
			return ;
		} else if ($('#a_email1').val().search('@') > -1) {
			alert('"@"를 제외하고 입력해주세요.');
			return ;
		} else if ($('#a_email2').val() == "선택") {
			alert('이메일을 선택 해주세요');
			$('#a_email2').focus();
			return ;
		} else if ($('#a_email2').val() == "self") {
			if ($('#a_email3').val() == "") {
				alert('이메일을 입력 해주세요');
				$('#a_email3').focus();
				return ;
			} else if ($('#a_email3').val().search('@') > -1) {
				alert('"@"를 제외하고 입력해주세요.');
				$('#a_email3').focus();
				return ;
			}
		} 
		
		if ($('#a_email2').val() == 'self') {
			a_email.value = ($('#a_email1').val() + "@" + $('#a_email3').val());
		} else {
			a_email.value = ($('#a_email1').val() + "@" + $('#a_email2').val());
		}
		
		var pattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
		if(!pattern.test($('#a_email').val())){
			alert('이메일 주소를 확인해주세요');
			return;
		}else if ($('#a_email').val().length > 40) {
			alert('이메일이 너무 깁니다');
			return ;
		}
		$('#askForm').submit();
}
//파일명, 용량 유효성 검사
var fileinput = document.querySelector('input[type="file"]');
fileinput.addEventListener("input", function(){
		const maxSize = 1024*1024*5;
		 if(document.querySelector('input[type="file"]').files[0].size >= maxSize){
			alertY('5mb 이하 만 선택할 수 있습니다'); 
			fileinput.value = "";
			return;
		}else if(fileinput.value.length>300){
			fileinput.value = "";
			return
		}//if end
})//event end

//신고 유효성검사
$('#accuseForm button').click(function() {
	if(ac_target.value==""){
		alert('신고할 유저나 게시물을 입력해주세요');
		ac_target.focus();
		return;
	}else if(ac_category.value=="유형을 선택해주세요"){
		alert('유형을 선택해 주세요');
		ac_category.focus();
		return;
	}else if(ac_content.value==""){
		alert('신고내용을 입력해주세요');
		ac_content.focus();
		return;
	}
	$('#accuseForm').submit();	
})


