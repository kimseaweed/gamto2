<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<%
String bookName = (String)request.getParameter("bookName");
String bookQuantity = (String)request.getParameter("bookQuantity");
String bookPrice = (String)request.getParameter("bookPrice");
String stotalCost = (String)request.getParameter("totalCost");
String orderCode = (String)request.getParameter("orderCode");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>kakaoPay</title>
</head>
<body>
 
</body>
</html>
<script>
$(document).ready(function(){
	console.log('${userInfo.u_name}');
	console.log('${userInfo.u_id}');
})

var IMP = window.IMP; // 생략가능
IMP.init('imp23418340');
// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
// ''안에 띄어쓰기 없이 가맹점 식별코드를 붙여넣어주세요. 안그러면 결제창이 안뜹니다.
if(<%=bookQuantity%>=='1'){
   IMP.request_pay({
      pg: 'kakao',
      pay_method: 'card',
      merchant_uid: 'merchant_' + new Date().getTime(),
      /* 
       *  merchant_uid에 경우 
       *  https://docs.iamport.kr/implementation/payment
       *  위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
       */
      name: '주문명 : <%=bookName%>',
      
      // 결제창에서 보여질 이름
      // name: '주문명 : ${auction.a_title}',
      // 위와같이 model에 담은 정보를 넣어 쓸수도 있습니다.
      amount: <%=stotalCost%>,
      // amount: ${bid.b_bid},
      // 가격 
      buyer_name: '${userInfo.u_id}',
      buyer_email: '${userInfo.u_email}',
      buyer_tel: '${userInfo.u_phone}',
      buyer_addr: '${userInfo.u_address}',
      // 구매자 이름, 구매자 정보도 model값으로 바꿀 수 있습니다.
      // 구매자 정보에 여러가지도 있으므로, 자세한 내용은 맨 위 링크를 참고해주세요.
      buyer_postcode: '123-456',
      }, function (rsp) {
         console.log('ajax strat');
      if (rsp.success) {
    	  var msg = '결제가 완료되었습니다.';
          msg += '결제 금액 : ' + rsp.paid_amount;
           const dto = {
       		o_order_number : rsp.merchant_uid,
       		o_book_name: rsp.name,
       		o_total: rsp.paid_amount,
      		o_price : <%=bookPrice%>,
      		o_order_code: <%=orderCode%>,
     		o_quantity: <%=bookQuantity+1%>,
     	    o_name: rsp.buyer_name,
     	    o_phone: rsp.buyer_tel,
     	    o_address: rsp.buyer_addr
     	};
           var o_order_number = dto[Object.keys(dto)[0]];
         $.ajax({
        	url:'/kakaoPay/insertKakaoPayInfo',
        	type:'GET',
        	contentType:'application/json; charset=UTF-8',
        	data: dto,
        	success : dto => {
        		console.log('return start');
        		window.location.href = "kakaoPay/kakaoPaySuccess?o_order_number=" + o_order_number;
        	}
         })
      } else {
         var msg = '결제에 실패하였습니다.';
         msg += '에러내용 : ' + rsp.error_msg;
         location.href="/kakaoPay/kakaoPaySuccessFail";
      }
      console.log(msg);
   });
}else{
   IMP.request_pay({
      pg: 'kakao',
      pay_method: 'card',
      merchant_uid: 'merchant_' + new Date().getTime(),
      /* 
       *  merchant_uid에 경우 
       *  https://docs.iamport.kr/implementation/payment
       *  위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
       */
      name: '주문명 : <%=bookName%> 외 총<%=bookQuantity%>권',
      
      // 결제창에서 보여질 이름
      // name: '주문명 : ${auction.a_title}',
      // 위와같이 model에 담은 정보를 넣어 쓸수도 있습니다.
      amount: <%=stotalCost%>,
      // amount: ${bid.b_bid},
      // 가격 
      buyer_name: '${userInfo.u_id}',
      buyer_email: '${userInfo.u_email}',
      buyer_tel: '${userInfo.u_phone}',
      buyer_addr: '${userInfo.u_address}',
      // 구매자 이름, 구매자 정보도 model값으로 바꿀 수 있습니다.
      // 구매자 정보에 여러가지도 있으므로, 자세한 내용은 맨 위 링크를 참고해주세요.
      buyer_postcode: '123-456',
      }, function (rsp) {
         console.log(rsp.paid_amount);
      if (rsp.success) {
         var msg = '결제가 완료되었습니다.';
         msg += '결제 금액 : ' + rsp.paid_amount;
         console.log('asdf');
         const dto = {
            	o_order_number : rsp.merchant_uid,
            	o_book_name: rsp.name,
          		o_total: rsp.paid_amount,
          		o_price : <%=bookPrice%>,
          		o_order_code:<%=orderCode%>,
          		o_quantity: <%=bookQuantity+1%>,
          	    o_name: rsp.buyer_name,
          	    o_phone: rsp.buyer_tel,
          	    o_address: rsp.buyer_addr
          	};
         var o_order_number = dto[Object.keys(dto)[0]];
         $.ajax({
         	url:'/kakaoPay/insertKakaoPayInfo',
         	type:'GET',
         	contentType:'application/json; charset=UTF-8',
         	data: dto,
         	success : dto => {
         		console.log('return start');
         		console.log(o_order_number);
         	    window.location.href = "kakaoPay/kakaoPaySuccess?o_order_number=" + o_order_number;
         	}
          })
         // success.submit();
         // 결제 성공 시 정보를 넘겨줘야한다면 body에 form을 만든 뒤 위의 코드를 사용하는 방법이 있습니다.
         // 자세한 설명은 구글링으로 보시는게 좋습니다.
        // location.href="/kakaoPay/kakaoPaySuccess";
      } else {
         var msg = '결제에 실패하였습니다.';
         msg += '에러내용 : ' + rsp.error_msg;
         location.href="/kakaoPaySuccessFail";       
      }
      console.log(msg);
   });
}
   
</script>