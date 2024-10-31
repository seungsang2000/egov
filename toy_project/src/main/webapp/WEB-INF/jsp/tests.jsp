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
                        <th style="width: 20%">시험 이름</th>
                        <th style="width: 30%">응시 인원</th>
                        <th>참여율</th>
                        <th style="width: 8%" class="text-center">상태</th>
                        <th style="width: 20%"></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="test" items="${list}">
                        <tr>
                            <td>#</td>
                            <td><a>${test.name}</a><br /><small>
                                <fmt:formatDate value="${test.start_time}" pattern="yyyy-MM-dd HH:mm" /> ~ 
                                <fmt:formatDate value="${test.end_time}" pattern="yyyy-MM-dd HH:mm" />
                            </small></td>
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
                                <div class="progress progress-sm">
                                    <div class="progress-bar bg-green" role="progressbar"
                                        aria-valuenow="${(test.user_count / totalStudent) * 100}" 
                                        aria-valuemin="0" 
                                        aria-valuemax="100"
                                        style="width: ${(test.user_count / totalStudent) * 100}%">
                                    </div>
                                </div>
                                <small>${test.user_count} / ${totalStudent} (${Math.round((test.user_count / totalStudent) * 100)}% Complete)</small>
                            </td>
                            <td class="project-state"><span class="badge badge-success">${test.status}</span></td>
                            <td class="project-actions text-right">
                                <c:choose>
                                    <c:when test="${test.status == '작성중'}">
                                        <a class="btn btn-info btn-sm" href="/question/testEdit.do?testId=${test.id}">
                                            <i class="fas fa-pencil-alt"></i> Edit
                                        </a>
                                    </c:when>
                                    <c:when test="${test.status == '완료'}">
                                        <a class="btn btn-primary btn-sm" href="/question/testView.do?testId=${test.id}">
                                            <i class="fas fa-eye"></i> View
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-secondary">상태: ${test.status}</span>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${test.is_scored}">
                                        <a class="btn btn-secondary btn-sm" href="#" disabled>
                                            <i class="fas fa-check-square"></i> 채점
                                        </a>
                                    </c:when>
                                    <c:when test="${currentTime.time >= test.start_time.time && currentTime.time >= test.end_time.time && test.status == '완료'}">
                                        <a class="btn btn-success btn-sm" href="#" onclick="confirmGrading(${test.id})">
                                            <i class="fas fa-check-square"></i> 채점
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="btn btn-danger btn-sm" href="#" onclick="confirmDelete(${test.id})">
                                            <i class="fas fa-trash"></i> 삭제
                                        </a>
                                    </c:otherwise>
                                </c:choose>
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
.user-section .user-count-container { /* 부모 클래스와 함께 사용 */
    display: flex;
    align-items: center; /* 아이템 수직 중앙 정렬 */
    font-size: 1.2rem; /* 기본 폰트 크기 */
    padding: 5px; /* 패딩 추가 */
}

.user-section .badge { /* 부모 클래스와 함께 사용 */
    font-size: 1rem; /* 배지 크기 조정 */
    margin-right: 5px; /* 배지 간격 조정 */
}

.user-section .separator { /* 부모 클래스와 함께 사용 */
    margin: 0 5px; /* 구분자 간격 조정 */
    font-weight: bold; /* 구분자 강조 */
}

.user-section .user-icon { /* 부모 클래스와 함께 사용 */
    margin-left: 10px; /* 사용자 아이콘 여백 */
    color: #007bff; /* 아이콘 색상 */
    font-size: 1.5rem; /* 아이콘 크기 조정 */
}

.user-section .check-icon { /* 부모 클래스와 함께 사용 */
    margin-left: 5px; /* 체크 아이콘 여백 */
    color: #28a745; /* 체크 아이콘 색상 */
    font-size: 1.5rem; /* 체크 아이콘 크기 조정 */
}
</style>


<script>
function confirmDelete(testId) {
    if (confirm('삭제하시겠습니까?')) {
        $.ajax({
            url: 'testDelete.do?id=' + testId, // 요청 URL
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

function confirmGrading(testId){
    if(confirm("채점을 시작하시겠습니까?")){
        $.ajax({
        	url: '/question/testGrading.do',
        	type: 'POST',
        	data: {id:testId},
        	beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-TOKEN', $('meta[name="_csrf"]').attr('content')); // CSRF 토큰 추가
            },
            success: function(result){
                alert('채점이 완료되었습니다.')
                window.location.reload();
            },
            error: function(xhr, status, error) {
                alert('채점이 실패했습니다: ' + xhr.responseText);
            }
        })
    }
    
    
    
}
</script>



<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>
