# 독서감상 토론회 [감토]

[팀프로젝트] 독서감상 토론회 '감토' 
23.07.27 ~ 23.08.24 => <br>
[개인프로젝트] '감토' 수정 및 업그레이드 24.10.20 ~  진행중
<br><br>

## 💡 소개
'감토'는 독서를 더욱 풍부하게 즐길 수 있도록 서로의 감상문을 공유하고 책에 대한 이야기를 나눌 수 있는 커뮤니티 웹서비스입니다.<br>
감토를 더욱 편리하고 안정적으로 사용할 수 있도록 리뉴얼하였습니다.
<br><br>
## 📜 주요페이지
* 독서 감상문을 남기는 [나의 생각]
* 독서 토론회를 열거나, 회원들과 대화를 나누는  [우리 생각]
* 책과 도서굿즈를 구매할 수 있는 [상점]
* 회원·직원 계정, 게시물·댓글, 문의·신고을 관리하는 [관리자 페이지]
  <br><br>

## 🔧 사용 스택
* Frontend : Html·CSS, JavaScript, jquery, ajax, JSP, BootStrap
* Backend : SpringBoot(Gradle), Oracle
* API : kakao map, daum검색, i'port(kakao pay)
* Deploy : Oracle Cloud, Nginx, tomcat(SpringBoot)
  <br><br>

## 📰 업데이트 내역
* 23.08.23 (구버전)완성
* 24.10.20 
  * feat : 새로운 버전을 위한 초기 설정 및 환경 구성
  * feat : 오라클 클라우드 배포
  * perf : warm up 코드 추가 
  * feat : 일반회원 비밀번호 암호화
  * fix : 나의생각 글 작성시 책검색 esc후 재검색시 결과 이중표시 수정 
  * fix : 나의생각 글 작성시 책검색 enter시 관련 없는 경로로 이동함 수정
  * fix : 나의생각 글 작성시 js 유효성검사 수정
  * feat : 나의생각 글 작성시 백단 유효성검사 추가
* 24.10.26
  * refactor : addMember.jsp 기존코드 폐기 후 재작성
* 24.10.27
  * refactor (member.js) : addmember.jsp submit시 뷰단에서 유효성체크 재작성 
* 24.10.28
  * feat (MemberController.java) : addmember.jsp submit시 백단에서 유효성체크 생성
  * refactor (MemberController.java) : 회원가입로직을 Service로 이관
  * feat (member.js) : 중복체크하는 ajax생성
<br><br>

## 💾 감토 구버전
* https://github.com/kimseaweed/gamto
