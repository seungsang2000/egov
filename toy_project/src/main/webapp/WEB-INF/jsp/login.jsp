<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE HTML>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/ico/favicon.ico">
	<link rel="apple-touch-icon-precomposed" type="image/x-icon" href="images/ico/favicon.ico">
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/ico/favicon.ico">
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/libs/jQuery-ui/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/ngii-mng.css">
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/libs/jQuery/1.12.3/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/libs/jQuery-ui/jquery-ui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/ngii-mng.js"></script>
	
    <title>국토정보포털 통합관리자 - 로그인</title>
</head>
<body class="login-area">
    <!-- Skip Navigation -->
	<a href="#container" class="nav-skip">본문바로가기</a>
    <!-- /Skip Navigation -->
	
	<!-- Contents -->
	<article>
		<!-- login -->
		<hgroup>
			<h1><i class="logo">국토교통부 국토지리정보원</i>통합관리자</h1>
			<p class="login-addtion">국토정보포털통합관리자시스텝입니다. <br>시스템관련문의 : 국토정보포털시스템관리자 031-210-2600</p>
		</hgroup>

		<section id="container" class="login-form">
			<form action="" id="" name="">
			<fieldset>
			<legend>통합관리자 로그인</legend>
				<dl>
					<dt><label for="u-id">사용자ID</label></dt>
					<dd><input type="text" id="u-id" name="u-id" value=""></dd>
					<dt><label for="u-pw">비밀번호</label></dt>
					<dd><input type="password" id="u-pw" name="u-pw" value=""></dd>
				</dl>
				<label class="check-save"><input type="checkbox" id="" name=""><span>ID 저장</span></label>
				<button onclick="window.location.href='chkusr.do'" title="페이지 이동" class="bt login" width="141" height="39"  margin-left="37">회원가입</button>
				<button onclick="window.open('html/bbs/PB_SC_281.html')" title="새창열림" class="bt login" width="141" height="39" margin-left="15" margin-right="6">로그인</button>
			</fieldset>
			</form>
		</section>
		<!-- /login -->
	</article>
	<!-- /Contents -->

	<!-- Footer -->
	<footer>
		<address>경기도 수원시 영통구 월드컵로 92(원천동)</address>
		<span>전화 : 031-210-2600</span>
		<span>팩스 : 031-210-2644</span>
		<small>Copyright (C) 2015 NGII ALL RIGHTS RESERVED.</small>
	</footer>
	<!-- /Footer -->
	
	
    <!--[if lt IE 9]>
		<script type="text/javascript" src="src/js/libs/html5shiv.min.js"></script>
		<script type="text/javascript" src="src/js/libs/respond.min.js"></script>
	<![endif]-->
</body>
</html>