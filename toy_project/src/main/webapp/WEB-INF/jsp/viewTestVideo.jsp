<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
					<h1>시험 영상 보기</h1>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="/testVideo.do?id=${courseId}">시험 영상 목록</a></li>
						<li class="breadcrumb-item active">시험 영상 보기</li>
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
            <a class="nav-link" href="/course.do?id=${courseId}">시험 목록</a> <!-- 시험 목록 페이지 -->
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/chat.do?id=${courseId}">소통</a> <!-- 소통 페이지 -->
        </li>
        <li class="nav-item">
            <a class="nav-link active" href="#" >시험영상</a> <!-- 소통 페이지 -->
        </li>
    </ul>
      <!-- Default box -->
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">시험 영상 보기</h3>

          <div class="card-tools">
            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
              <i class="fas fa-minus"></i>
            </button>
          </div>
        </div>
        <div class="card-body">
          <div class="row">
            <div class="col-12 col-md-12 col-lg-8 order-2 order-md-1">
              <div class="row">



              </div>
              <div class="row">
                <div class="col-12">
                  <h4>시험 화면</h4>
<video
  id="my-video"
  class="video-js"
  controls
  preload="metadata"
  width="640"
  height="264"
  data-setup='{"autoplay" : false, "controls": true}'>
  <source src="${videoUrl}" type="video/webm" />
  <p class="vjs-no-js">
    To view this video please enable JavaScript, and consider upgrading to
    a web browser that
    <a href="https://www.google.com/intl/en/chrome/">supports HTML5 video</a>
  </p>
</video>
<br>
<h2>정지 위치</h2>
<ul>
    <c:if test="${not empty examParticipation.pause_positions}">
        <c:forEach var="position" items="${examParticipation.pause_positions}">
            <li><a href="javascript:void(0);" onclick="seekToPosition('${position}')">${position}</a></li>
        </c:forEach>
    </c:if>
    <c:if test="${empty examParticipation.pause_positions}">
        <li>정지된 기록이 없는 영상입니다</li>
    </c:if>
</ul>
                </div>
              </div>
            </div>
            <div class="col-12 col-md-12 col-lg-4 order-1 order-md-2">
              <h3 class="text-primary"><i class="fas fa-paint-brush"></i>${test.name}</h3>
              <p class="text-muted">테스트 설명
                  <b class="d-block user-name">${test.description}</b>
                </p>
              <br>
              <div class="text-muted">
              <p class="text-sm">유저 프로필
                  <b class="d-block"><img src="/${user.image_path}" 
                             alt="이미지 없음" 
                             class="table-avatar profile-image img-circle" 
                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/question_mark.png';">
                </b>
                </p>
                <p class="text-sm">유저명
                  <b class="d-block user-name">${user.name}</b>
                </p>
                
                <p class="text-sm">최종 수정시간
                  <b class="d-block user-name">${lastModified}</b>
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
<!-- /.content -->
</div>
<!-- /.content-wrapper -->


<style>
.table-avatar {
    max-width: 100px;  
    max-height: 100px;
    width: auto;     
    height: auto;     
    object-fit: cover; 
}

.user-name {
    font-size: 1.2em;
    font-weight: bold; 
    color: #333; 
       margin-top: 5px; 
    margin-bottom: 5px; 
</style>


<script>
var player = videojs('my-video', {
    controls: true,
    autoplay: false,
    preload: 'auto'
  });
  
//시:분:초 형식을 초 단위로 변환하는 함수
function convertTimeToSeconds(timeString) {
    var timeParts = timeString.split(":");
    var hours = parseInt(timeParts[0], 10); // 시간
    var minutes = parseInt(timeParts[1], 10); // 분
    var seconds = parseInt(timeParts[2], 10); // 초

    // 시 * 3600 + 분 * 60 + 초로 변환
    return (hours * 3600) + (minutes * 60) + seconds;
}

// 영상 이동 함수
function seekToPosition(position) {
    var positionInSeconds = convertTimeToSeconds(position); // 시:분:초를 초로 변환
    player.currentTime(positionInSeconds); // 주어진 시간(초)으로 이동
    player.play(); // 이동 후 재생 시작
}
</script>



<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>
