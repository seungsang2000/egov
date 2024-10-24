<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    	<meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>비밀번호 재설정</title>
    <link rel="stylesheet" href="/resources/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="/resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <link rel="stylesheet" href="/resources/dist/css/adminlte.min.css">
</head>
<body class="hold-transition login-page">
    <div class="login-box">
        <div class="card card-outline card-primary">
            <div class="card-header text-center">
                <a href="/" class="h1"><b>Test</b>Hub</a>
            </div>
            <div class="card-body">
                <p class="login-box-msg">새 비밀번호를 입력하세요</p>
                <form id="resetPasswordForm">
                    <div class="input-group mb-3">
                        <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="새 비밀번호" required>
                    </div>
                    <div class="input-group mb-3">
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인" required>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <button type="submit" id="resetPasswordBtn" class="btn btn-primary btn-block">비밀번호 재설정</button>
                        </div>
                    </div>
                </form>
                <p class="mt-3 mb-1">
                    <a href="/user/login.do">로그인</a>
                </p>
            </div>
        </div>
    </div>

    <script src="/resources/plugins/jquery/jquery.min.js"></script>
    <script>
    $(function() {
        $('#resetPasswordForm').on('submit', function(event) {
            event.preventDefault();

            var newPassword = $('#newPassword').val();
            var confirmPassword = $('#confirmPassword').val();

            if (newPassword !== confirmPassword) {
                alert('비밀번호가 일치하지 않습니다.');
                return;
            }

            $.ajax({
                url: '/user/resetPassword.do',
                type: 'POST',
                data: {
                    newPassword: newPassword
                },
                beforeSend: function(xhr) {
                    xhr.setRequestHeader('X-CSRF-TOKEN', $('meta[name="_csrf"]').attr('content')); // CSRF 토큰 추가
                },
                success: function(response) {
                    if (response.success) {
                        alert('비밀번호가 성공적으로 변경되었습니다.');
                        
                        window.location.href = '/user/login.do';
                    } else {
                        alert('비밀번호 변경에 실패했습니다: ' + response.message);
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