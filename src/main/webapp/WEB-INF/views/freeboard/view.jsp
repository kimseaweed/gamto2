<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>감토 | 우리 생각</title>
<style>
   .commentCustom{
      border: 1px solid lightgray;
      padding: 10px;
      margin : 3px;
      border-radius: 15px;
   }
   .is-open .accordion__body {
	  height: 50px !important; 
	}
</style>
<%	
   String f_writer = (String)session.getAttribute("u_id");
%>
</head>
<body>
   <%-- <div>cDto : ${cDto.c_writer}</div> --%>
   <jsp:include page="../header.jsp" />
   	<script type="text/javascript">
		var deleted = '${dto.f_delete}';
		if(deleted==1){
			alert('삭제된 게시물입니다');
			history.back();
		}
	</script>
   <main class="container pt-5">
      *${dto.f_category}<br>
      <div class="row">
         <p class="col mt-2">제목 : ${dto.f_title}</p>
         <p class="col ms-auto text-end me-5">작성자 : <span id="f_writer">${dto.f_writer}</span></p>
         <hr>
      </div>
      <div style="padding-bottom: 200px;" class="row">
         <p class="col mt-2">
            내용 : ${dto.f_content}<br>
         </p>
         <p class="col ms-auto text-end me-5" id="good">
            <span>
               댓글 수
            <span id="countComment">${result}</span> &nbsp;| &nbsp;추천 수 :
            ${dto.f_recommend} &nbsp;| &nbsp;조회 수 : ${dto.f_view} <br>
            </span>
         </p>
      </div>
      <hr>
      <div class="row">
         <p class="col mt-2">
            작성 날짜 : ${dto.f_regist_day} <br> 수정 날짜 : ${dto.f_update_day} <br>
         </p>
         <p class="col ms-auto text-end me-5">
            <c:set var="userId" value="<%=f_writer%>"/>
            <c:if test="${dto.f_writer==userId}">
               <input type="button" value="수정"
                  class="btnUpdate btn btn-outline-success">
               <input type="button" value="삭제"
                  class="btnDelete btn btn-outline-danger">
            </c:if>
            <c:set var="l_number" value="${dto.f_seq_number}"/>
            <c:set var="l_board" value="2"/>
            <c:choose>
            	<c:when test="${myLike.likeCheck(l_board,l_number,userId) eq '1'}">
            		<c:set var="likeCheck" value="btn btn-warning"/>
            	</c:when>
            	<c:otherwise>
            		<c:set var="likeCheck" value="btn btn-outline-warning"/>
            	</c:otherwise>	
            </c:choose>
            <span id="goodBtn">
            	<i class="bi bi-hand-thumbs-up btnGood ${likeCheck}">추천</i>
            </span>
         </p>
         <br>
      </div>
      <div class="accordion mt-3" id="accordionExample">
         <div class="accordion-item is-open">
            <h2 class="accordion-header" id="headingOne">
               <button class="accordion-button collapsed" type="button"
                  data-bs-toggle="collapse" data-bs-target="#collapseOne"
                  aria-expanded="true" aria-controls="collapseOne" id="test">
                  댓글보기</button>
            </h2>
            <div id="collapseOne" class="accordion-collapse collapse show"
               aria-labelledby="headingOne" data-bs-parent="#accordionExample">
               <div class="accordion-body">
                  <input type="hidden" name="f_seq_number"
                     value="${dto.f_seq_number}" /> <input type="hidden"
                     name="c_writer" value="<%=f_writer%>" id="writer" />
                  <div class="form-group">
                     <textarea name="c_content" class="form-control" rows="3" id="commentContent"></textarea>
                  </div>
                  <button type="button"
                     class="btn btn-primary text-end btn-sm btnComment m-3">댓글
                     등록</button>
                  <div class="comment" id="commentTable">
                     <c:if test="${empty cDto}">
                        <div class="commentCustom text-center p-5">등록된 댓글이 없습니다.</div>
                     </c:if>
                     <c:if test="${not empty cDto}">
                        <c:forEach items="${cDto}" var="cdto">
                           <input type="hidden" id="scroll" />
                           <div class="commentCustom">
                              <div>
                                 <p>*${cdto.c_writer}*</p>
                                 <p id="${cdto.c_seq_number}comment">${cdto.c_content}</p>
                              </div>
                              <div class="col text-end">
                                 <span><small>등록 날짜 : ${cdto.c_regist_day}</small></span> | <span><small>수정 날짜 : ${cdto.c_update_day}</small></span>
											<c:set var="c_number" value="${cdto.c_seq_number}" />
											<c:set var="l_board" value="3" />
											<c:choose>
												<c:when
													test="${myLike.likeCheck(l_board,c_number,userId) eq '1'}">
													<c:set var="commentLikeCheck" value="bi-hand-thumbs-up-fill" />
												</c:when>
												<c:otherwise>
													<c:set var="commentLikeCheck" value="bi-hand-thumbs-up" />
												</c:otherwise>
											</c:choose>
											<button type="button" class="commentGood ${commentLikeCheck} ${cdto.c_seq_number}" id="${cdto.c_seq_number}" >${cdto.c_recommend}</button>
											<c:set var="l_board" value="4" />
											<c:choose>
												<c:when
													test="${myLike.likeCheck(l_board,c_number,userId) eq '1'}">
													<c:set var="commentBadCheck" value="bi bi-hand-thumbs-down-fill" />
												</c:when>
												<c:otherwise>
													<c:set var="commentBadCheck" value="bi bi-hand-thumbs-down" />
												</c:otherwise>
											</c:choose>
                                 <button type="button" class="commentBad ${commentBadCheck} ${cdto.c_seq_number}" id="${cdto.c_seq_number}">${cdto.c_derecommend}</button>
                                 <c:if test="${cdto.c_writer==userId}">
                                    <button type="button"
                                          class="updateComment enable" id="${cdto.c_seq_number}">수정</button>
                                    <button type="button" class="deleteComment"
                                          id="${cdto.c_seq_number}">삭제</button>
                                 </c:if>
                              </div>
                           </div>
                        </c:forEach>
                  <div id="newComment"></div>
               	  </div><!-- commentTable -->
               	</c:if>
            	</div><!-- accordion-body -->
         	</div><!-- collapseOne -->
      	</div><!-- accordion-item -->
      </div><!-- accordionExample -->
      <div>
         <a href="/board" class="btn btn-outline-primary mt-3">목록보기</a>
      </div>
      <span style="display:none;" id="f_seq_number">${dto.f_seq_number}</span> 
   </main>
   <jsp:include page="../footer.jsp" />
   <script>
 $(document).ready(function() { 
	
    $(document).on('click','.btnUpdate',function (e) { 
      if (!confirm("수정하시겠습니까?")) {
         return false;
      } else {
         $(location).attr('href','updateForm?f_seq_number=${dto.f_seq_number}');
         }
      })
    $(document).on('click','.btnDelete',function (e) { 
      if (!confirm("삭제하시겠습니까?")) {
         return false;
      } else {
         alertR("삭제되었습니다.");
         $(location).attr('href','delete?f_seq_number=${dto.f_seq_number}');
         }
      })
      
  $(document).on('click','.btnGood',function (e) {
      var l_number = document.getElementById('f_seq_number').innerHTML;

         $.ajax({
            type:'POST',
            url:'/board/updateLike',
            dataType : 'json',
            data : {'l_number': l_number,
                  },
            error : function(){
               alert('좋아요 실패');
            }, 
            success : function(result){
               if(result=="3"){
                  alertB('로그인이 필요합니다.');
               }else if(result=="1"){
                  
                  alertY('추천 성공');
                  //하트 활성화 상태
               }else{
                  alertY('추천 취소');
                  //하트 끄셈
               }
               
               $('#good').load(window.location.href+" #good>span");
               $('#goodBtn').load(window.location.href+" #goodBtn>i");               
            }
         })
      })
      
    
      
   $(document).on('click','.btnComment',function (e) {
      var writer = document.getElementById('writer').value;
      var content = document.getElementById('commentContent').value;
      
      if(!content){
         alertB('작성된 내용이 없습니다.');
         return false;
      }
      if(writer == "null"){
         alertB('로그인이 필요합니다.');
         return false;
      }else{
         getCommentList();
         var result = Number(document.getElementById('countComment').innerHTML);
         
         document.getElementById('countComment').innerHTML= result+1;
         }
      })
      
      
   function getCommentList(){
      var f_seq_number = $('input[name=f_seq_number]').val();
      var c_writer = $('input[name=c_writer]').val();
      var c_content = $('textarea[name=c_content]').val();
      
      $.ajax({
         type:'GET',
         url :'/board/getComentList',
         data : {'f_seq_number': f_seq_number, 
               'c_writer': c_writer,
               'c_content': c_content},
         success:function(result){
            if(result==1) {
               $('#commentTable').load(location.href+' #commentTable');
               $('textarea').val('');
               console.log("통신성공");
            }else {
               alertR("서버문제로 등록에 실패하였습니다.(*DB문제*)");
            }
            
         }, error: function(result){
            console.log("통신실패");
         }
      })
   }
    
    $(document).on('click','.commentGood',function (e) {
  	  var c_seq_number =  $(this).attr("id");
      var l_number = c_seq_number;
      var feeling = 'good';
      var toggie = $(".commentGood#"+c_seq_number);
      var toggieValue = Number($(".commentGood#"+c_seq_number).text());
      console.log(toggie);
      
      function toggle(){
     	 toggie.toggleClass('bi-hand-thumbs-up-fill').toggleClass('bi-hand-thumbs-up');
      	}
      function valuePlus(){
     	 document.getElementsByClassName(c_seq_number+' commentGood')[0].innerHTML = ++toggieValue;
     	 }
      function valueMinus(){
     	 document.getElementsByClassName(c_seq_number+' commentGood')[0].innerHTML = --toggieValue;
      	}
      
    	
       $.ajax({
          type:'POST',
          url:'/board/commentFeeling',
          dataType : 'json',
          data : {'l_number': l_number,
                'feeling' : feeling,
                },
          error : function(){
             alertR('좋아요 실패');
          }, 
          success : function(result){
             if(result=="3"){
                alertB('로그인이 필요합니다.');
                return false;
             }else if(result=="0"){
                 alertR('이미 싫어요를 선택하셨습니다.');
                 
             }else if(result=="1"){
                alertY('추천 성공');
                toggle();
                valuePlus();
             }else if(result=="2"){
                alertY('추천 취소')
                toggle();
                valueMinus();
             }else{
                alertR('알수없는 문제 :'+result);
             }
          } 
       })
       
    })
    
    $(document).on('click','.commentBad',function (e) {
       var c_seq_number =  $(this).attr("id");
       var l_number = c_seq_number;
       var toggie = $(".commentBad."+c_seq_number);
       console.log(toggie);
       var toggieValue = Number(toggie.text());
       var feeling = 'bad';
       
       function toggle2(){
      	 toggie.toggleClass('bi-hand-thumbs-down-fill').toggleClass('bi-hand-thumbs-down');
       	}
       function valuePlus2(){
      	 document.getElementsByClassName(c_seq_number+' commentBad')[0].innerHTML = ++toggieValue;
      	 }
       function valueMinus2(){
      	 document.getElementsByClassName(c_seq_number+' commentBad')[0].innerHTML = --toggieValue;
      	 
       	}
       
          $.ajax({
             type:'POST',
             url:'/board/commentFeeling',
             dataType : 'json',
             data : {'l_number': l_number,
                   'feeling' : feeling,
                   },
             error : function(){
                alert('연결 실패');
             }, 
             success : function(result){
                if(result=="3"){
                   alertB('로그인이 필요합니다.');
                   return false;
                }else if(result=="0"){
                    alertR('이미 좋아요를 선택하셨습니다.');
                    //하트 끄셈
                }else if(result=="1"){
                   alertY('싫어요 선택');
                   toggle2();
                   valuePlus2();
                   //하트 활성화 상태
                }else if(result=="2"){
                   alertY('싫어요 취소');
                   toggle2();
                   valueMinus2();
                }else{
                   alertR(' '+result);
                }
               
             }
          })
       })
    
    $(document).on('click','.updateComment',function (e) {

      if($(this).attr('class')=='updateComment enable'){
         
      var c_seq_number =  $(this).attr("id");
      $(this).addClass('disable');
      $(this).removeClass('enable');
      var value=document.getElementById(c_seq_number+'comment').innerText;
      
      var commentValue=document.getElementById(c_seq_number).innerHTML;
      
      alert(commentValue);
      
      document.getElementById(c_seq_number+'comment').innerHTML=
      '<input type="textarea" style="height: 80px; width: 100%;" value="'+value+'"/>';
      }else if($(this).attr('class')=='updateComment disable'){
         var c_seq_number = $(this).attr("id");
         
         $(this).addClass('enable');
         $(this).removeClass('disable');
         //수정한 값 불러옴
         var value=document.getElementById(c_seq_number+'comment').firstChild.value;
         
         //완성된값으로 수정함
         document.getElementById(c_seq_number+'comment').innerHTML=value;
         
         //ajax시작
         $.ajax({
            type:'GET',
            url :'/board/cUpdate',
            data : {'c_seq_number': c_seq_number,
                  'c_content': value},
            success:function(result){
               if(result==1) {
                  $('#commentTable').load(location.href+' #commentTable');
                  console.log("수정 통신성공");
               }else {
                  alertR("서버문제로 등록에 실패하였습니다.(*DB문제*)");
               }
               
            }, error: function(result){
               console.log("수정 통신실패");
            }
         })
      }
      
   })
   
    $(document).on('click','.deleteComment',function (e) {
       
      var c_seq_number =  $(this).attr("id");
      
      $.ajax({
         type:'GET',
         url :'/board/cDelete',
         data : {'c_seq_number': c_seq_number},
         success:function(result){
            if(result==1) {
               $('#commentTable').load(location.href+' #commentTable');
               console.log("삭제 통신성공");
            }else {
               alertR("서버문제로 등록에 실패하였습니다.(*DB문제*)");
            }
            
         }, error: function(result){
            console.log("삭제 통신실패");
         }
      })
   })
 }) 
</script>
</body>
</html>