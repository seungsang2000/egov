<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


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

<title>국토정보포털 통합관리자 - Q&amp;A</title>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/libs/jQuery/1.12.3/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/libs/jQuery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/ngii-mng.js"></script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/common.js"></script>

<!--[if lt IE 9]>
		<script type="text/javascript" src="../../src/js/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
		<script type="text/javascript" src="../../src/js/libs/respond/1.4.2/respond.min.js"></script>
	<![endif]-->

<script>
    function fn_search(pageNo) {
        //common.js의 ComSubmit()함수 객체 생성해서 함수들 가져다 사용
        var comSubmit = new ComSubmit();

        comSubmit.setUrl("<c:url value='/QnA/qnaPageList.do'/>"); //url 설정해주고
        comSubmit.addParam("currentPageNo", pageNo); //게시판 목록 호출시, currentPageNo 함께 전송
        comSubmit.addParam("division_id", document.getElementById("w-type").value); // 서비스 구분
        comSubmit.addParam("checked_id", document.getElementById("w-require").value); // 검색 조건
        comSubmit.addParam("searchKeyword", document.getElementById("s-input").value); // 검색어

        comSubmit.submit();
    }
    
    function prevPage() {
        let currentPageNo = parseInt(document.getElementById('currentPageNo').value) || 1;
        if (currentPageNo > 1) { // 현재 페이지가 1보다 큰 경우에만 이전 페이지로 이동
            fn_search(currentPageNo - 1);
        }
    }

    function nextPage() {
        let currentPageNo = parseInt(document.getElementById('currentPageNo').value) || 1;
        fn_search(currentPageNo + 1); // 다음 페이지로 이동
    }
    
    function openModal(id) {
        document.getElementById('passwordModal').style.display = 'block';
        document.getElementById('modalDimmer').style.display = 'block'; // Dimmer 표시
        document.getElementById('passwordInput').setAttribute('data-id', id); // ID 저장
        document.getElementById('errorMsg').style.display = 'none'; // 에러 메시지 초기화
    }

    function closeModal() {
        document.getElementById('passwordModal').style.display = 'none';
        document.getElementById('modalDimmer').style.display = 'none'; // Dimmer 숨기기
        document.getElementById('errorMsg').style.display = 'none'; // 에러 메시지 초기화
    }

    function checkPassword() {
        const password = document.getElementById('passwordInput').value;
        const id = document.getElementById('passwordInput').getAttribute('data-id'); // ID 가져오기

        fetch('checkPassword.do', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ id: id, password: password }) // ID와 비밀번호 전송
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            if (data.success) {
                // 비밀번호가 맞으면 게시물 내용으로 이동
                window.location.href = 'qna.do?id=' + id;
            } else {
                // 비밀번호가 틀리면 에러 메시지 표시
                document.getElementById('errorMsg').innerText = '비밀번호가 틀렸습니다.';
                document.getElementById('errorMsg').style.display = 'block';
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
    }
