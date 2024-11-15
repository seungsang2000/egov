<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

    
<%@ include file="/WEB-INF/jsp/include/header.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>마이페이지</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/">메인화면</a></li>
              <li class="breadcrumb-item active">마이페이지</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-3">

            <!-- Profile Image -->
            <div class="card card-primary card-outline">
              <div class="card-body box-profile">
                <div class="text-center">
                <img src="/${user.image_path}" 
                             alt="이미지 없음" 
                             class="profile-user-img img-fluid img-circle" 
                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/question_mark.png';">
				</div>

                <h3 class="profile-username text-center">${user.name}</h3>

                <c:choose>
    <c:when test="${user.role == 'admin'}">
        <p class="text-muted text-center">강사</p>
    </c:when>
    <c:when test="${user.role == 'user'}">
        <p class="text-muted text-center">학생</p>
    </c:when>
    <c:otherwise>
        <p class="text-muted text-center">역할 없음</p> <!-- 기본값 -->
    </c:otherwise>
</c:choose>

                <ul class="list-group list-group-unbordered mb-3">
                  <li class="list-group-item">
                     <a class="float-left">유저 ID</a> <b class="float-right">${user.user_id}</b> 
                  </li>
                  <li class="list-group-item">
                     <a class="float-left">유저 이름</a> <b class="float-right">${user.name}</b>
                  </li>
                  <li class="list-group-item">
                    <a class="float-left">이메일</a> <b class="float-right">${user.email}</b> 
                  </li>
                </ul>

                
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->

            <!-- About Me Box -->
            <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">강좌</h3>
              </div>
              <!-- /.card-header -->
<div class="card-body">
    <c:forEach var="course" items="${list}" varStatus="status">
        <strong>
            <a data-toggle="collapse" href="#collapse${status.index}" role="button" aria-expanded="false" aria-controls="collapse${status.index}">
                ${course.title}
            </a>
        </strong>

        <div class="collapse" id="collapse${status.index}">
            <p class="text-muted card-description">
                ${course.description}
            </p>
        </div>

        <c:if test="${!status.last}">
            <hr>
        </c:if>
    </c:forEach>
</div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
          <div class="col-md-9">
            <div class="card">
              <div class="card-header p-2">
                <ul class="nav nav-pills">
                  <li class="nav-item"><a class="active nav-link" href="#settings" data-toggle="tab">Settings</a></li>
                </ul>
              </div><!-- /.card-header -->
              <div class="card-body">
                <div class="tab-content">
                  <div class="active tab-pane" id="settings">
                    <form id="userProfileForm" class="form-horizontal" action="/user/updateUserProfile.do" method="post" onsubmit="return validateForm()" enctype="multipart/form-data">
                      <div class="form-group row">
                        <label for="inputName" class="col-sm-2 col-form-label">유저 이름</label>
                        <div class="col-sm-10">
                          <input type="text" class="form-control" id="inputName" placeholder="이름" name="name" value="${user.name}" required>
                        </div>
                      </div>
                      <div class="form-group row">
                        <label for="inputEmail" class="col-sm-2 col-form-label">이메일</label>
                        <div class="col-sm-10">
                          <input type="email" class="form-control" id="inputEmail" placeholder="이메일" name="email" value="${user.email}" required>
                        </div>
                      </div>
                      <div class="form-group row">
                        <label for="inputImage" class="col-sm-2 col-form-label">유저 이미지</label>
                        <div class="col-sm-10">
                        <!-- 파일 선택 버튼 -->
        
                        
                        <!-- 현재 이미지 미리보기 -->
        <div><img id="currentImage" src="/${user.image_path}" alt="현재 이미지" class="img-thumbnail" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/question_mark.png';" style="max-width: 100px; max-height: 100px; margin-bottom: 10px;">
        </div>
        <!-- 숨겨진 파일 입력 -->
        <input id="inputImage" type="file" name="uploadFile" class="d-none" accept="image/*">
        <div><button type="button" class="btn btn-primary" id="uploadButton">파일 선택</button></div>
        
        
                        
                        	</div>
                      </div>
                      <div class="form-group row">
                        <div class="offset-sm-2 col-sm-10">
                          <div class="checkbox">
                            <label>
                              <input type="checkbox" id="privacyAgreement"> 개인정보 변경에 동의합니다</a>
                            </label>
                          </div>
                        </div>
                      </div>
                      <div class="form-group row">
                        <div class="offset-sm-2 col-sm-10">
                          <button type="submit" class="btn btn-danger">개인정보 변경</button>
                        </div>
                      </div>
                    </form>
                  </div>
                  <!-- /.tab-pane -->
                </div>
                <!-- /.tab-content -->
              </div><!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>




<script>
function toggleDescription(element) {
    if (element.classList.contains("text-truncate")) {
      element.classList.remove("text-truncate");
      element.innerText = element.getAttribute("data-full-text"); // 전체 텍스트 표시
    } else {
      element.classList.add("text-truncate");
      element.innerText = element.getAttribute("data-short-text"); // 축소된 텍스트 표시
    }
  }

function validateForm() {
    const email = $('#inputEmail').val();
    const privacyAgreement = $('#privacyAgreement').is(':checked');

    // 이메일 형식 검사
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
        alert("유효한 이메일 주소를 입력해 주세요.");
        return false; // 폼 제출 방지
    }

    // 개인정보 동의 여부 검사
    if (!privacyAgreement) {
        alert("개인정보 변경에 동의해야 합니다.");
        return false; // 폼 제출 방지
    }

    // AJAX 요청
    $.ajax({
        url: '/user/updateUserProfile.do',
        type: 'POST',
        data: new FormData($('#userProfileForm')[0]), // FormData 객체로 폼 데이터 전송
        beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-TOKEN', $('meta[name="_csrf"]').attr('content')); // CSRF 토큰 추가
        },
        contentType: false,
        processData: false,
        success: function(response) {
            if (response.success) {
                alert("개인정보가 성공적으로 변경되었습니다.");
                location.reload(); // 페이지 새로고침
            } else {
                alert(response.message); // 에러 메시지 표시
            }
        },
        error: function(xhr, status, error) {
            alert("오류가 발생했습니다: " + error);
        }
    });

    return false;
}

document.addEventListener('DOMContentLoaded', function() {
    const inputImage = document.getElementById('inputImage');
    const uploadButton = document.getElementById('uploadButton');
    const currentImage = document.getElementById('currentImage');

    
    inputImage.value = '';

    
    uploadButton.addEventListener('click', function() {
        inputImage.click();
    });

   
    inputImage.addEventListener('change', function(event) {
        if (inputImage.files && inputImage.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                currentImage.src = e.target.result;
            }
            reader.readAsDataURL(inputImage.files[0]);
        }
    });
});
</script>






  <%@ include file="/WEB-INF/jsp/include/footer.jsp" %>