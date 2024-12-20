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
            <h1>강좌 등록</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/">메인 화면</a></li>
              <li class="breadcrumb-item active">강좌 등록</li>
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
                            <th style="width: 15%">강사</th>
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
                        <c:forEach var="course" items="${courseList}"  varStatus="status">
    <tr>
        <td>${status.index + 1}</td>
        <td>
            <a>${course.title}</a>
            <br/>
            <small>Created <fmt:formatDate value="${course.created_at}" pattern="yyyy-MM-dd" /></small>
        </td>
        <td >
            <ul class="list-inline">
                <li class="list-inline-item">
                <img src="/${course.instructor_image}" 
                             alt="이미지 없음" 
                             class="table-avatar" 
                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/question_mark.png';">
                </li>
            </ul>
            <small>${course.instructor}</small>
        </td>
        <td><i class="fas fa-user-friends" style="margin-right: 5px; color: #007bff;"></i>
    <span style="color: #333;">${course.studentCount} / ${course.max_students}명</span></td>
        <td class="project_progress">
    <div class="progress progress-sm">
        <div class="progress-bar bg-green" role="progressbar" aria-valuenow="${course.studentCount / course.max_students * 100}" aria-valuemin="0" aria-valuemax="100" style="width: ${course.studentCount / course.max_students * 100}%">
        </div>
    </div>
    <small>${Math.round((course.studentCount / course.max_students) * 100)}% 신청</small>
</td>
        <td class="project-state">
            <span class="badge ${course.status == '비공개' ? 'badge-danger' : 'badge-success'}">${course.status}</span>
        </td>
        <td class="project-actions text-right">
            <a class="btn btn-primary btn-sm" href="#" onclick="openCourseDetail(${course.id}); return false;">
    <i class="fas fa-folder"></i>
    강좌 정보
</a>
            <c:choose>
        <c:when test="${course.status == '비공개'}">
            <a class="btn btn-danger btn-sm" href="#" disabled>
                <i class="fas fa-pencil-alt"></i>
                신청 불가
            </a>
        </c:when>
        <c:when test="${course.enrolled}">
            <button class="btn btn-secondary btn-sm" disabled>
                <i class="fas fa-check"></i>
                이미 등록
            </button>
        </c:when>
        <c:when test="${course.studentCount >= course.max_students}">
            <button class="btn btn-danger btn-sm" disabled>
                <i class="fas fa-times"></i>
                정원 초과
            </button>
        </c:when>
        <c:otherwise>
            <c:if test="${course.studentCount < course.max_students}">
                <button class="btn btn-info btn-sm enroll-button" data-course-id="${course.id}">
                    <i class="fas fa-pencil-alt"></i>
                    등록 신청
                </button>
            </c:if>
        </c:otherwise>
    </c:choose>
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
  $(document).ready(function() {
      $('.enroll-button').on('click', function() {
          var courseId = $(this).data('course-id');
          var csrfToken = $('meta[name="_csrf"]').attr('content');
          
          // 시험 여부 확인 요청
          $.ajax({
              url: '/checkExamInCourse.do',
              type: 'POST',
              data: {
                  courseId: courseId
              },
              beforeSend: function(xhr) {
                  xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken);
              },
              success: function(response) {
                  if (response.examExists) {
                      // 시험이 있을 경우 확인 메시지
                      if (!confirm("이 강좌에는 이미 완료된 시험이 존재합니다. 지금 등록시 점수 불이익을 받을 수 있습니다. 괜찮으시겠습니까?")) {
                          return; // 취소하면 등록 중지
                      }
                  }
                  enrollCourse(courseId, csrfToken); // 강좌 등록 함수 호출
              },
              error: function() {
                  alert('서버 오류가 발생했습니다. 나중에 다시 시도해 주세요.');
              }
          });
      });
  });

  function enrollCourse(courseId, csrfToken) {
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
  }

function openCourseDetail(courseId) {
    const width = 1200; // 너비
    const height = 800; // 높이
    const left = Math.max(0, (screen.width - width) / 2);
    const top = Math.max(0, (screen.height - height) / 2);

    window.open('/courseDetail.do?courseId=' + courseId, 'CourseDetail', 'width='+width+',height='+height+',top='+top+',left='+left);
}
</script>



  <%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
