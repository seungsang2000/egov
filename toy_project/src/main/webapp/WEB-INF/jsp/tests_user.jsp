<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date" %>

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
                            <th style="width: 30%">응시 인원</th>
                            <th>점수</th>
                            <th style="width: 8%" class="text-center">상태</th>
                            <th style="width: 20%"></th>
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
                                        <ul class="list-inline">
                                            <li class="list-inline-item"><img alt="Avatar" class="table-avatar" src="../../dist/img/avatar.png"></li>
                                            <li class="list-inline-item"><img alt="Avatar" class="table-avatar" src="../../dist/img/avatar2.png"></li>
                                        </ul>
                                    </td>
                                    <td class="project_progress">
                                        <div class="progress progress-sm">
                                            <div class="progress-bar bg-green" role="progressbar" aria-valuenow="47" aria-valuemin="0" aria-valuemax="100" style="width: 47%"></div>
                                        </div>
                                        <small>47% Complete</small>
                                    </td>
                                    <td class="project-state">
                                        <c:set var="currentTime" value="${currentTime}" />
                                        <c:if test="${currentTime.time >= test.start_time.time && currentTime.time <= test.end_time.time}">
                                            <span class="badge badge-success">응시 가능</span>
                                        </c:if>
                                        <c:if test="${currentTime.time < test.start_time.time || currentTime.time > test.end_time.time}">
                                            <span class="badge badge-danger">응시 불가</span>
                                        </c:if>
                                    </td>
                                    <td class="project-actions text-right">
                                    <c:set var="currentTime" value="${currentTime}" />
                                        <c:if test="${currentTime.time >= test.start_time.time && currentTime.time <= test.end_time.time}">
                                            <a class="btn btn-primary btn-sm" href="/startTestPage.do?testId=${test.id}"> 
                                            <i class="fas fa-eye"></i> 문제 풀기 
                                        </a>
                                        </c:if>
                                        <c:if test="${currentTime.time < test.start_time.time || currentTime.time > test.end_time.time}">
                                            <button class="btn btn-secondary btn-sm" disabled>
                								<i class="fas fa-eye-slash"></i> 문제 풀기
            								</button>
                                        </c:if>
                                        
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

<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>