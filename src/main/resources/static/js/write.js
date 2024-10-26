
//웹에디터 섬머노트 카드 1~4
var createcard1 = function(context) {
	var ui = $.summernote.ui;
	var card1 = '<div class="row py-3 px-3">' +
		'<div class="col-12 m-auto position-relative rounded shadow-lg" style="background-image: url(\'../img/write/card1.png\'); background-size: cover; width:270px; height:450px;">' +
		'<div class="fs-3 text-white position-absolute start-50 translate-middle" style="top:47%; writing-mode: vertical-lr;"><p  style="margin-bottom:0 !important">여기에 문장을 입력하세요<p></div>' +
		'<div class="fs-6 text-white-50 position-absolute w-100 text-center" style="bottom:10%;"><p style="margin-bottom:0 !important">책이름 | 저자</p></div>' +
		'<div class="fs-7 text-white-50 position-absolute" style="bottom:4%; left:60%;"><p style="margin-bottom:0 !important">p.페이지</p></div>' +
		'</div>	</div> <p><br><br><br></p>';
	var button = ui.button({
		contents: '<i class="bi bi-postcard"></i> 카드만들기1',
		click: function() {
			context.invoke('pasteHTML', card1);
		}
	});

	return button.render();
}
var createcard2 = function(context) {
	var ui = $.summernote.ui;
	var card2 =
		'<div class="row py-3 px-3"> <div class="col-12 m-auto position-relative  rounded shadow-lg" style="background-image: url(\'../img/write/card2.png\');' +
		'background-size: cover; width:450px; height:300px;">' +
		'<div class="fs-2  position-absolute start-50 translate-middle" style="top:27%;"><p  style="margin-bottom:0 !important">책이름 | 저자</p></div>' +
		'<div class="fs-7  position-absolute" style="top:35%; left:70%;"><p style="margin-bottom:0 !important">p.페이지</p></div>' +
		'<div class="fs-3  position-absolute translate-middle" style="top:68%;left:53%;"><p  style="margin-bottom:0 !important">감명깊었던 문장을 공유해보세요</p></div>' +
		'</div> </div><p><br><br><br></p>';
	var button = ui.button({
		contents: '<i class="bi bi-postcard"></i> 카드만들기2',
		click: function() {
			context.invoke('pasteHTML', card2);
		}
	});

	return button.render();
}
var createcard3 = function(context) {
	var ui = $.summernote.ui;
	var card3 = '<div class="row py-3 px-3">' +
		'<div class="col-12 m-auto position-relative rounded shadow-lg" style="background-image: url(\'../img/write/card3.gif\');' +
		'background-size: cover; width:500px; height:480px;">' +
		'<div class="p-5 fs-4 position-absolute text-white " style="top:16%;"><p  style="margin-bottom:0 !important">마음에드는 구절을 공유해보세요</p></div>' +
		'</div>	</div> </div><p><br><br><br></p>';
	var button = ui.button({
		contents: '<i class="bi bi-postcard"></i> 카드만들기3',
		click: function() {
			context.invoke('pasteHTML', card3);
		}
	});

	return button.render();
}
var createcard4 = function(context) {
	var ui = $.summernote.ui;
	var card4 = '<div class="row py-3 px-3">' +
		'<div class="col-12 m-auto position-relative rounded shadow-lg " style="background-image: url(\'../img/write/card4.gif\');' +
		'background-size: cover; width:500px; height:500px;">' +
		'<div class="p-5 fs-4 position-absolute text-white " style="top:5%; width:480px; height:420px;"><p style="margin-bottom:0 !important">기억에 남는 글을 알려주세요</p></div>' +
		'</div>	</div> </div><p><br><br><br></p>';
	var button = ui.button({
		contents: '<i class="bi bi-postcard"></i> 카드만들기4',
		click: function() {
			context.invoke('pasteHTML', card4);
		}
	});

	return button.render();
}


//웹에디터 썸머노트
var fontList = ['궁서체', '돋움체', '한림명조체', '잉크립퀴드체', '고딕아니고고딩'];
$('#summernote').summernote({
	placeholder: '감토님의 생각을 표현해보세요.',
	tabsize: 2,
	height: 500,
	lang: 'ko-KR',
	focus: true,
	disableGrammar: false,
	fontNames: fontList,
	fontNamesIgnoreCheck: fontList,
	disableDragAndDrop: true,
	tabDisable: false,
	toolbar: [
		['style', ['bold', 'italic', 'underline', 'clear']],
		['font', ['strikethrough', 'superscript', 'subscript']],
		['fontsize', ['fontsize']],
		['fontname'],
		['para', ['paragraph']],
		['color', ['color']],
		['insert', ['picture', 'link']],
		['insert', ['hr']],
		['height', ['height']],
		['card', ['card1', 'card2', 'card3', 'card4']],
	],
	buttons: {
		card1: createcard1,
		card2: createcard2,
		card3: createcard3,
		card4: createcard4,
	}
});

