<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>감토 | 신개념 독서토론</title>
<link rel="stylesheet" href="/css/index.css" />
<style>
/* Basic ribbon */
.ribbon {
	color: #fff;
	display: block;
	font-size: 0.7em;
	position: absolute;
	top: 11px;
	right: 1px;
	width: 40px;
	height: 20px;
	line-height: 20px;
	letter-spacing: 0.15em; 
	text-align: center;
	-webkit-transform: rotateZ(45deg) translateZ(1px);
	-moz-transform: rotateZ(45deg) translateZ(1px);
	transform: rotateZ(45deg) translateZ(1px);
	-webkit-backface-visibility: hidden;
	-moz-backface-visibility: hidden;
	backface-visibility: hidden;
	z-index: 10;
  &.new{
    background: #63c930;
    &:before,
    &:after{
      border-bottom: 20px solid #63c930;
    }
  }
  &.bestseller{
    background: #c0392b;
    &:before,
    &:after{
      border-bottom: 20px solid #c0392b;
    }
  } 
}
</style>
</head>
<body>
<jsp:include page="header.jsp"/>
<main>
<div class="component pt-3">
  <ul class="align">
    <!-- Book 1 -->
    <li>
      <figure class='book'>        
        <!-- Front -->        
        <ul class='hardcover_front'>
          <li>
            <img src="/img/index/myBook.png" alt="" width="100%" height="100%">
            <span class="ribbon bestseller">Nº1</span>
          </li>
          <li></li>
        </ul>        
        <!-- Pages -->        
        <ul class='page'>
          <li></li>
          <li>
            <a class="btn" href="/report/new">나의생각 가기</a>
          </li>
          <li></li>
          <li></li>
          <li></li>
        </ul>        
        <!-- Back -->        
        <ul class='hardcover_back'>
          <li></li>
          <li></li>
        </ul>
        <ul class='book_spine'>
          <li></li>
          <li></li>
        </ul>
        <figcaption>
          <h1>나의생각</h1>
          <span>내가 읽은 책을 소개해주세요</span>
          <p>누구나 독서 후에는 새로운 내용에 대한 지식 얻고 그에 따른 생각과 느낌을 갖게 된다. 이러한 생각을 글로 옮기면 책의 내용을 재정리할 수 있고 작가가 전하고자 하는 의미와 내용전개를 파악하기 용이하며 결과적으로 독서에 대한 더욱 큰 보람을 느낄 수 있게 된다</p>
        </figcaption>
      </figure>
    </li>  
    <!-- Book 2 -->
    <li>
      <figure class='book'>        
        <!-- Front -->        
        <ul class='hardcover_front'>
          <li>
            <img src="/img/index/bookReport.png" alt="" width="100%" height="100%">
            <span class="ribbon new">NEW</span>
          </li>
          <li></li>
        </ul>        
        <!-- Pages -->        
        <ul class='page'>
          <li></li>
          <li>
            <a class="btn" href="/report">너의생각 가기</a>
          </li>
          <li></li>
          <li></li>
          <li></li>
        </ul>        
        <!-- Back -->        
        <ul class='hardcover_back'>
          <li></li>
          <li></li>
        </ul>
        <ul class='book_spine'>
          <li></li>
          <li></li>
        </ul>
        <figcaption>
          <h1>너의생각</h1>
          <span>새로운 관점을 경험해보세요</span>
          <p>읽지 않은 책을 간접적으로 체험하는 계기가 될 수 있고, 혼자서 보았을 때 깨닫지 못한 흐름을 잡을 수 있다. 다양한 관점을 미리 아는 것도 하나의 독서 방법이다.</p>
        </figcaption>
      </figure>
    </li>  
    <!-- Book 3 -->
    <li>
      <figure class='book'>       
        <!-- Front -->        
        <ul class='hardcover_front'>
          <li>
            <img src="/img/index/freeboard.png" alt="" width="100%" height="100%">
          </li>
          <li></li>
        </ul>        
        <!-- Pages -->        
        <ul class='page'>
          <li></li>
          <li>
		     <a class="btn" href="/board">우리생각 가기</a>
          </li>
          <li></li>
          <li></li>
          <li></li>
        </ul>        
        <!-- Back -->        
        <ul class='hardcover_back'>
          <li></li>
          <li></li>
        </ul>
        <ul class='book_spine'>
          <li></li>
          <li></li>
        </ul>
        <figcaption>
          <h1>우리생각</h1>
          <span>함께 의견을 나누어보세요</span>
          <p>토론을 통해 다른 사람과 의견을 나누는 과정을 통해 책의 내용을 보다 깊이 이해할 수 있습니다. 스스로 내린 결론에 대한 판단의 오류를 피할 수 있습니다. 상대방의 설득 과정을 통해 보다 논리적이고 비판적인 사고 능력을 키울 수 있습니다.</p>
        </figcaption>
      </figure>
    </li>
  </ul>
</div>
</main>
<div class="d-none">
<jsp:include page="footer.jsp"/>
</div>
</body>
</html>