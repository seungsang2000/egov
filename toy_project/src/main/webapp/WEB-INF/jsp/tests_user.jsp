<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date"%>

<%@ include file="/WEB-INF/jsp/include/header.jsp"%>

<%
    // 현재 시간 가져오기
    Date currentTime = new Date();
    request.setAttribute("currentTime", currentTime);
%>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>강좌 세부사항</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">나의 강좌</a></li>
                        <li class="breadcrumb-item active">${course.title}</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <!-- Default box -->
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">${course.title}</h3>
            </div>
            <div class="card-body p-0">
                <table class="table table-striped projects">
                    <thead>
                        <tr>
                            <th style="width: 1%">#</th>
                            <th style="width: 20%">시험 이름</th>
                            <th style="width: 25%">응시 인원</th>
                            <th>점수</th>
                            <th style="width: 15%" class="text-center">상태</th>
                            <th style="width: 18%"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="test" items="${list}">
                            <c:if test="${test.status == '완료'}">
                                <tr>
                                    <td>#</td>
                                    <td>
                                        <a>${test.name}</a><br />
                                        <small>
                                            <fmt:formatDate value="${test.start_time}" pattern="yyyy-MM-dd HH:mm" /> ~
                                            <fmt:formatDate value="${test.end_time}" pattern="yyyy-MM-dd HH:mm" />
                                        </small>
                                    </td>
<td>
    <div class="user-count-container">
        <span class="badge badge-info">${test.user_count}</span> <!-- 시험 본 유저 수 -->
        <span class="separator">/</span>
        <span class="badge badge-light">${totalStudent}</span> <!-- 전체 유저 수 -->
        <span class="user-icon">
            <i class="fas fa-users" aria-hidden="true"></i> <!-- 사용자 아이콘 -->
        </span>
        <span class="check-icon">
            <i class="fas fa-check-circle" aria-hidden="true"></i> <!-- 체크 아이콘 -->
        </span>
    </div>
</td>
                                    <td class="project_progress">
                                        <div class="progress progress-sm">
                                            <div class="progress-bar bg-green" role="progressbar" aria-valuenow="47" aria-valuemin="0" aria-valuemax="100" style="width: 47%"></div>
                                        </div>
                                        <small>47% Complete</small>
                                    </td>
                                    <td class="project-state">
                                        <c:if test="${not empty test.user_status}">
                                            <span class="badge badge-info">${test.user_status}</span>
                                        </c:if>
                                        <c:if test="${empty test.user_status}">
                                            <c:set var="currentTime" value="${currentTime}" />
                                            <c:if test="${currentTime.time >= test.start_time.time && currentTime.time <= test.end_time.time}">
                                                <span class="badge badge-success">응시 가능</span>
                                            </c:if>
                                            <c:if test="${currentTime.time < test.start_time.time || currentTime.time > test.end_time.time}">
                                                <span class="badge badge-danger">응시 불가</span>
                                            </c:if>
                                        </c:if>
                                    </td>
                                    <td class="project-actions text-right">
                                        <c:set var="currentTime" value="${currentTime}" />
                                        <c:choose>
                                            <c:when test="${currentTime.time >= test.start_time.time && currentTime.time <= test.end_time.time && test.user_status != '완료'}">
                                                <a class="btn btn-primary btn-sm" href="/question/startTestPage.do?testId=${test.id}">
                                                    <i class="fas fa-eye"></i> 문제 풀기
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-secondary btn-sm" disabled>
                                                    <i class="fas fa-eye-slash"></i> 문제 풀기
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <!-- /.card-body -->
        </div>
        <!-- /.card -->
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<style>
.user-count-container {
    display: flex;
    align-items: center; /* 아이템 수직 중앙 정렬 */
    font-size: 1.2rem; /* 기본 폰트 크기 */
    padding: 5px; /* 패딩 추가 */
    
}

.badge {
    font-size: 1rem; /* 배지 크기 조정 */
    margin-right: 5px; /* 배지 간격 조정 */
}

.separator {
    margin: 0 5px; /* 구분자 간격 조정 */
    font-weight: bold; /* 구분자 강조 */
}

.user-icon {
    margin-left: 10px; /* 사용자 아이콘 여백 */
    color: #007bff; /* 아이콘 색상 */
    font-size: 1.5rem; /* 아이콘 크기 조정 */
}

.check-icon {
    margin-left: 5px; /* 체크 아이콘 여백 */
    color: #28a745; /* 체크 아이콘 색상 */
    font-size: 1.5rem; /* 체크 아이콘 크기 조정 */
}

</style>


<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>