</script>


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
				<li><a href="PB_SC_281.html">공지사항</a></li>
				<li><a href="javascript:alert('준비중입니다');">기준점 정보공유</a></li>
				<li><a href="javascript:alert('준비중입니다');">자료실</a></li>
				<li class="current"><a href="PB_SC_285.html">Q&amp;A</a></li>
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
				<li>Q&amp;A</li>
			</ol>
			<!-- /Location -->

			<!-- Search -->
			<div class="search-form">
				<form action="qnaPageList.do" method="get" class="float-right">
					<fieldset>
						<legend>리스트 검색</legend>
						<label for="w-type" class="blind">서비스 구분</label> <select
							id="w-type" name="division_id">
							<option value="">전체</option>
							<c:forEach items="${division}" var="division">
								<option value="${division.id}"
									<c:if test="${division.id == divisionId}">selected</c:if>>${division.name}</option>
							</c:forEach>
						</select> <label for="w-require" class="blind">검색 조건 선택</label> <select
							id="w-require" name="checked_id">
							<option value="">전체</option>
							<c:forEach items="${checked}" var="checked">
								<option value="${checked.id}"
									<c:if test="${checked.id == checkedId}">selected</c:if>>${checked.name}</option>
							</c:forEach>
						</select> <label for="s-input" class="blind">검색어 입력</label> <input
							type="text" id="s-input" name="searchKeyword"
							value="${searchKeyword}">
						<button type="submit" class="bt search">검색</button>
					</fieldset>
				</form>

				<p class="count float-left">
					게시글 수 <em><c:out value="${count}" /></em>
				</p>
			</div>
			<!-- /Search -->

			<!-- Q&A 목록 -->
			<div class="table-horizontal hover">
				<table>
					<caption class="blind">Q&amp;A 목록</caption>
					<colgroup>
						<col style="width: 50px;">
						<col style="width: 130px;">
						<col>
						<col style="width: 100px;">
						<col style="width: 100px;">
						<col style="width: 90px;">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">서비스 구분</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">등록일</th>
							<th scope="col">처리상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="list">
							<tr>
								<td><span class="txt-gray"><c:out
											value="${list.rnum}" /></span></td>
								<td><c:out value="${list.division}" /></td>
								<td class="subject"><c:choose>
										<c:when test="${list.has_password}">
											<a href="#" onclick="openModal(${list.id}); return false;">
												<c:out value="${list.title}" />
											</a>
										</c:when>
										<c:otherwise>
											<a href="qna.do?id=${list.id}&division_id=${divisionId}&checked_id=${checkedId}&searchKeyword=${searchKeyword}&currentPageNo=${paginationInfo.currentPageNo}">
                <c:out value="${list.title}" />
            </a>
										</c:otherwise>
									</c:choose> <c:if test="${list.has_password eq true}">
										<img src="${pageContext.request.contextPath}/images/lock.png"
											alt="잠금 이미지" height="20" width="20" />
									</c:if></td>
								<td><c:out value="${list.writer}" /></td>
								<td><span class="txt-gray"><fmt:formatDate
											value="${list.testDate}" pattern="yyyy.MM.dd" /></span></td>
								<td><c:choose>
										<c:when test="${fn:trim(list.checked) eq '검수'}">
											<span class="txt-gray"><c:out value="${list.checked}" /></span>
										</c:when>
										<c:when test="${fn:trim(list.checked) eq '완료'}">
											<span class="txt-blue"><c:out value="${list.checked}" /></span>
										</c:when>
										<c:otherwise>
											<span class="txt-default">상태 없음</span>
											<!-- 기본 상태 출력 -->
										</c:otherwise>
									</c:choose></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!-- /Q&A 목록 -->

			<!-- 비밀번호 모달 팝업 -->
			<div id="passwordModal" class="layer-popup" style="display: none;">
				<div class="layer-header">
					<span class="close" onclick="closeModal()">&times;</span>
					<h2>비밀번호 입력</h2>
				</div>
				<div class="layer-contents">
					<input type="password" id="passwordInput" placeholder="비밀번호를 입력하세요" />
					<button onclick="checkPassword()">확인</button>
					<p id="errorMsg" class="error" style="display: none; color: red;"></p>
				</div>
			</div>
			<!-- Dimmer -->
			<div id="modalDimmer" class="dim" style="display: none;"></div>

			<!-- Pagination -->
			<div class="pagination">
    <button type="button" class="prev" onclick="prevPage()">이전</button>
    <div>
        <c:if test="${not empty paginationInfo}">
            <ui:pagination paginationInfo="${paginationInfo}" type="text"
                jsFunction="fn_search" />
        </c:if>
        <input type="hidden" id="currentPageNo" name="currentPageNo" value="${paginationInfo.currentPageNo}" />
    </div>
    <button type="button" class="next" onclick="nextPage()">다음</button>
</div>
			<!-- /Pagination -->

			<div class="bt-area text-right">
				<button type="button" onclick="location.href='registerQnAPage.do'"
					class="bt submit">등록</button>
			</div>
		</section>
		<!-- /Contents -->
	</article>
	<!-- /Container -->

	<form id="commonForm" name="commonForm"></form>

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