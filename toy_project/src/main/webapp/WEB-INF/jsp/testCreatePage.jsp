<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/include/header.jsp" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>시험 생성</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="/">메인 화면</a></li>
                        <li class="breadcrumb-item active">시험 생성</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <form action="/testCreate.do" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div class="row">
                <div class="col-md-6">
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3 class="card-title">시험 생성</h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="form-group">
                                <label for="inputName">시험 이름</label>
                                <input type="text" id="inputName" class="form-control" name="name" required>
                            </div>
                            <div class="form-group">
                                <label for="inputDescription">시험 안내사항</label>
                                <textarea id="inputDescription" class="form-control" rows="4" name="description" required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="inputDuration">시험 시간 (분)</label>
                                <input type="number" id="inputDuration" class="form-control" name="time_limit" required min="1" step="1" oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                            </div>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
                <div class="col-md-6">
                    <div class="card card-secondary">
                        <div class="card-header">
                            <h3 class="card-title">기간 설정</h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="form-group">
                                <label for="inputStartDateTime">시작일 및 시간</label>
                                <input type="datetime-local" id="StartDate" class="form-control" name="start_time" required>
                            </div>
                            <div class="form-group">
                                <label for="inputEndDateTime">종료일 및 시간</label>
                                <input type="datetime-local" id="EndDate" class="form-control" name="end_time" required>
                            </div>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <a href="#" class="btn btn-secondary">취소</a>
                    <input type="hidden" name="course_id" value="${courseId}"/>
                    <input type="submit" value="시험 생성" class="btn btn-success float-right" onclick="return validateDates()">
                </div>
            </div>
        </form>
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<script>
function validateDates() {
    const startDateTime = document.getElementById('StartDate').value;
    const endDateTime = document.getElementById('EndDate').value;
    const time_limit = parseInt(document.getElementById('inputDuration').value, 10);

    
    const startDate = new Date(startDateTime);
    const endDate = new Date(endDateTime);

    
    const now = new Date();

    
    if (startDate < now) {
        alert('시작일은 현재 이후여야 합니다.');
        return false;
    }
    
    if (endDate < now) {
        alert('종료일은 현재 이후여야 합니다.');
        return false;
    }

    const examEndDate = new Date(startDate.getTime());
    examEndDate.setMinutes(examEndDate.getMinutes() + time_limit);

    if (examEndDate > endDate) {
        alert('종료일은 최소한 시작일과 시험 시간을 더한 이후여야 합니다.');
        return false;
    }

    return true;
}
</script>

<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>