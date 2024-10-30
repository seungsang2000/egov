<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    
<%@ include file="/WEB-INF/jsp/include/header.jsp" %>


<!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>강좌 수정</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/">메인 화면</a></li>
              <li class="breadcrumb-item active">강좌 수정</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">

      <!-- Default box -->
      <div class="card">
            <div class="card-header">
                <h3 class="card-title">강좌 리스트</h3>

                <div class="card-tools">
                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                        <i class="fas fa-minus"></i>
                    </button>
                </div>
            </div>
            <div class="card-body p-0">
                <table class="table table-striped projects">
                    <thead>
                        <tr>
                            <th style="width: 1%">#</th>
                            <th style="width: 20%">강좌</th>
                            <th style="width: 15%">이미지</th>
                            <th style="width: 15%">수강 인원</th>
                            <th>Project Progress</th>
                            <th style="width: 8%" class="text-center">상태</th>
                            <th style="width: 20%"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="course" items="${courseList}"  varStatus="status">
    <tr>
        <td>${status.index + 1}</td>
        <td>
            <a>${course.title}</a>
            <br/>
            <small>Created <fmt:formatDate value="${course.created_at}" pattern="yyyy-MM-dd" /></small>
        </td>
        <td>
            <ul class="list-inline">
                <li class="list-inline-item">
                <img src="/${course.image_path}" 
                             alt="이미지 없음" 
                             class="table-avatar" 
                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/question_mark.png';">
                </li>
            </ul>
        </td>
        <td><i class="fas fa-user-friends" style="margin-right: 5px; color: #007bff;"></i>
    <span style="color: #333;">${course.studentCount}명</span></td>
        <td class="project_progress">
            <div class="progress progress-sm">
                <div class="progress-bar bg-green" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width: 50%">
                </div>
            </div>
            <small>50% Complete</small>
        </td>
        <td class="project-state">
            <span class="badge ${course.status == '비공개' ? 'badge-danger' : 'badge-success'}">${course.status}</span>
        </td>
        <td class="project-actions text-right">
            <a class="btn btn-info btn-sm" href="/couresEdit.do?courseId=${course.id}">
                 <i class="fas fa-pencil-alt"></i> Edit
            </a>
        </td>
    </tr>
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

  <script>
$(document).ready(function() {
    $('.enroll-button').on('click', function() {
        console.log("...........");
        var courseId = $(this).data('course-id');
        var csrfToken = $('meta[name="_csrf"]').attr('content');
        
        $.ajax({
            url: '/courseEnroll.do',
            type: 'POST',
            data: {
                courseId: courseId
            },
            beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken); // CSRF 토큰 추가
            },
            success: function(response) {
                if (response.success) {
                    alert(response.message);
                    location.reload();
                } else {
                    alert('강좌 등록에 실패했습니다: ' + response.message);
                }
            },
            error: function() {
                alert('서버 오류가 발생했습니다. 나중에 다시 시도해 주세요.');
            }
        });
    });
});
</script>



  <%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
