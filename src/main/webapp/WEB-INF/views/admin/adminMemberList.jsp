<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.mrmr.gamto.admin.dto.AdminMemberDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>관리자 페이지 | 회원 관리</title>
</head>
<body>
<div class="d-none">
    <jsp:include page="../header.jsp"/>
</div>
<main class="mx-auto p-3 mt-2">
    <div class="bg-light mb-5 px-2 py-xl-5 py-0">
        <div class="col-auto row pt-3">
            <jsp:include page="adminPageSideBar.jsp"/>
            <div class=" container col pt-lg-3">

                <form id="admin-memberOption" action="/admin/admin-member/${onePageNo}/${pageNo}"
                      method="get">
                    <select id="changePageNo" name="changePageNo" class="form-select"
                            onchange="viewPageNo()">
                        <option value="20">20개씩 보기</option>
                        <option value="50">50개씩 보기</option>
                        <option value="70">70개씩 보기</option>
                        <option value="100">100개씩 보기</option>
                    </select>
                </form>
                <table class="table table-hover text-center mt-lg-2 mt-1">
                    <thead>
                    <tr class="text-bg-secondary ">
                        <th scope="col" width=20%>아이디</th>
                        <th scope="col" width=20%>사번</th>
                        <th scope="col" width=20%>이름</th>
                        <th scope="col" width=15%>권한</th>
                        <th scope="col" width=10%>삭제</th>
                        <th scope="col" width=15%>변경</th>
                    </tr>
                    </thead>
                    <tbody class="table-group-divider">
                    <% if (request.getAttribute("adminList") == null) { %>
                    <tr>
                        <td colspan="6">검색결과가 없습니다.</td>
                    </tr>
                    <%} else { %>
                    <c:forEach var="list" items="${adminList}">
                    <tr class="align-middle">
                        <td class="">${list.admin_id}</td>
                        <td class="">${list.admin_number}</td>
                        <td class="">${list.admin_name}</td>
                        <td class="">${list.admin_role}</td>
                        <td class="">
                            <button class="btn  btn-danger" onclick="deleteadmin('${list.admin_id}')">계정삭제</button>
                        </td>
                        <td class="">
                            <select class="form-select" id="${list.admin_id}"
                                    onchange="updateadmin('${list.admin_id}')">
                                <c:choose>
                                    <c:when test="${list.admin_role eq 1}">
                                        <option value="1" selected>(1)최고 권한</option>
                                        <option value="2">(2)임원 권한</option>
                                        <option value="3">(3)직원 권한</option>
                                        <option value="4">(4)승인대기 or 승인회수</option>
                                    </c:when>
                                    <c:when test="${list.admin_role eq 2}">
                                        <option value="1">(1)최고 권한</option>
                                        <option value="2" selected>(2)임원 권한</option>
                                        <option value="3">(3)직원 권한</option>
                                        <option value="4">(4)승인대기 or 승인회수</option>
                                    </c:when>
                                    <c:when test="${list.admin_role eq 3}">
                                        <option value="1">(1)최고 권한</option>
                                        <option value="2">(2)임원 권한</option>
                                        <option value="3" selected>(3)직원 권한</option>
                                        <option value="4">(4)승인대기 or 승인회수</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="1">(1)최고 권한</option>
                                        <option value="2">(2)임원 권한</option>
                                        <option value="3">(3)직원 권한</option>
                                        <option value="4" selected>(4)승인대기 or 승인회수</option>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                        </td>
                        </c:forEach>
                            <% } %>
                    </tbody>
                </table>
                <div>
                    <nav class="py-5">
                        <ul id="" class="pagination d-flex justify-content-center">
                            <li id="" class=" page-item1 mx-3"><a
                                    class="page-link" href="/admin/admin-member/${onePageNo}/1"
                                    aria-label="Previous"><span aria-hidden="true">맨앞</span></a></li>
                            <li id="prev" class="d-none page-item1 mx-3"><a
                                    class="page-link" href="/admin/admin-member/${onePageNo}/${pageNo-1}"
                                    aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>

                            <li>
                                <ul id="page" class="pagination d-flex justify-content-center">
                                    <li id="thispage" class="page-link page-item active">${pageNo}</li>
                                </ul>
                            </li>

                            <li id="next" class="d-none page-item2 mx-4"><a
                                    class="page-link" href="/admin/admin-member/${onePageNo}/${pageNo+1}"
                                    aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
                            <% if (request.getAttribute("adminList") != null) {
                                List<AdminMemberDTO> list = (List<AdminMemberDTO>) request.getAttribute("adminList");
                                double a_total = list.get(0).getAdmin_total();
                                int maxpageno = (int) Math.ceil(a_total / Double.parseDouble((String) request.getAttribute("onePageNo")));%>
                            <li id="" class="page-item2 mx-3"><a
                                    class="page-link" href="/admin/admin-member/${onePageNo}/<%=maxpageno %>"
                                    aria-label="Next"> <span aria-hidden="true">맨뒤</span></a></li>
                            <% } %>
                        </ul>
                    </nav>

                </div>
            </div>
            <!-- col-md-7 -->
        </div>
        <!-- row -->
    </div>
