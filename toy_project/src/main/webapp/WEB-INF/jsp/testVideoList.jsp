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
					<h1>시험 영상 목록</h1>
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
            <a class="nav-link" href="/course.do?id=${course.id}">시험 목록</a> <!-- 시험 목록 페이지 -->
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/chat.do?id=${course.id}">소통</a> <!-- 소통 페이지 -->
        </li>
        <li class="nav-item">
            <a class="nav-link active" href="#" >시험영상</a> <!-- 소통 페이지 -->
        </li>
    </ul>
    <!-- Default box -->
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">${course.title}</h3>

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
                        <th style="width: 20%">유저명</th>
                        <th style="width: 30%">시험명</th>
                        <th>최종 수정시간</th>
                        <th style="width: 4%" class="text-center"></th>
                        <th style="width: 20%"></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="video" items="${videoFiles}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>
                            ${video.user_name}
                            
                            </td>
                            <td>
							${video.test_name}
                            </td>
                            <td class="project_progress">
								<p><script>document.write(new Date(${video.last_modified}).toLocaleString());</script></p>

                            </td>
                            <td class="project-state">

</td>
                            <td class="project-actions text-right">
								<a class="btn btn-warning btn-sm btn-custom" href="/viewTestVideo.do?courseId=${course.id}&userId=${video.user_id}&testId=${video.test_id}">
            						<i class="fas fa-eye"></i> 영상 확인
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

    <div class="d-flex justify-content-end mt-3">
        <!-- Flexbox를 사용하여 오른쪽 정렬 -->
        
        <c:if test="${is_instructor}">
        <button type="button" class="btn btn-success" onclick="location.href='testCreatePage.do?courseId='+${course.id}">시험 생성</button>
        </c:if>
    </div>

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


<script>



</script>



<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>
