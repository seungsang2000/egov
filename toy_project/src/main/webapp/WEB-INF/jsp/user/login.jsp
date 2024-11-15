<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="_csrf" content="${_csrf.token}"/>
   <meta name="_csrf_header" content="${_csrf.headerName}"/>
  <title>TESTHub | 로그인</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="/resources/plugins/fontawesome-free/css/all.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="/resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/resources/dist/css/adminlte.min.css">
</head>
<body class="hold-transition login-page">
<div class="login-box">
  <!-- /.login-logo -->
  <div class="card card-outline card-primary">
    <div class="card-header text-center">
      <a href="/" class="h1"><b>Test</b>Hub</a>
    </div>
    <div class="card-body">
      <p class="login-box-msg">서비스 이용을 위해 로그인해주세요</p>

      <form action="/user/login.do" method="post" id="loginForm">
        <div class="input-group mb-3">
          <input type="text" class="form-control" name="user_id" placeholder="아이디">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-user-tag"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="password" class="form-control" name="password" placeholder="비밀번호">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-8">
            <div class="icheck-primary">
              <input type="checkbox" id="remember" name="remember-me">
              <label for="remember">
                자동 로그인
              </label>
            </div>
          </div>
          <!-- /.col -->
          <div class="col-4">
            <button type="submit" class="btn btn-primary btn-block">로그인</button>
          </div>
          <!-- /.col -->
        </div>
      </form>
      
      <!-- /.social-auth-links -->

      <p class="mb-1">
        <a href="/user/forgotPassword.do">비밀번호를 잊었습니다</a>
      </p>
      <p class="mb-0">
        <a href="/user/register.do" class="text-center">회원 가입</a>
      </p>
    </div>
    <!-- /.card-body -->
  </div>
  <!-- /.card -->
</div>
<!-- /.login-box -->

<!-- jQuery -->
<script src="/resources/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="/resources/dist/js/adminlte.min.js"></script>
<script>
$(document).ready(function() {
    $('#loginForm').on('submit', function(event) {
        event.preventDefault(); // 기본 제출 방지

        var userId = $('input[name="user_id"]').val();
        var password = $('input[name="password"]').val();
        var rememberMe = $('#remember').is(':checked');

        const idPasswordRegex = /^[a-zA-Z0-9]{4,}$/;
        
        // 유효성 검사
        if (!userId || !password) {
            alert('아이디와 비밀번호를 입력해 주세요.');
            return;
        }
        
        if (!userId || !idPasswordRegex.test(userId)) {
            alert('아이디는 영문자와 숫자로만 이루어져야 하며, 최소 4글자 이상이어야 합니다.');
            return;
        }

        if (!password || !idPasswordRegex.test(password)) {
            alert('비밀번호는 영문자와 숫자로만 이루어져야 하며, 최소 4글자 이상이어야 합니다.');
            return;
        }

        // AJAX 요청
        $.ajax({
            url: '/user/login.do',
            method: 'POST',
            data: {
                user_id: userId,
                password: password,
                'remember-me': rememberMe // 쉼표 추가
            },
            beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-TOKEN', $('meta[name="_csrf"]').attr('content')); // CSRF 토큰 추가
            },
            success: function(response) {
                // 로그인 성공 시 처리
                if (response.success) {
                    window.location.href = '/'; // 로그인 성공 후 이동할 페이지
                } else {
                    alert('아이디 또는 비밀번호가 올바르지 않습니다.');
                }
            },
            error: function() {
                alert('서버 오류가 발생했습니다. 나중에 다시 시도해 주세요.');
            }
        });
    });
});
</script>
</body>
</html>