</main>
<script type="text/javascript">
    //페이징처리
    const pageno = ${pageNo};
    const onpageno = ${onePageNo};
    const maxcontent = ${adminList[0].admin_total};
    const maxpageno = Math.ceil(maxcontent / onpageno);

    $(document).ready(function () {
        //이전,다음 버튼 표시여부
        if (pageno > 1) {
            $('#prev').removeClass('d-none');
        }
        if (pageno < maxpageno) {
            $('#next').removeClass('d-none');
        }

        var j = 0;
        for (var i = 1; i <= 4; i++) {
            if ((pageno - i) > 0) {
                $('#page').prepend(
                    '<li class="thispage page-item"><a class="page-link" ' +
                    'href="/admin/admin-member/' + onpageno + '/' + (pageno - i) + '">' + (pageno - i) + '</a></li>');
            } else {
                j++;
            }

            if ((pageno + i) <= maxpageno) {
                $('#page').append(
                    '<li class="thispage page-item"><a class="page-link" ' +
                    ' href="/admin/admin-member/' + onpageno + '/' + (pageno + i) + '">' + (pageno + i) + '</a></li>');
            }

            if (i == 4 && j > 0) {
                //console.log(j+'개를 더 만들어야해요.')
                for (var k = 1; k <= j; k++) {
                    if ((pageno + i + j) <= maxpageno) {
                        $('#page').append(
                            '<li class="thispage page-item"><a class="page-link" ' +
                            ' href="/admin/admin-member/' + onpageno + '/' + (pageno + i + k) + '">' + (pageno + i + k) + '</a></li>');
                        //console.log((pageno + i + k)+'번을 만들었어요')
                    }
                }
            }
        }

        //n개씩 보기 설정된경우 자동선택
        $('#changePageNo option[value="' + onpageno + '"]').attr('selected', true);
    })//레디 end

    //n개씩 보기 반응
    function viewPageNo() {
        $('#admin-memberOption').submit();
    }

    //삭제버튼 액션
    function deleteadmin(adminId) {
        $.ajax({
            url: "/admin/admin-member/" + adminId,
            method: "delete",
            dataType: "text",
        }).done(function (res) {
            if (res == 1) {
                alert('삭제완료');
                $('table').load(location.href + ' table>*')
            } else if (res == 2) {
                alert('권한이 없습니다');
            } else {
                alert('수정실패');
            }
        }).fail(function (res) {
            alert('서버요청실패' + res);
        });
    }

    //수정버튼 액션
    function updateadmin(adminId) {
        var role = {"admin_role": document.getElementById(adminId).value,};
        $.ajax({
            url: "/admin/admin-member/" + adminId,
            type: "PUT",
            data: JSON.stringify(role),
            contentType: 'application/json;charset=UTF-8',
        }).done(function (res) {
            if (res == 1) {
                alert('변경완료');
                $('table').load(location.href + ' table>*')
            } else if (res == 2) {
                alert('권한이 없습니다');
            } else {
                alert('수정실패');
            }
        }).fail(function (res) {
            alert('서버요청실패' + res);
        });
    }
</script>
<jsp:include page="../footer.jsp"/>
</body>
</html>