<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${courseDetail.title}</title>
      <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="/resources/plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/resources/dist/css/adminlte.min.css">
  
  <!-- REQUIRED SCRIPTS -->

<!-- jQuery -->
<script src="/resources/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="/resources/dist/js/adminlte.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<!-- ChartJS -->
<script src="/resources/plugins/chart.js/Chart.min.js"></script>

    <style>
    .profile-image {
        width: 100px; 
        height: auto; 
        border-radius: 50%; 
    }
</style>
</head>
<body>
<section class="content">

      <!-- Default box -->
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">Projects Detail</h3>

          <div class="card-tools">
            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
              <i class="fas fa-minus"></i>
            </button>
            <button type="button" class="btn btn-tool" data-card-widget="remove" title="Remove">
              <i class="fas fa-times"></i>
            </button>
          </div>
        </div>
        <div class="card-body">
          <div class="row">
            <div class="col-12 col-md-12 col-lg-8 order-2 order-md-1">
              <div class="row">
                <div class="col-12 col-sm-4">
                  <div class="info-box bg-light">
                    <div class="info-box-content">
                      <span class="info-box-text text-center text-muted">최대 수강생 수</span>
                      <span class="info-box-number text-center text-muted mb-0">${courseDetail.max_students}</span>
                    </div>
                  </div>
                </div>
                <div class="col-12 col-sm-4">
                  <div class="info-box bg-light">
                    <div class="info-box-content">
                      <span class="info-box-text text-center text-muted">현재 수강생 수</span>
                      <span class="info-box-number text-center text-muted mb-0">${courseDetail.studentCount}</span>
                    </div>
                  </div>
                </div>
                <div class="col-12 col-sm-4">
                  <div class="info-box bg-light">
                    <div class="info-box-content">
                      <span class="info-box-text text-center text-muted">수강 비율</span>
                      <span class="info-box-number text-center text-muted mb-0">${Math.round((courseDetail.studentCount / courseDetail.max_students) * 100)}%</span>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-12">
                  <h4>최근 테스트</h4>
                  <c:forEach var="test" items="${testList}">
                    <div class="post">
                      <div class="user-block">
                        <span class="username"  style="margin-left: 0;">
                          <a href="#">${test.name }</a>
                        </span>
                        <span class="description"  style="margin-left: 0;"><fmt:formatDate value="${test.start_time}" pattern="yyyy-MM-dd HH:mm" /> ~ 
                                <fmt:formatDate value="${test.end_time}" pattern="yyyy-MM-dd HH:mm" /></span>
                      </div>
                      <!-- /.user-block -->
                      <p>
                        ${test.description}
                      </p>
                    </div>
                    </c:forEach>
                </div>
              </div>
            </div>
            <div class="col-12 col-md-12 col-lg-4 order-1 order-md-2">
              <h3 class="text-primary"><i class="fas fa-paint-brush"></i>${courseDetail.title}</h3>
              <p class="text-muted">${courseDetail.description}</p>
              <br>
              <div class="text-muted">
              <p class="text-sm">강좌 프로필
                  <b class="d-block"><img src="/${courseDetail.course_image_path}" 
                             alt="이미지 없음" 
                             class="table-avatar profile-image" 
                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/question_mark.png';">
                </b>
                </p>
                <p class="text-sm">강사
                <b class="d-block"><img src="/${courseDetail.user_image_path}" 
                             alt="이미지 없음" 
                             class="table-avatar profile-image" 
                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/question_mark.png';">
                </b>
                  <b class="d-block" style=" padding-left: 28px;">${courseDetail.instructor}</b>
                </p>
                
              </div>

              <div class="text-center mt-5 mb-3">
              </div>
            </div>
          </div>
        </div>
        <!-- /.card-body -->
      </div>
      <!-- /.card -->

    </section>

</body>
</html>