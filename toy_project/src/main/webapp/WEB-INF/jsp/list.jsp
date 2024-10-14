<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/ico/favicon.ico">
	<link rel="apple-touch-icon-precomposed" type="image/x-icon" href="${pageContext.request.contextPath}/images/ico/favicon.ico">
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/ico/favicon.ico">
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
	<!-- <link rel="stylesheet" type="text/css" href="src/js/libs/jQuery-ui/jquery-ui.css"> -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/ngii-mng.css">

	<title>국토정보포털 통합관리자 - 리스트</title>

	<style type="text/css">
		* {
			margin: 0px;
			padding: 0px;
			box-sizing: border-box;
		}
		body {
			padding: 20px 10px;
		    color: #000;
			font-family: Helvetica, Arial, sans-serif;
			font-size: 12px;
		}
		legend, caption {
			display: none;
		}
		h1 {
			position: static;
			margin-bottom: 20px;
		}
		table {
		    width: 100%;
		}
		table th {
		    padding: 10px;
			color: #fff;
			background: #000;
			border: 1px solid #ddd;
		}
		table td {
		    padding: 10px;
			border: 1px solid #ddd
		}		
		table td a {
		    color: #0072bc;
			text-decoration: underline
		}
		table .gray td {
			background: #eee;
		}		
		table .blue td {
			background-color: #ecf7fc;
		}
		
	 </style>
	 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
	<h1><a href="login.html" target="_blank" title="새창열림"><img src="images/logo.png" alt="국토정보포털 통합관리자 로고"></a></h1>
	<table>
		<caption>Worksheet</caption>
		<colgroup>
			<col style="width:120px;">
			<col style="width:120px;">
			<col style="width:120px;">
			<col style="width:120px;">
			<col style="width:120px;">
			<col style="width:auto;">
			<col style="width:200px;">
		</colgroup>
		<thead>
			<tr>
				<th>Depth1</th>
				<th>Depth2</th>
				<th>Depth3</th>
				<th>Popup</th>
				<th>Directory</th>
				<th>File</th>
				<th>Memo</th>
			</tr>
		</thead>
		<tbody>		
			<tr class="gray">
				<td>로그인</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td><a href="login.html" target="_blank" title="새창열림">login.html</a></td>
				<td></td>
			</tr>
			
			<!-- 게시판관리 -->
			<tr>
				<td rowspan="24">게시판관리 </td>
				<td rowspan="4">공지사항</td>
				<td>리스트</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="noticelist.do" target="_blank" title="새창열림">공지사항 리스트</a></td>
				<td></td>
			</tr>
			<tr>
				<td>상세</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="notice.do?id=1" target="_blank" title="새창열림">상세보기</a></td>
				<td></td>
			</tr>
			<tr>
				<td>등록</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="registerPage.do" target="_blank" title="새창열림">게시글 등록</a></td>
				<td></td>
			</tr>
			<tr>
				<td>수정</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="updatePage.do?id=3" target="_blank" title="새창열림">게시글 수정</a></td>
				<td></td>
			</tr>
			<tr>
				<td rowspan="3">Q&amp;A</td>
				<td>리스트</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="QnA/qnaPageList.do" target="_blank" title="새창열림">qna리스트</a></td>
				<td></td>
			</tr>
			<tr>
				<td>상세</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_286.html" target="_blank" title="새창열림">PB_SC_286.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>등록</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_287.html" target="_blank" title="새창열림">PB_SC_287.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td rowspan="4">공지사항알림</td>
				<td>리스트</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_288.html" target="_blank" title="새창열림">PB_SC_288.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>상세</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_289.html" target="_blank" title="새창열림">PB_SC_289.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>등록</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_290.html" target="_blank" title="새창열림">PB_SC_290.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>수정</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_291.html" target="_blank" title="새창열림">PB_SC_291.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td rowspan="4">극지동영상</td>
				<td>리스트</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_292.html" target="_blank" title="새창열림">PB_SC_292.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>상세</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_293.html" target="_blank" title="새창열림">PB_SC_293.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>등록</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_294.html" target="_blank" title="새창열림">PB_SC_294.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>수정</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_295.html" target="_blank" title="새창열림">PB_SC_295.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td rowspan="4">극지사진갤러리</td>
				<td>리스트</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_296.html" target="_blank" title="새창열림">PB_SC_296.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>상세</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_297.html" target="_blank" title="새창열림">PB_SC_297.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>등록</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_298.html" target="_blank" title="새창열림">PB_SC_298.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>수정</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_299.html" target="_blank" title="새창열림">PB_SC_299.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>극지지도 내려받기</td>
				<td></td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_300.html" target="_blank" title="새창열림">PB_SC_300.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td rowspan="4">GNSS 커뮤니티</td>
				<td>리스트</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_301.html" target="_blank" title="새창열림">PB_SC_301.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>상세</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_302.html" target="_blank" title="새창열림">PB_SC_302.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>등록</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_303.html" target="_blank" title="새창열림">PB_SC_303.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>수정</td>
				<td></td>
				<td>html/bbs</td>
				<td><a href="bbs/PB_SC_304.html" target="_blank" title="새창열림">PB_SC_304.html</a></td>
				<td></td>
			</tr>
			<!-- /게시판관리 -->
			
			<!-- OPEN API관리 -->
			<tr>
				<td rowspan="3">OPEN API관리</td>
				<td rowspan="2">바로e맵 오픈 API 목록</td>
				<td>리스트</td>
				<td></td>
				<td>html/api</td>
				<td><a href="api/PB_SC_305.html" target="_blank" title="새창열림">PB_SC_305.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>상세</td>
				<td></td>
				<td>html/api</td>
				<td><a href="api/PB_SC_306.html" target="_blank" title="새창열림">PB_SC_306.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>바로e맵 오픈 API 통계보기</td>
				<td></td>
				<td></td>
				<td>html/api</td>
				<td><a href="api/PB_SC_307.html" target="_blank" title="새창열림">PB_SC_307.html</a></td>
				<td></td>
			</tr>
			<!-- /OPEN API관리 -->
			
			<!-- 통계관리 -->
			<tr>
				<td rowspan="3">통계관리 </td>
				<td>접속현황</td>
				<td></td>
				<td></td>
				<td>html/m3</td>
				<td><a href="statistics/PB_SC_308.html" target="_blank" title="새창열림">PB_SC_308.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>페이지뷰 현황</td>
				<td></td>
				<td></td>
				<td>html/m3</td>
				<td><a href="statistics/PB_SC_309.html" target="_blank" title="새창열림">PB_SC_309.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>검색어 통계</td>
				<td></td>
				<td></td>
				<td>html/m3</td>
				<td><a href="statistics/PB_SC_310.html" target="_blank" title="새창열림">PB_SC_310.html</a></td>
				<td></td>
			</tr>
			<!-- /통계관리 -->
			
			<!-- 유통관리 -->
			<tr>
				<td>유통관리</td>
				<td>통계현황</td>
				<td></td>
				<td></td>
				<td>html/circulation</td>
				<td><a href="circulation/PB_SC_311.html" target="_blank" title="새창열림">PB_SC_311.html</a></td>
				<td></td>
			</tr>
			<!-- /유통관리 -->
			
			<!-- 데이터 관리 -->
			<tr>
				<td rowspan="11">데이터 관리</td>
				<td rowspan="4">아라온 이동경로 리스트</td>
				<td rowspan="4">리스트</td>
				<td>상세</td>
				<td rowspan="4">html/data</td>
				<td rowspan="4"><a href="data/PB_SC_312.html" target="_blank" title="새창열림">PB_SC_312.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>추가</td>
				<td></td>
			</tr>
			<tr>
				<td>일괄추가</td>
				<td></td>
			</tr>
			<tr>
				<td>수정</td>
				<td></td>
			</tr>
			<tr>
				<td rowspan="4">측량기준점현황</td>
				<td rowspan="4">리스트</td>
				<td>상세</td>
				<td rowspan="4">html/data</td>
				<td rowspan="4"><a href="data/PB_SC_317.html" target="_blank" title="새창열림">PB_SC_317.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>추가</td>
				<td></td>
			</tr>
			<tr>
				<td>일괄추가</td>
				<td></td>
			</tr>
			<tr>
				<td>수정</td>
				<td></td>
			</tr>
			<tr>
				<td rowspan="3">주요기지설비현황</td>
				<td rowspan="3">리스트</td>
				<td>상세</td>
				<td rowspan="3">html/data</td>
				<td rowspan="3"><a href="data/PB_SC_322.html" target="_blank" title="새창열림">PB_SC_322.html</a></td>
				<td></td>
			</tr>
			<tr>
				<td>추가</td>
				<td></td>
			</tr>
			<tr>
				<td>수정</td>
				<td></td>
			</tr>
			<!-- /데이터 관리 -->
			
		</tbody>
	</table>
	<!--<script type="text/javascript" src="src/js/libs/jQuery/1.12.3/jquery.min.js"></script>
	<script type="text/javascript" src="src/js/libs/jQuery-ui/jquery-ui.min.js"></script> -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/ngii-mng.js"></script>
	
    <!--[if lt IE 9]>
		<script type="text/javascript" src="src/js/libs/html5shiv.min.js"></script>
		<script type="text/javascript" src="src/js/libs/respond.min.js"></script>
	<![endif]-->
</body>
</html>
