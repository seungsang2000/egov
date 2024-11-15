<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>TESTHub | 회원가입</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="/resources/plugins/fontawesome-free/css/all.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="/resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/resources/dist/css/adminlte.min.css">
</head>
<body class="hold-transition register-page">
<div class="register-box">
  <div class="card card-outline card-primary">
    <div class="card-header text-center">
      <a href="/" class="h1"><b>TEST</b>Hub</a>
    </div>
    <div class="card-body">
      <p class="login-box-msg">회원 정보를 입력해주세요</p>

      <form action="/user/register.do" method="post">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div class="input-group mb-3">
          <input type="text" class="form-control" name="username" placeholder="유저 이름" required>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-user"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="text" class="form-control" id="userId" name="user_id" placeholder="유저 아이디" required>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-user-tag"></span>
            </div>
          </div>
        </div>
        <div id="userIdResult" class="text-danger mb-3"></div>
        <div class="input-group mb-3">
          <input type="password" class="form-control" name="password" placeholder="비밀번호" required>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="password" class="form-control" name="confirmPassword" placeholder="비밀번호 확인" required>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="email" class="form-control" name="email" placeholder="이메일" required>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-envelope"></span>
            </div>
          </div>
        </div>
        <div id="userEmailResult" class="text-danger mb-3"></div>
        <div class="input-group mb-3">
          <select class="form-control" name="role" required>
            <option value="">사용자 역할 선택</option>
            <option value="user">일반 사용자</option>
            <option value="admin">강사</option>
          </select>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-user-shield"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-8">
            <div class="icheck-primary">
              <input type="checkbox" id="agreeTerms" name="terms" value="agree">
              <label for="agreeTerms">
              <a href="#">개인정보 수집</a>에 동의합니다
              </label>
            </div>
          </div>
          <div class="col-4">
            <button type="submit" class="btn btn-primary btn-block">회원 가입</button>
          </div>
        </div>
      </form>

      <a href="/user/login.do" class="text-center">이미 회원가입되어 있음</a>
    </div>
  </div><!-- /.card -->
</div><!-- /.register-box -->

<!-- jQuery -->
<script src="/resources/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="/resources/dist/js/adminlte.min.js"></script>

<script>

/* function isValidUserId(userId) {
    const regex = /^[a-zA-Z0-9]+$/; // 영어 대소문자와 숫자만 허용
    return regex.test(userId);
} */

function isValidUserId(userId) {
    const regex = /^[a-zA-Z0-9]{4,}$/; // 영어 대소문자, 숫자만 포함하고, 최소 4글자 이상
    return regex.test(userId);
}

function isValidPassword(password) {
    const passwordRegex = /^[a-zA-Z0-9]{4,}$/; // 영문자와 숫자로만 이루어져 있고, 최소 4글자
    return passwordRegex.test(password);
}

