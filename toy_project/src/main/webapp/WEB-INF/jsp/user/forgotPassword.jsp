<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    	<meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>TESTHub | 비밀번호를 잊었습니다</title>

    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="/resources/plugins/fontawesome-free/css/all.min.css">
    <!-- icheck bootstrap -->
    <link rel="stylesheet" href="/resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="/resources/dist/css/adminlte.min.css">
</head>
<body class="hold-transition login-page">
    <div class="login-box">
        <div class="card card-outline card-primary">
            <div class="card-header text-center">
                <a href="/" class="h1"><b>Test</b>Hub</a>
            </div>
            <div class="card-body">
                <p class="login-box-msg">비밀번호를 잊으셨습니까? 이메일을 이용하여 복구시켜 드리겠습니다</p>
                <form id="emailForm">
                    <div class="input-group mb-3">
                        <input type="email" class="form-control" name="email" id="email" placeholder="이메일" required>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-envelope"></span>
                            </div>
                        </div>
                    </div>

                    <div class="input-group mb-3" id="authKeyDiv" style="display: none;">
                        <input type="text" class="form-control" id="authKey" name="authKey" placeholder="인증키">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-key"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <button type="button" id="sendEmailBtn" class="btn btn-primary btn-block">이메일 인증</button>
                            <button type="button" id="verifyKeyBtn" class="btn btn-success btn-block" style="display: none;">인증키 확인</button>
                        </div>
                    </div>
                </form>
                <p class="mt-3 mb-1">
                    <a href="/user/login.do">로그인</a>
                </p>
                <p class="mb-0">
                    <a href="/user/register.do" class="text-center">회원가입</a>
                </p>
            </div>
            <!-- /.login-card-body -->
        </div>
    </div>
    <!-- /.login-box -->

    <!-- jQuery -->
    <script src="/resources/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="/resources/dist/js/adminlte.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#sendEmailBtn').on('click', function () {
                var email = $('input[name="email"]').val();
                var sendEmailBtn = $('#sendEmailBtn');

                // 이메일 유효성 검사
                var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                if (!emailPattern.test(email)) {
                    alert('유효한 이메일 주소를 입력해 주세요.');
                    return false; // 폼 제출 방지
                }

                sendEmailBtn.prop('disabled', true);

                // AJAX 요청
                $.ajax({
                    url: '/user/emailCheck.do',
                    type: 'POST',
                    data: {
                        email: email
                    },
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader('X-CSRF-TOKEN', $('meta[name="_csrf"]').attr('content')); // CSRF 토큰 추가
                    },
                    success: function (response) {
                        if (response.success) {
                            // 인증키 입력 필드 표시
                            $('#authKeyDiv').show();
                            $('#sendEmailBtn').hide(); // 이메일 인증 버튼 숨기기
                            $('#verifyKeyBtn').show(); // 인증키 확인 버튼 표시
                            $("#authKey").attr('required', true);
                            $("#email").attr('readonly', true);
                            alert('인증키가 이메일로 전송되었습니다.');
                        } else {
                            alert('이메일 발송에 실패했습니다: ' + response.message);
                        }
                    },
                    error: function () {
                        alert('서버 오류가 발생했습니다. 나중에 다시 시도해 주세요.');
                    },
                    complete: function () {
                        // 버튼 다시 활성화
                        sendEmailBtn.prop('disabled', false);
                    }
                });
            });

            // 인증키 확인 버튼 클릭 시 처리
            $('#verifyKeyBtn').on('click', function () {
                var inputKey = $('#authKey').val();
                var inputEmail = $('#email').val();

                // 인증키 유효성 검사
                if (!inputKey) {
                    alert('인증키를 입력해 주세요.');
                    return; // 입력이 없으면 요청하지 않음
                }

                $.ajax({
                    url: '/user/verifyAuthKey.do',
                    type: 'POST',
                    data: {
                        inputKey: inputKey,
                        email: inputEmail
                    },
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader('X-CSRF-TOKEN', $('meta[name="_csrf"]').attr('content')); // CSRF 토큰 추가
                    },
                    success: function (response) {
                        if (response.success) {
                            alert(response.message);
                            window.location.href = '/user/resetPassword.do';
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function () {
                        alert('서버 오류가 발생했습니다. 나중에 다시 시도해 주세요.');
                    }
                });
            });
        });
    </script>
</body>
</html>