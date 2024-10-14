<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

<title>국토정보포털 통합관리자 - Q&amp;A 상세보기</title>

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

<script>
    $(document).ready(function () {
        $('#deleteButton').on('click', function () {
            var id = $(this).data('id');
            console.log(id);

            if (confirm('정말 게시글을 삭제하시겠습니까?')) {
                $.ajax({
                    url : '/QnA/deleteQnA.do?id=' + id,
                    type : 'DELETE',
                    success : function (response) {
                        window.location.href = '/QnA/qnaPageList.do';
                    },
                    error : function (xhr, status, error) {
                        alert('삭제 실패: ' + error);
                    }
                });
            }
        });
    });

    document.addEventListener("DOMContentLoaded", function () {
        // HTML이 완전히 로드된 후에 실행됨
        document.getElementById("toggle-answer").addEventListener(
                "click",
                function () {
                    var answerContainer = document
                            .getElementById("answer-container");
                    if (answerContainer.style.display === "none"
                            || answerContainer.style.display === "") {
                        answerContainer.style.display = "block";
                    } else {
                        answerContainer.style.display = "none";
                    }
                });
    });
    
    $(document).ready(function () {
        $('#delete-answer').on('click', function () {
            var id = $(this).data('id');
            var post_id = $('#deleteButton').data('id');
            console.log(id);

            if (confirm('정말 답글을 삭제하시겠습니까?')) {
                $.ajax({
                    url : '/QnA/deleteQnAComment.do?id=' + id+'&post_id='+post_id,
                    type : 'DELETE',
                    success : function (response) {
                        window.location.reload();
                    },
                    error : function (xhr, status, error) {
                        alert('삭제 실패: ' + error);
                    }
                });
            }
        });
    });
    
    function goToListPage() {
        const divisionId = document.querySelector('input[name="division_id"]').value;
        const checkedId = document.querySelector('input[name="checked_id"]').value;
        const searchKeyword = document.querySelector('input[name="searchKeyword"]').value;
        const currentPageNo = document.querySelector('input[name="currentPageNo"]').value;

        const url = `./qnaPageList.do?division_id=${divisionId}&checked_id=${checkedId}&searchKeyword=${searchKeyword}&currentPageNo=${currentPageNo}`;
        location.href = url;
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

			<!-- Q&A 내용 -->
			<c:set var="qna" value="${qna}" />
			<div class="table-vertical type2">
				<h3 class="title-table">
					<c:out value="${qna.title}" />
				</h3>
				<table>
					<caption class="blind">Q&amp;A 내용</caption>
					<colgroup>
						<col style="width: 150px;">
						<col>
						<col style="width: 150px;">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">구분</th>
							<td><c:out value="${qna.division}" /></td>
							
						</tr>
						<tr>
							<th scope="row">작성자</th>
							<td><c:out value="${qna.writer}" /></td>
							<th scope="row">등록일자</th>
							<td><span class="txt-gray"><fmt:formatDate
										value="${qna.testDate}" pattern="yyyy-MM-dd" /></span></td>
						</tr>
						<tr>
							<th scope="row">전화번호</th>
							<td><c:out value="${qna.phone}" /></td>
							<th scope="row">조회수</th>
							<td><c:out value="${qna.view}" /></td>
						</tr>
						<tr>
							<th scope="row">이메일</th>
							<td><c:out value="${qna.email}" /></td>
							<th scope="row">공개여부</th>
							<td><c:choose>
									<c:when test="${qna.has_password}">
										<span style="color: red">비공개</span>
									</c:when>
									<c:otherwise>
										<span style="color: blue">공개</span>
									</c:otherwise>
								</c:choose></td>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td colspan="3" style="height: 150px;"><c:out
									value="${qna.content}" /></td>
						</tr>
						<tr>
							<th scope="row">첨부파일</th>
							<td colspan="3">
								<ul class="list-file">
									<li>test-1.hwp
										<button type="button" class="bt down">다운로드</button>
									</li>
									<li>test-2.hwp
										<button type="button" class="bt down">다운로드</button>
									</li>
								</ul>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- /Q&A 내용 -->
			<div id="answer-comment">
				<c:if test="${not empty comment}">
					<h3 class="title-answer">
						<i>A</i> 답변
					</h3>
					<c:set var="comment" value="${comment}" />
					<div class="table-vertical type2">
						<table>
							<tbody>
								<tr>
									<th scope="row">내용</th>
									<td colspan="2" style="height: 20px;"><c:out
											value="${comment.c_content}" /></td>
								</tr>
								<tr>
									<th scope="row">첨부파일</th>
									<td colspan="3">
										<ul class="list-file">
											<li>test-1.hwp
												<button type="button" class="bt down">다운로드</button>
											</li>
										</ul>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</c:if>
			</div>




			<div class="bt-area text-right">
				<button type="button"
					onclick="location.href='./updatePage.do?id=${qna.id}'"
					class="bt list">수정</button>
				<button type="button" class="bt reset" id="deleteButton"
					data-id="${qna.id}">삭제</button>
				<c:if test="${not empty comment}">
					<!-- comment가 null이 아닐 때 "답글 삭제" 버튼 표시 -->
					<button type="button" id="delete-answer" class="bt reset" data-id="${comment.id}">답글
						삭제</button>
				</c:if>
				<c:if test="${empty comment}">
					<!-- comment가 null일 때 "답글" 버튼 표시 -->
					<button type="button" id="toggle-answer" class="bt reset">답글</button>
				</c:if>
				<button type="button" onclick="goToListPage()" class="bt list">목록</button>
			</div>





			<!-- 전체를 감싸는 div -->
			<div id="answer-container" style="display: none;">
				<h3 class="title-answer">
					<i>A</i> 답변
				</h3>

				<!-- 답변 쓰기 -->
				<form action="commentRegister.do" method="post">
					<fieldset>
						<legend>답변 쓰기</legend>
						<div class="table-vertical type2">
							<table>
								<caption class="blind">답변 쓰기 내용</caption>
								<colgroup>
									<col style="width: 150px;">
									<col>
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><label for="a-content">답변내용</label></th>
										<td><textarea id="a-content" name="c_content" rows="3"
												style="width: 550px;"></textarea></td>
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
												<input type="file" id="w-upload" name="w-upload"
													style="width: 550px;">
												<button type="button" class="bt light-blue bt table">전체삭제</button>
											</p>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<input type="hidden" id="w-id" name="post_id" value="${qna.id}">
						    <input type="hidden" name="division_id" value="${divisionId}" />
    <input type="hidden" name="checked_id" value="${checkedId}" />
    <input type="hidden" name="searchKeyword" value="${searchKeyword}" />
    <input type="hidden" name="currentPageNo" value="${currentPageNo}" />
					</fieldset>

					<div class="bt-area text-right">
						<button type="button" onclick="location.href='PB_SC_285.html'"
							class="bt reset">취소</button>
						<button type="submit" class="bt submit">저장</button>
					</div>
				</form>
				<!-- /답변 쓰기 -->


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