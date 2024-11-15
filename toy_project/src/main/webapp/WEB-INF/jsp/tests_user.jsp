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
                        <li class="breadcrumb-item"><a href="/">나의 강좌</a></li>
                        <li class="breadcrumb-item active">${course.title}</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link  active" href="#">시험 목록</a> <!-- 시험 목록 페이지 -->
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/chat.do?id=${course.id}">소통</a> <!-- 소통 페이지 -->
        </li>
    </ul>
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
                    <c:forEach var="test" items="${list}" varStatus="status">
                        <c:if test="${test.status == '완료'}">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                    <a>${test.name}</a><br />
                                    <small>
                                        <fmt:formatDate value="${test.start_time}" pattern="yyyy-MM-dd HH:mm" /> ~
                                        <fmt:formatDate value="${test.end_time}" pattern="yyyy-MM-dd HH:mm" />
                                    </small>
                                </td>
                                <td>
                                    <div class="user-section"> <!-- 부모 클래스 추가 -->
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
                                    </div>
                                </td>
                                <td class="project_progress">
                                    <c:choose>
                                        <c:when test="${test.is_scored}">
                                            <div class="progress progress-sm">
                                                <div class="progress-bar bg-green" role="progressbar"
                                                     aria-valuenow="${(test.user_score / test.score) * 100}" 
                                                     aria-valuemin="0" 
                                                     aria-valuemax="100"
                                                     style="width: ${(test.user_score / test.score) * 100}%">
                                                </div>
                                            </div>
                                            <small>${test.user_score} 점 / ${test.score} 점(${Math.round((test.user_score / test.score) * 100)}%)</small>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="progress progress-sm">
                                                <div class="progress-bar bg-green" role="progressbar"
                                                     aria-valuenow="0" 
                                                     aria-valuemin="0" 
                                                     aria-valuemax="100"
                                                     style="width: 0">
                                                </div>
                                            </div>
                                            <small>미채점</small>
                                        </c:otherwise>
                                    </c:choose>
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
        <c:when test="${test.user_status == '완료' && test.is_scored}">
            <a class="btn btn-info btn-sm" href="/question/testReview.do?testId=${test.id}">
                <i class="fas fa-book"></i> 오답 노트
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
.user-section .user-count-container { 
    display: flex;
    align-items: center; 
    font-size: 1.2rem;
    padding: 5px; 
}

.user-section .badge {
    font-size: 1rem; 
    margin-right: 5px; 
}

.user-section .separator { 
    margin: 0 5px; 
    font-weight: bold; 
}

.user-section .user-icon { 
    margin-left: 10px; 
    color: #007bff; 
    font-size: 1.5rem;
}

.user-section .check-icon { 
    margin-left: 5px; 
    color: #28a745;
    font-size: 1.5rem;
}
</style>

<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>