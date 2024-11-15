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
                            <th>신청현황</th>
                            <th style="width: 8%" class="text-center">상태</th>
                            <th style="width: 20%"></th>
                        </tr>
                    </thead>
                    <tbody>
<c:choose>
    <c:when test="${empty courseList}">
        <tr>
            <td colspan="8" class="text-center">검색 결과가 없습니다.</td>
        </tr>
    </c:when>
    <c:otherwise>
        <c:forEach var="course" items="${courseList}" varStatus="status">
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
                <td>
                    <i class="fas fa-user-friends" style="margin-right: 5px; color: #007bff;"></i>
                    <span style="color: #333;">${course.studentCount} / ${course.max_students}명</span>
                </td>
                <td class="project_progress">
                    <div class="progress progress-sm">
                        <div class="progress-bar bg-green" role="progressbar" 
                             aria-valuenow="${course.studentCount / course.max_students * 100}" 
                             aria-valuemin="0" 
                             aria-valuemax="100" 
                             style="width: ${course.studentCount / course.max_students * 100}%">
                        </div>
                    </div>
                    <small>${Math.round((course.studentCount / course.max_students) * 100)}% 신청</small>
                </td>
                <td class="project-state">
                    <span class="badge ${course.status == '비공개' ? 'badge-danger' : 'badge-success'}">${course.status}</span>
                </td>
                <td class="project-actions text-right">
                    <a class="btn btn-info btn-sm" href="/courseEdit.do?courseId=${course.id}">
                        <i class="fas fa-pencil-alt"></i> 수정
                    </a>
                    <a class="btn btn-danger btn-sm" href="#" onclick="confirmDelete(${course.id})">
                        <i class="fas fa-trash"></i> 삭제
                    </a>
                </td>
            </tr>
        </c:forEach>
    </c:otherwise>
</c:choose>
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
function confirmDelete(courseId) {
    if (confirm('삭제하시겠습니까?')) {
        $.ajax({
            url: '/courseDelete.do?id=' + courseId, // 요청 URL
            type: 'DELETE', // 요청 메서드
            beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-TOKEN', $('meta[name="_csrf"]').attr('content')); // CSRF 토큰 추가
            },
            success: function(result) {
                alert('삭제되었습니다.');
                window.location.reload(); // 페이지 새로고침
            },
            error: function(xhr, status, error) {
                alert('삭제에 실패했습니다: ' + xhr.responseText);
            }
        });
    }
}

</script>


  <%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
