<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/include/header.jsp"%>

<div class="content-wrapper">
	<div class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h1 class="m-0">문제 풀기</h1>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="/">메인 화면</a></li>
						<li class="breadcrumb-item active">문제 풀기</li>
					</ol>
				</div>
			</div>
		</div>
	</div>

	<section class="content">
		<div class="row">
			<!-- 문제 풀이 카드 왼쪽 -->
			<div class="col-md-8">
				<!-- 문제 풀이 카드 크기 조정 -->
				<div class="card card-primary">
					<div class="card-header">
						<h3 class="card-title">문제 정보</h3>
					</div>
					<div class="card-body">
						<form action="/question/solveTest.do" method="POST">
							<input type="hidden" name="currentQuestionId"
								value="${selectedQuestionId}" /> <input type="hidden"
								name="testId" value="${testId}" /> <input type="hidden"
								name="questionType" value="${currentQuestion.question_type}">
							<input type="hidden" name="nextQuestionId"
								value="${nextQuestionId}" />
							<sec:csrfInput />

							<div class="form-group">
								<label>문제</label>
								<h4>${currentQuestion.question_text}</h4>
							</div>

							<c:if test="${currentQuestion.question_type == '객관식'}">
								<div class="form-group">
									<label>보기</label>
									<c:forEach var="option" items="${currentQuestion.options}">
										<div>
											<input type="radio" name="answer"
												value="${option.option_number}"
												id="option${option.option_number}"
												<c:if test="${currentQuestion.userAnswer == option.option_number}"> checked</c:if>>
											<label for="option${option.option_number}">${option.option_text}</label>
										</div>
									</c:forEach>
								</div>
							</c:if>

							<c:if test="${currentQuestion.question_type == '주관식'}">
								<div class="form-group">
									<label for="subjectiveAnswer">정답 입력</label> <input type="text"
										id="subjectiveAnswer" name="subjectiveAnswer"
										class="form-control" value="${currentQuestion.userAnswer}" />
								</div>
							</c:if>

							<c:if test="${currentQuestion.question_type == '서술형'}">
								<div class="form-group">
									<label for="descriptiveAnswer">서술형 문제 입력</label>
									<textarea id="descriptiveAnswer" name="descriptiveAnswer"
										class="form-control" rows="4">${currentQuestion.userAnswer}</textarea>
								</div>
							</c:if>

							<c:choose>
								<c:when test="${not empty nextQuestionId}">
									<button type="submit" id="submitAnswer" class="btn btn-success">답안
										제출</button>
								</c:when>
								<c:otherwise>
									<button type="submit" id="endTest" class="btn btn-primary">시험
										완료</button>
								</c:otherwise>
							</c:choose>
						</form>
					</div>
				</div>
			</div>

			<!-- 문제 목록 카드와 남은 시간 카드 오른쪽 -->
			<div class="col-md-4">
				<!-- 카드 크기 조정 -->
				<div class="card card-secondary">
					<div class="card-header">
						<h3 class="card-title">문제 목록</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-tool"
								data-card-widget="collapse" title="Collapse">
								<i class="fas fa-minus"></i>
							</button>
						</div>
					</div>
					<div class="card-body">
						<div class="row">
							<c:forEach var="question" items="${questions}">
								<div class="col-2 mb-4">
									<button type="button"
										class="btn ${question.id == selectedQuestionId ? 'btn-primary' : 'btn-outline-primary'} btn-block"
										onclick="submitAndNavigate(${question.id})">문제
										${question.question_order}</button>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>

				<div class="card card-info">
					<div class="card-header">
						<h3 class="card-title">남은 시간</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-tool"
								data-card-widget="collapse" title="Collapse">
								<i class="fas fa-minus"></i>
							</button>
						</div>
					</div>
					<div class="card-body">
						<div id="timer" class="mt-3 timer-text">00 : 00</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<style>
.score-text {
	font-size: 30px; /* 원하는 크기로 설정 */
	font-weight: bold; /* 굵게 설정 */
	color: #007bff; /* 원하는 색상으로 설정 */
}

.custom-btn {
	padding: 15px 30px; /* 상하, 좌우 패딩 조정 */
	font-size: 18px; /* 글자 크기 조정 */
}

.timer-text {
	font-size: 30px; /* 원하는 크기로 설정 */
	font-weight: bold; /* 굵게 설정 */
	color: #007bff; /* 원하는 색상으로 설정 */
}
</style>

<script>
 // 서버에서 전달받은 endTime (예: "2024-10-25T02:27:02.034Z[UTC]")
    const serverEndTime = "${endTime}";

    // [UTC] 부분 제거
    const formattedEndTime = serverEndTime.replace(/\[UTC\]/, '');
    const endTime = new Date(formattedEndTime).getTime();

    const countdownTimer = () => {
        const now = new Date().getTime();
        const distance = endTime - now;

        if (distance < 0) {
            clearInterval(interval);
            document.getElementById('timer').textContent = "시간 초과";
            //document.getElementById('submitAnswer').click(); // 자동 제출
        } else {
            const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((distance % (1000 * 60)) / 1000);
            
            const formattedSeconds = String(seconds).padStart(2, '0');
            
            document.getElementById('timer').textContent = minutes + ":" + formattedSeconds ;
        }
    };

    const interval = setInterval(countdownTimer, 1000);
    
    
    function submitAndNavigate(questionId) {
        
        const form = document.querySelector('form[action="/question/solveTest.do"]');
        const formData = new FormData(form);

        // 선택된 문제에 대한 questionId 추가
        formData.append("questionId", questionId);

        
        fetch(form.action, {
            method: 'POST',
            body: formData,
        })
        .then(response => {
            if (response.ok) {
                return response.text();
            }
            throw new Error('Network response was not ok.');
        })
        .then(data => {
            // 서버에서 반환된 JSP를 현재 문서에 작성
            document.open();
            document.write(data);
            document.close();
        })
        .catch(error => {
            console.error('There was a problem with the fetch operation:', error);
        });
    }
</script>

<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>