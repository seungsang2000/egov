<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/jsp/include/header.jsp"%>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>${test.name}</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">나의 강좌</a></li>
                        <li class="breadcrumb-item active">시험 풀이</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">시험 정보</h3>
            </div>
            <div class="card-body">
                <div class="form-group">
                    <label>시험 설명</label>
                    <p>${test.description}</p>
                </div>
                <div class="form-group">
                    <label>시험 시작일</label>
                    <p><fmt:formatDate value="${test.start_time}" pattern="yyyy-MM-dd HH:mm" /></p>
                </div>
                <div class="form-group">
                    <label>시험 종료일</label>
                    <p><fmt:formatDate value="${test.end_time}" pattern="yyyy-MM-dd HH:mm" /></p>
                </div>
                <div class="form-group">
                    <label>제한 시간</label>
                    <p>${test.time_limit} 분</p>
                </div>
                <div class="form-group">
                    <button id="startTest" class="btn btn-success">시험 시작</button>
                </div>
            </div>
        </div>
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->


<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmModalLabel">시험 시작 확인</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                시험 기회는 1번이며, 한번 시험이 시작되면 되돌릴 수 없습니다. 시험을 시작하시겠습니까?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="confirmStartTest">시작</button>
            </div>
        </div>
    </div>
</div>

<script>
document.getElementById('startTest').addEventListener('click', function() {
    // 모달을 띄움
    $('#confirmModal').modal('show');
});

document.getElementById('confirmStartTest').addEventListener('click', function() {
    // 확인 버튼 클릭 시 문제 풀이 페이지로 이동
    window.location.href = '/question/solveTest.do?testId=${test.id}';
});
</script>

<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>