$(document).ready(function() {
    let isUserIdValid = false;
    let isEmailValid = false; // 이메일 유효성 검사를 위한 변수
    let isPasswordValid = false;
    var csrfToken = $("input[name='_csrf']").val();
    var csrfHeader = "X-CSRF-TOKEN"; // 기본 CSRF 헤더 이름

    // 유저 아이디 검사
    $('#userId').on('blur', function() {
        var userId = $(this).val();
        if (userId) {
            // 유효성 검사
            if (!isValidUserId(userId)) {
                $('#userIdResult').text('유저 아이디는 최소 4글자 이상의 영어와 숫자로 이루어져야합니다. ').removeClass('text-success').addClass('text-danger').show();
                isUserIdValid = false;
                return; // 유효하지 않으면 AJAX 요청을 중단
            }
            $.ajax({
                url: '/user/checkId.do',
                method: 'GET',
                data: { userId: userId },
                success: function(response) {
                    if (response.exists) {
                        $('#userIdResult').text('중복되는 유저 아이디입니다.').removeClass('text-success').addClass('text-danger').show(); // 붉은색
                        isUserIdValid = false; // 중복 아이디
                    } else {
                        $('#userIdResult').text('사용 가능한 유저 아이디입니다.').removeClass('text-danger').addClass('text-success').show(); // 녹색
                        isUserIdValid = true; // 사용 가능한 아이디
                    }
                },
                error: function() {
                    $('#userIdResult').text('서버 오류가 발생했습니다.').show();
                    isUserIdValid = false;
                }
            });
        } else {
            $('#userIdResult').hide();
            isUserIdValid = false;
        }
    });

    // 이메일 검사
    $('input[name="email"]').on('blur', function() {
        var email = $(this).val();
        var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        if (email) {
            // 이메일 유효성 검사
            if (!emailPattern.test(email)) {
                $('#userEmailResult').text('유효한 이메일 주소를 입력해 주세요.').removeClass('text-success').addClass('text-danger').show();
                isEmailValid = false;
                return; // 유효하지 않으면 AJAX 요청을 중단
            }

            $.ajax({
                url: '/user/checkEmail.do',
                method: 'GET',
                data: { email: email },
                
                success: function(response) {
                    if (response.exists) {
                        $('#userEmailResult').text('중복되는 이메일입니다.').removeClass('text-success').addClass('text-danger').show(); // 붉은색
                        isEmailValid = false; // 중복 이메일
                    } else {
                        $('#userEmailResult').text('사용 가능한 이메일입니다.').removeClass('text-danger').addClass('text-success').show(); // 녹색
                        isEmailValid = true; // 사용 가능한 이메일
                    }
                },
                error: function() {
                    $('#userEmailResult').text('서버 오류가 발생했습니다.').show();
                    isEmailValid = false;
                }
            });
        } else {
            $('#userEmailResult').hide();
            isEmailValid = false;
        }
    });
    
    $('input[name="password"]').on('blur', function() {
        var password = $(this).val();
        if (!isValidPassword(password)) {
            $('#passwordResult').text('비밀번호는 최소 4글자 이상이어야 합니다.').removeClass('text-success').addClass('text-danger').show();
            isPasswordValid = false;
        } else {
            $('#passwordResult').text('').hide();
            isPasswordValid = true;
        }
    });


    // 폼 제출 처리
    $('form').on('submit', function(event) {
        
        event.preventDefault();
        
        var password = $('input[name="password"]').val();
        var confirmPassword = $('input[name="confirmPassword"]').val();
        var agreeTerms = $('#agreeTerms').is(':checked');

        
        
        // 비밀번호 확인 검사
        if (!isValidPassword(password) || password !== confirmPassword) {
            alert('비밀번호는 4글자 이상이어야 하며, 비밀번호가 일치해야 합니다.');
            return false;
        }


        // 개인정보 수집 동의 여부 확인
        if (!agreeTerms) {
            alert('개인정보 수집에 동의해야 합니다.');
            return false;
        }

        // 유저 아이디 중복 여부 확인
        if (!isUserIdValid) {
            alert('유저 아이디가 유효하지 않습니다.');
            return false;
        }

        // 이메일 중복 여부 확인
        if (!isEmailValid) {
            alert('이메일이 유효하지 않습니다. 중복 확인을 해주세요.');
            return false; // 폼 제출 방지
        }

        $('form').on('submit', function(event) {
            event.preventDefault();

            var formData = $(this).serializeArray();
            var jsonData = {};

            // 배열을 객체로 변환
            $.map(formData, function(n) {
                jsonData[n.name] = n.value;
            });

            $.ajax({
                url: '/user/register.do',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(jsonData), // JSON 형식으로 변환
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 토큰 추가
                },
                success: function(response) {
                    if (response.success) {
                        alert('회원가입 성공! ');
                        window.location.href = '/user/login.do'; // 로그인 페이지로 리다이렉트
                    } else {
                        alert('회원가입 실패: ' + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    console.error("서버 오류:", status, error);
                    alert('서버와의 연결에 문제가 발생했습니다.');
                }
            });
        });
    });
});
</script>
</body>
</html>