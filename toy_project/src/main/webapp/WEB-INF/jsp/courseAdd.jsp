<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


    
<%@ include file="/WEB-INF/jsp/include/header.jsp" %>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>강좌 생성</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/">메인 화면</a></li>
              <li class="breadcrumb-item active">강좌 생성</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
    <form action="courseCreate.do" method="post" enctype="multipart/form-data">
   <%--  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
   <sec:csrfInput/>
      <div class="row">
        <div class="col-md-6">
          <div class="card card-primary">
            <div class="card-header">
              <h3 class="card-title">강좌 생성</h3>

              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                  <i class="fas fa-minus"></i>
                </button>
              </div>
            </div>
            <div class="card-body">
              <div class="form-group">
                <label for="inputName">강좌 이름</label>
                <input type="text" id="inputName" name="title" class="form-control" required>
              </div>
              <div class="form-group">
                <label for="inputDescription">강좌 설명</label>
                <textarea id="inputDescription" name="description" class="form-control" rows="5"  required></textarea>
              </div>
              <div class="form-group">
                <label for="inputStatus">공개 여부</label>
                <select id="inputStatus" name="status" class="form-control custom-select" required>
                  <option>공개</option>
                  <option>비공개</option>
                </select>
              </div>
              <div class="form-group">
        			<label for="inputImage">이미지 업로드</label>
        			<div><img id="currentImage" src="/${course.image_path}" alt="현재 이미지" class="img-thumbnail mb-2" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/question_mark.png';" style="max-width: 100px; max-height: 100px;">
    </div>
    <!-- 숨겨진 파일 입력 -->
    <input id="inputImage" type="file" name="uploadFile" class="d-none" accept="image/*">
    
    <!-- 파일 선택 레이블 -->
    <div><label for="inputImage" class="btn btn-primary mt-2" style="cursor: pointer;">파일 선택</label></div>
   			 </div>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>
        <div class="col-md-6">
          <div class="card card-secondary">
            <div class="card-header">
              <h3 class="card-title">기타</h3>

              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                  <i class="fas fa-minus"></i>
                </button>
              </div>
            </div>
            <div class="card-body">
              <div class="form-group">
                <label for="inputEstimatedBudget">수강 가능한 학생수</label>
                <input type="number" id="inputEstimatedBudget" class="form-control" name="max_students" required min="1" step="1" oninput="this.value = this.value.replace(/[^0-9]/g, '')" value=10>
              </div>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>
      </div>
      <div class="row">
        <div class="col-12">
          <a href="/" class="btn btn-secondary">Cancel</a>
          <input type="submit" value="강좌 생성" class="btn btn-success float-right">
        </div>
      </div>
      </form>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Control Sidebar -->

  <script>
  document.addEventListener('DOMContentLoaded', function() {
      const inputImage = document.getElementById('inputImage');
      const currentImage = document.getElementById('currentImage');

      // 파일 입력 변경 시 미리보기 업데이트
      inputImage.addEventListener('change', function(event) {
          if (inputImage.files && inputImage.files[0]) {
              const reader = new FileReader();
              reader.onload = function(e) {
                  currentImage.src = e.target.result; // 업로드한 이미지로 미리보기 업데이트
              }
              reader.readAsDataURL(inputImage.files[0]); // 파일을 읽어서 Data URL로 변환
          }
      });
  });
  </script>

  <!-- /.control-sidebar -->
  <%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
