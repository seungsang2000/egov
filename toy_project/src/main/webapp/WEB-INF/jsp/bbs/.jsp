<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE HTML>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/x-icon" href="../../images/ico/favicon.ico">
	<link rel="apple-touch-icon-precomposed" type="image/x-icon" href="images/ico/favicon.ico">
	<link rel="shortcut icon" type="image/x-icon" href="../../images/ico/favicon.ico">
	
	<link rel="stylesheet" type="text/css" href="../../src/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="../../src/js/libs/jQuery-ui/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="../../src/css/ngii-mng.css">
	
	<title>국토정보포털 통합관리자 - 극지동영상 목록</title>
	
	<script type="text/javascript" src="../../src/js/libs/jQuery/1.12.3/jquery.min.js"></script>
	<script type="text/javascript" src="../../src/js/libs/jQuery-ui/jquery-ui.min.js"></script>
	<script type="text/javascript" src="../../src/js/ngii-mng.js"></script>
	
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
			<h1 class="logo"><a href="../../login.html"><i></i><span class="blind">국토정보 플랫폼 통합관리자</span></a></h1>
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
				<li><a href="PB_SC_281.html">공지사항</a></li>
				<li><a href="javascript:alert('준비중입니다');">기준점 정보공유</a></li>
				<li><a href="javascript:alert('준비중입니다');">자료실</a></li>
				<li><a href="PB_SC_285.html">Q&amp;A</a></li>
				<li><a href="javascript:alert('준비중입니다');">국립공원 등산로 지도</a></li>
				<li><a href="PB_SC_288.html">공지사항 알림</a></li>
				<li class="current"><a href="PB_SC_292.html">극지 동영상</a></li>
				<li><a href="PB_SC_296.html">극지사진 갤러리</a></li>
				<li><a href="PB_SC_300.html">극지지도 내려받기</a></li>
				<li><a href="PB_SC_301.html">GNSS 커뮤니티</a></li>
			</ul>
		</section>
		<!-- /Sub Menu -->

		<!-- Content -->
		<section id="content" class="content">
			<h1 class="title-sub-h1">극지 동영상</h1>

			<!-- Location -->
			<ol class="location">
				<li><i class="fa fa-home"></i><span class="blind">홈</span></li>
				<li>게시판관리</li>
				<li>극지 동영상</li>
			</ol>
			<!-- /Location -->

			<!-- Search -->
			<div class="search-form">
				<form action="" class="float-right">
					<fieldset>
						<legend>리스트 검색</legend>						
						<label for="w-require" class="blind">검색 조건 선택</label>
						<select id="w-require" name="w-require">
							<option value="">전체</option>
							<option value="">제목+내용</option>
						</select>
						
						<label for="s-input" class="blind">검색어 입력</label>
						<input type="text" id="s-input" name="" value="">
						<button type="button" class="bt search">검색</button>	
					</fieldset>
				</form>

				<p class="count float-left">게시글 수 <em>17</em></p>
			</div>
			<!-- /Search -->

			<!-- 극지 동영상 목록 -->
			<div class="table-horizontal hover">
				<table>
					<caption class="blind">극지 동영상 목록</caption>
					<colgroup>
						<col style="width:50px;">
						<col>
						<col style="width:100px;">
						<col style="width:100px;">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">등록일</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>10</td>
							<td class="subject"><a href="PB_SC_293.html">설원위의 혈투[북극곰의 여름]<span class="icon-media">동영상첨부 있음</span></a></td>
							<td>admin</td>
							<td>2016.08.04</td>
						</tr>
						<tr>
							<td>9</td>
							<td class="subject"><a href="PB_SC_293.html">죽음을 앞드고 눈물 흘리는 북극곰[북극곰의 여름]<span class="icon-media">동영상첨부 있음</span></a></td>
							<td>admin</td>
							<td>2016.08.04</td>
						</tr>
						<tr>
							<td>8</td>
							<td class="subject"><a href="PB_SC_293.html">살기위해 동족의 사체를 먹는 북극곰[북극곰의 여름]<span class="icon-media">동영상첨부 있음</span></a></td>
							<td>admin</td>
							<td>2016.08.04</td>
						</tr>
						<tr>
							<td>7</td>
							<td class="subject"><a href="PB_SC_293.html">개와 친구가 되고 싶은 아이스베어[북극곰의 여름]<span class="icon-media">동영상첨부 있음</span></a></td>
							<td>admin</td>
							<td>2016.08.04</td>
						</tr>
						<tr>
							<td>6</td>
							<td class="subject"><a href="PB_SC_293.html">북극곰에게 찾아온 시련[북극곰의 여름]<span class="icon-media">동영상첨부 있음</span></a></td>
							<td>admin</td>
							<td>2016.08.04</td>
						</tr>
						<tr>
							<td>5</td>
							<td class="subject"><a href="PB_SC_293.html">사라져가는 북극 빙하<span class="icon-media">동영상첨부 있음</span></a></td>
							<td>admin</td>
							<td>2016.08.04</td>
						</tr>
						<tr>
							<td>4</td>
							<td class="subject"><a href="PB_SC_293.html">신년특집 생존의 비밀 3부 사라지는 얼음왕국 5/5<span class="icon-media">동영상첨부 있음</span></a></td>
							<td>admin</td>
							<td>2016.08.04</td>
						</tr>
						<tr>
							<td>3</td>
							<td class="subject"><a href="PB_SC_293.html">신년특집 생존의 비밀 3부 사라지는 얼음왕국 4/5<span class="icon-media">동영상첨부 있음</span></a></td>
							<td>admin</td>
							<td>2016.08.04</td>
						</tr>
						<tr>
							<td>2</td>
							<td class="subject"><a href="PB_SC_293.html">신년특집 생존의 비밀 3부 사라지는 얼음왕국 3/5<span class="icon-media">동영상첨부 있음</span></a></td>
							<td>admin</td>
							<td>2016.08.04</td>
						</tr>
						<tr>
							<td>1</td>
							<td class="subject"><a href="PB_SC_293.html">신년특집 생존의 비밀 3부 사라지는 얼음왕국 2/5<span class="icon-media">동영상첨부 있음</span></a></td>
							<td>admin</td>
							<td>2016.08.04</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- /극지 동영상 목록 -->

			<!-- Pagination -->
			<div class="pagination">
				<button type="button" class="prev">이전</button>	
				<div>
					<button type="button" class="current">1</button>
					<button type="button">2</button>
					<button type="button">3</button>
					<button type="button">4</button>
					<button type="button">5</button>
					<button type="button">6</button>
					<button type="button">7</button>
					<button type="button">8</button>
					<button type="button">9</button>
					<button type="button">10</button>
				</div>
				<button type="button" class="next">다음</button>
			</div>
			<!-- /Pagination -->

			<div class="bt-area text-right">
				<button type="button" onclick="location.href='PB_SC_294.html'" class="bt submit">등록</button>
			</div>
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
			<span>전화 : 031-210-2600</span>
			<span>팩스 : 031-210-2644</span>
			<small>Copyright (C) 2015 NGII ALL RIGHTS RESERVED.</small>

			<select title="관련기관 바로가기" class="family-site">
				<option value="">관련기관목록</option>
			</select>
		</div>
	</footer>
	<!-- /Footer -->
</body>
</html>