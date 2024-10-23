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

				<div class="card-tools">
					<button type="button" class="btn btn-tool"
						data-card-widget="collapse" title="Collapse">
						<i class="fas fa-minus"></i>
					</button>
					<button type="button" class="btn btn-tool"
						data-card-widget="remove" title="Remove">
						<i class="fas fa-times"></i>
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
							<th>점수</th>
							<th style="width: 8%" class="text-center">상태</th>
							<th style="width: 20%"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="test" items="${list}">
							<tr>
								<td>#</td>
								<td><a> ${test.name} </a> <br /> <small> <fmt:formatDate
											value="${test.start_time}" pattern="yyyy-MM-dd HH:mm" /> ~ <fmt:formatDate
											value="${test.end_time}" pattern="yyyy-MM-dd HH:mm" />
								</small></td>
								<td>
									<ul class="list-inline">
										<li class="list-inline-item"><img alt="Avatar"
											class="table-avatar" src="../../dist/img/avatar.png"></li>
										<li class="list-inline-item"><img alt="Avatar"
											class="table-avatar" src="../../dist/img/avatar2.png">
										</li>
									</ul>
								</td>
								<td class="project_progress">
									<div class="progress progress-sm">
										<div class="progress-bar bg-green" role="progressbar"
											aria-valuenow="47" aria-valuemin="0" aria-valuemax="100"
											style="width: 47%"></div>
									</div> <small> 47% Complete </small>
								</td>
								<td class="project-state"><span class="badge badge-success">
										${test.status} </span></td>
								<td class="project-actions text-right"><c:choose>
										<c:when test="${test.status == '작성중'}">
											<a class="btn btn-info btn-sm"
												href="/question/testEdit.do?testId=${test.id}"> <i
												class="fas fa-pencil-alt"></i> Edit
											</a>
										</c:when>
										<c:when test="${test.status == '완료'}">
											<a class="btn btn-primary btn-sm"
												href="/question/testView.do?testId=${test.id}"> <i
												class="fas fa-eye"></i> View
											</a>
										</c:when>
										<c:otherwise>
											<span class="badge badge-secondary">상태: ${test.status}</span>
										</c:otherwise>
									</c:choose> <a class="btn btn-danger btn-sm" href="#"
									onclick="confirmDelete(${test.id})"> <i class="fas fa-trash"></i> Delete
								</a></td>
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
			<button type="button" class="btn btn-success"
				onclick="location.href='testCreatePage.do?courseId='+${course.id}">시험
				생성</button>
		</div>

	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->

<script>
function confirmDelete(testId) {
    if (confirm('삭제하시겠습니까?')) {
        $.ajax({
            url: 'testDelete.do?id=' + testId, // 요청 URL
            type: 'DELETE', // 요청 메서드
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



<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>