// // 부트스트랩 유효성
// // Example starter JavaScript for disabling form submissions if there are invalid fields
// (() => {
// 	'use strict'
//
// 	// Fetch all the forms we want to apply custom Bootstrap validation styles to
// 	const forms = document.querySelectorAll('.needs-validation')
//
// 	// Loop over them and prevent submission
// 	Array.from(forms).forEach(form => {
// 		form.addEventListener('submit', event => {
// 			if (!form.checkValidity()) {
// 				event.preventDefault()
// 				event.stopPropagation()
// 			}
//
// 			form.classList.add('was-validated')
// 		}, false)
// 	})
// })()

//펑션 : 책검색 초기화
function resetFooter() {
	$('#reportCard').next("br").remove();
	$('#reportCard').prev("br").remove();
	$('#reportCard').remove();

}

//평션 : 책검색 
function searchBook() {
	run = false;
	var search = {
		query: $('#reportFooter-query').val(),
		size: 10,
		page: pageNum,
	}
	if ($('.addbookinfo[name=select]:checked').val() != '') {
		search['target'] = $('.addbookinfo[name=select]:checked').val();
	}
	$.ajax({
		url: "https://dapi.kakao.com/v3/search/book",
		dataType: 'json',
		headers: { Authorization: kakaoSearchKey },
		data: search,
	}).done(function(res) {
		if (res.meta.pageable_count < 1) {
			$('.modal-body').append('<p class="text-center py-5">검색결과가 없습니다</p>');
			run = false;
		} else {
			if (pageNum == 1) {
				var rescount = res.meta.pageable_count
				if (res.meta.pageable_count == 1000) {
					rescount = '1000+';
				}
				$('.modal-body').append('<p class="text-center py-2">검색결과는 총 ' + rescount + '건 입니다</p>');
			}
			var size = 10;
			if (res.meta.pageable_count < ((pageNum) * 10)) {
				size = res.meta.pageable_count - (10 * (pageNum - 1));
			}
			pageNum++;
			for (var i = 0; i < size; i++) {
				$('.modal-body').append(
					'<button type="button" data-bs-dismiss="modal" onclick="getBookCard(this.id)" class="btn btn-outline-warning my-3" id="' + res.documents[i].isbn + '"><div class="card p-2 ms-auto bg-white" style="max-width: 800px;">' +
					'<div class="row g-0"><div class="col-md-4">' +
					'<img src="' + res.documents[i].thumbnail + '" id="reportFooter-thumbnail" class="img-fluid rounded-start" style="max-width: 450px;">' +
					'</div><div class="col-md-8"><div class="card-body">' +
					'<h5 class="card-title link-dark" id="reportFooter-title">' + res.documents[i].title + '</h5>' +
					'<p class="card-text text-end pe-1 link-dark mt-3 mb-0"><small class="text-muted" id="reportFooter-authors">' + res.documents[i].authors + ' 저</small> | ' +
					'<small class="text-muted" id="reportFooter-publisher">' + res.documents[i].publisher + ' 출판</small></p>' +
					'<p class="card-text text-muted" style="overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 3;-webkit-box-orient: vertical;" id="reportFooter-content">' +
					res.documents[i].contents + '</p></div> </div> </div> </div> </button>'
				); //append end
			}// for end
			if (pageNum * 10 > res.meta.pageable_count) {
				$('.modal-body').append('<p class="text-center py-5">검색결과가 더이상 없습니다</p>');
				run = false;
			} else {
				setTimeout(function() { run = true; }, 500)
			}
		}//if isend end
	})//done end
}//function end

//책검색
var pageNum;
$('#reportFooter-submit').click(() => {
	$('.modal-body').empty();
	setTimeout( ()=>{
		pageNum = 1;
		if ($('#reportFooter-query').val() == '') {
			$('.modal-body').append('검색어가 없습니다');
		} else {
			searchBook();
		}//else end
	})
});
//책검색 엔터로 submit
$('#reportFooter-query').keyup( (event)=>{
	if(event.keyCode == 13){
	$('#reportFooter-submit').click();
	}
});

