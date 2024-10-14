<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/ico/favicon.ico">
<link rel="apple-touch-icon-precomposed" type="image/x-icon"
	href="images/ico/favicon.ico">
<link rel="shortcut icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/ico/favicon.ico">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/libs/jQuery-ui/jquery-ui.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/ngii-mng.css">

<title>국토정보포털 통합관리자 - Q&amp;A등록</title>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/libs/jQuery/1.12.3/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/libs/jQuery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/ngii-mng.js"></script>

<!--[if lt IE 9]>
		<script type="text/javascript" src="../../src/js/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
		<script type="text/javascript" src="../../src/js/libs/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
</head>
<body>
	<!-- Skip Navigation -->
	<a href="#content" class="nav-skip">본문바로가기</a>
	<a href="#gnb" class="nav-skip">주메뉴 바로가기</a>
	<a href="#lnb" class="nav-skip">서브메뉴 바로가기</a>
	<!-- /Skip Navigation -->

	<!-- Header -->
	<header>
		<hgroup>
			<h1 class="logo">
				<a href="../../login.html"><i></i><span class="blind">국토정보
						플랫폼 통합관리자</span></a>
			</h1>
			<div class="user-info">
				<span>국토정보 님</span>
				<button type="button">로그아웃</button>
			</div>
		</hgroup>

		<nav id="gnb">
			<ul role="menu">
				<li class="current"><a href="PB_SC_281.html">게시판 관리</a></li>
				<li><a href="javascript:alert('준비중입니다');">정보관리</a></li>
				<li><a href="../api/PB_SC_305.html">OPEN API 관리</a></li>
				<li><a href="../statistics/PB_SC_308.html">통계 관리</a></li>
				<li><a href="../circulation/PB_SC_311.html">유통 관리</a></li>
				<li><a href="../data/PB_SC_312.html">데이터 관리</a></li>
				<li><a href="javascript:alert('준비중입니다');">기관사용자변경</a></li>
			</ul>
		</nav>
	</header>
	<!-- /Header -->

	<!-- Container -->
	<article class="container">
		<!-- Sub Menu -->
		<section id="lnb" class="lnb">
			<h2>게시판 관리</h2>
			<ul role="menu">
				<li class="current"><a href="PB_SC_281.html">공지사항</a></li>
				<li><a href="javascript:alert('준비중입니다');">기준점 정보공유</a></li>
				<li><a href="javascript:alert('준비중입니다');">자료실</a></li>
				<li><a href="PB_SC_285.html">Q&amp;A</a></li>
				<li><a href="javascript:alert('준비중입니다');">국립공원 등산로 지도</a></li>
				<li><a href="PB_SC_288.html">공지사항 알림</a></li>
				<li><a href="PB_SC_292.html">극지 동영상</a></li>
				<li><a href="PB_SC_296.html">극지사진 갤러리</a></li>
				<li><a href="PB_SC_300.html">극지지도 내려받기</a></li>
				<li><a href="PB_SC_301.html">GNSS 커뮤니티</a></li>
			</ul>
		</section>
		<!-- /Sub Menu -->

		<!-- Contents -->
		<section id="content" class="content">
			<h1 class="title-sub-h1">Q&amp;A</h1>

			<!-- Location -->
			<ol class="location">
				<li><i class="fa fa-home"></i><span class="blind">홈</span></li>
				<li>게시판관리</li>
				<li>공지사항</li>
			</ol>
			<!-- /Location -->

			<!-- 공지사항 등록 -->
			<form action="QnARegister.do" method="post">
				<fieldset>
					<legend>Q&amp;A 등록</legend>
					<div class="table-vertical">
						<table>
							<caption class="blind">Q&amp;A 등록</caption>
							<colgroup>
								<col style="width: 150px;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><label for="w-type">서비스 구분</label></th>
									<td><select id="w-type" name="division_id">
											<c:forEach items="${division}" var="division">
											<option value="${division.id}">${division.name}</option>
											</c:forEach>
									</select></td>
								</tr>
								<tr>
									<th scope="row"><label for="w-title">제목</label></th>
									<td><input type="text" id="w-title" name="title" value=""
										style="width: 550px;"></td>
								</tr>
								<tr>
									<th scope="row"><label for="w-title">비밀번호</label></th>
									<td><input type="text" id="w-title" name="password" value=""
										style="width: 550px;"></td>
								</tr>
								<tr>
									<th scope="row"><label for="w-content">내용</label></th>
									<td><textarea type="text" id="w-content" name="content"
											value="" rows="20" style="width: 550px;"></textarea></td>
								</tr>
								<tr>
									<th scope="row"><label for="w-upload">첨부파일</label></th>
									<td>
										<ul class="list-bullet">
											<li>파일첨부시 팝업차단기능이 해제 되어야 합니다.</li>
											<li>파일은 최대 <em>5</em>개의 파일이 업로드 가능합니다. (파일 1개당 최대사용량 <em>2MB</em>)
											</li>
										</ul>
										<p class="upload-file">
											<input type="file" id="w-upload" name="w-upload" value=""
												style="width: 550px;">
											<button type="button" class="bt light-blue bt table">전체삭제</button>
										</p>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</fieldset>
				<!-- /공지사항 등록 -->
				<div class="bt-area text-right">
				<button type="button" onclick="location.href='QnA/qnaPageList.do'"
					class="bt reset">취소</button>
				<button type="submit" class="bt submit">저장</button>
			</div>
			</form>
		</section>
		<!-- /Contents -->
	</article>
	<!-- /Container -->

	<!-- Footer -->
	<footer>
		<div class="inner">
			<p class="f-logo">국토교통부 국토지리정보원</p>
			<ul>
				<li><a href="#"><em>개인정보 처리방침</em></a></li>
				<li><a href="#">저작권정책</a></li>
				<li><a href="#">이메일무단수집거부</a></li>
			</ul>
			<address>경기도 수원시 영통구 월드컵로 92(원천동)</address>
			<span>전화 : 031-210-2600</span> <span>팩스 : 031-210-2644</span> <small>Copyright
				(C) 2015 NGII ALL RIGHTS RESERVED.</small> <select title="관련기관 바로가기"
				class="family-site">
				<option value="">관련기관목록</option>
			</select>
		</div>
	</footer>
	<!-- /Footer -->
</body>
</html>