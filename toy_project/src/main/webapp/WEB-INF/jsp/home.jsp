<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

    
<%@ include file="/WEB-INF/jsp/include/header.jsp" %>
	
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">나의 강좌</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/">메인 화면</a></li>
              <li class="breadcrumb-item active">나의 강좌</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12"> <!-- 전체 열 사용 -->
                    <div class="container mt-4">
                        <c:if test="${not empty message}">
                            <div class="alert alert-warning" role="alert">
                                ${message}
                            </div>
                        </c:if>

                        <c:if test="${empty message}">
                            <c:forEach var="course" items="${list}">
                                <!-- 강좌 항목 -->
                                <div class="card mb-3">
                                    <a href="${pageContext.request.contextPath}/course.do?id=${course.id}" class="text-decoration-none">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="mr-3">
                                                   <img src="${pageContext.request.contextPath}/${course.image_path}" 
                             alt="이미지 없음" 
                             class="img-circle" 
                             width="50" 
                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/question_mark.png';">
                                                </div>
                                                <div>
                                                    <h5 class="mb-1">${course.title}</h5>
                                                    <small class="text-muted">${course.instructor}</small>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <!-- /.card -->
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
        </div><!-- /.container-fluid -->
    </div>
    <!-- /.content -->
</div>
  <!-- /.content-wrapper -->

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
    <div class="p-3">
      <h5>Title</h5>
      <p>Sidebar content</p>
    </div>
  </aside>
  <!-- /.control-sidebar -->
  
  <%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
  