//책검색 스크롤시 더 불러오기
var run = true;
$('.modal-body').scroll(()=> {
	if (run && $('.modal-body').prop('scrollHeight') < $('.modal-body').scrollTop() + $('.modal-body').height() * 2) {
		searchBook();
	}//if end
})//scroll end

//책검색 검색결과 선택
function getBookCard(clicked_id) {
	resetFooter();
	var code = clicked_id;
	var indexOfSpace = clicked_id.indexOf(' ');
	if (indexOfSpace !== -1) {
		code = clicked_id.substring(0, indexOfSpace);
	}
	var search = {
		query: code
	}
	$.ajax({
		url: "https://dapi.kakao.com/v3/search/book",
		dataType: 'json',
		headers: { Authorization: kakaoSearchKey },
		data: search,
	}).done(function(res) {
		$('#summernote').summernote('pasteHTML',
			'<br><div id="reportCard"><div class="card mb-3 p-4 ms-auto" style="max-width: 600px;"> <div class="row g-0"> <div id="" class="col-md-4">' +
			'<img src="' + res.documents[0].thumbnail + '" id="reportFooter-thumbnail" class="img-fluid" alt="..." style="max-width: 450px;"></div>' +
			'<div class="col-md-8 d-flex flex-column"><h4 class="card-title text-end mb-auto" id="card-title">' + res.documents[0].title +
			'</h4> <p style="display: -webkit-box;-webkit-box-orient: vertical;-webkit-line-clamp:2;overflow: hidden;" class="pt-3 text-muted" id="card-content">' + res.documents[0].contents + '...</p>' +
			'<div class=""><p class="card-text text-end pe-1 mb-0"><small class="text-muted" id="card-authors"><b>' + res.documents[0].authors +
			'</b> 저</small></p> <p class="card-text text-end pe-1"><small class="text-muted" id="card-publisher"><b>' + res.documents[0].publisher + '</b> 출판</small>  |  <small class="text-muted" id="card-date"><b>' +
			res.documents[0].datetime.substring(0, res.documents[0].datetime.indexOf('T')) + '</b> 출간</small> </p> <a href="' + res.documents[0].url + '" class="text-end btn btn-primary btn-sm float-end"> 상세보기 </a> </div></div>' +
			'</div></div></div><br>'
			);
	})//done end
}//function end


//유효성 검사 : submit
$('#writeForm').on('submit', function(event) {
	event.preventDefault();

	// 유효성 검사 : 제목
	if ($('input[name="r_title"]').val().replaceAll(" ", "") == "") {
		alertY('제목을 입력해주세요');
		$('input[name="r_title"]').focus();
		return false;
	}else if ($('input[name="r_content"]').val().replaceAll(" ","") == "") {
		alertY('내용을 입력해주세요');
		$('input[name="r_content"]').focus();
		return false;
	} else if ($('textarea[name="r_content"]').val().length > 100000) {
		alertY('내용이 너무 길어요');
		$('input[name="r_content"]').focus();
		return false;
	}
	$('#writeForm').submit();
});


//유효성 검사 : 파일업로드
var fileinput = document.querySelector('input[type="file"]');
fileinput.addEventListener("input", function(){
	const fileForm = /(.*?)\.(jpg|jpge|png|gif|bmp|pdf)$/;
	const maxSize = 1024*1024*5;
		if(!fileinput.value.match(fileForm)){
			alertY('이미지파일 만 선택할 수 있습니다'); 
			fileinput.value = "";
			return;
		}else if(document.querySelector('input[type="file"]').files[0].size >= maxSize){
			alertY('5mb 이하 만 선택할 수 있습니다'); 
			fileinput.value = "";
			return;
		}else if(fileinput.value.length>300){
			fileinput.value = "";
			return
		}//if end
})//event end

//글수정시 등록이미지 보기
$("#viewImg").click(function(){
	var oldFilname= $('input[name="r_filename"]').val();
	window.open('/userUpload/'+oldFilname);
})

// 글수정시 이미지 리셋
$("#resetImg").click(function(){
	$('input[name="showImg"]').val("기본");
	$('.newfile').addClass('d-none');
})

// 글수정시 이미지 변경
$("#changeImg").click(function(){
	$('input[name="showImg"]').val($('input[name="r_filename"]').val());
	 $('.newfile').removeClass('d-none');
})
