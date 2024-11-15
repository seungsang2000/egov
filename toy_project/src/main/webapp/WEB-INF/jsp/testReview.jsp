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
					<h1 class="m-0">문제 상세 보기</h1>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a
							href="/course.do?id=${course.id}">${course.title}</a></li>
						<li class="breadcrumb-item active">문제 상세 보기</li>
					</ol>
				</div>
			</div>
		</div>
	</div>

	<section class="content">
		<div class="row">
			<div class="col-md-7">
				<!-- 문제 풀이 카드 크기 조정 -->
				<div class="card card-primary">
					<div class="card-header">
						<h3 class="card-title">문제 정보</h3>
					</div>
					<div class="card-body">
						<div
							class="form-group d-flex justify-content-between align-items-center">
							<label class="mb-0">문제</label> <span class="badge badge-info">배점:
								${currentQuestion.score}</span>
						</div>
						<h4>${currentQuestion.question_text}</h4>

						<c:if test="${currentQuestion.question_type == '객관식'}">
							<div class="form-group">
								<label>유저 응답</label>
								<c:forEach var="option" items="${currentQuestion.options}">
    <div>
        <input type="radio" name="answer"
               value="${option.option_number}"
               id="option${option.option_number}"
               <c:if test="${currentQuestion.userAnswer == option.option_number}"> checked</c:if>
               disabled>
        <label for="option${option.option_number}" 
               class="${currentQuestion.userAnswer == option.option_number ? (currentQuestion.userAnswer eq correct_answer ? 'text-success' : 'text-danger') : ''}">
            ${option.option_text}
        </label>
    </div>
</c:forEach>
								<input type="radio" name="answer" value="" id="optionEmpty"
									style="display: none;">
							</div>
						</c:if>

						<c:if test="${currentQuestion.question_type == '주관식'}">
							<div class="form-group">
								<label for="subjectiveAnswer">유저 응답</label> <input type="text"
									id="subjectiveAnswer" name="subjectiveAnswer"
									class="form-control ${currentQuestion.userAnswer eq correct_answer ? 'text-success' : 'text-danger'}" value="${currentQuestion.userAnswer}"
									disabled />
							</div>
						</c:if>

						<c:if test="${currentQuestion.question_type == '서술형'}">
							<div class="form-group">
								<label for="descriptiveAnswer">유저 응답</label>
								<textarea id="descriptiveAnswer" name="descriptiveAnswer"
									class="form-control" rows="4" disabled>${currentQuestion.userAnswer}</textarea>
							</div>
						</c:if>
						<div>정답 : ${correct_answer}</div>
						<%-- 							<c:choose>
								<c:when test="${not empty nextQuestionId}">
									<button type="submit" id="submitAnswer" class="btn btn-success">답안
										제출</button>
								</c:when>
								<c:otherwise>
									<button type="submit" id="endTest" class="btn btn-primary"
										onclick="submitEndTestForm(event)">시험 완료</button>
								</c:otherwise>
							</c:choose> --%>
					</div>
				</div>
			</div>

			<div class="col-md-5">
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
        <a href="/question/testReview.do?testId=${testId}&questionId=${question.id}"
           class="btn 
               ${question.id == selectedQuestionId ? 'btn-primary' : (question.is_answered ? 'btn-success' : 'btn-danger')} 
               btn-block">
            문제 ${question.question_order}
        </a>
    </div>
</c:forEach>
						</div>
					</div>
				</div>
<div class="card card-info ai-help-card">
    <div class="card-header">
        <h3 class="card-title">AI 오답노트</h3>
        <div class="card-tools">
            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                <i class="fas fa-minus"></i>
            </button>
        </div>
    </div>
<div class="card-body">
    <div id="ai-response-container" class="d-flex flex-column align-items-center justify-content-center" style="height: 100%;">
        <div class="spinner-border" role="status" id="loading-spinner" style="display: none;">
            <span class="sr-only">Loading...</span>
        </div>
        <p id="ai-response" class="ai-response" style="display: none;">AI의 답변 표시</p>
    </div>
</div>
</div>
			</div>
		</div>
	</section>
</div>


<style>
.ai-help-card {
    background-color: #f8f9fa; 
    border-radius: 0.5rem; 
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15); 
}

.ai-response {
    font-size: 16px; 
    color: #343a40;
    margin: 0; 
    font-weight: bold;
}
</style>

<script>
const originalOnload = window.onload;

window.onload = function() {
    if (originalOnload) originalOnload();
    const aiResponseElement = document.getElementById("ai-response");
    const loadingSpinner = document.getElementById("loading-spinner");

    loadingSpinner.style.display = "block"; // 스피너 표시
    aiResponseElement.style.display = "none"; // AI 답변 숨기기

    fetch(`/getFeedback.do?questionId=${currentQuestion.id}`)
        .then(response => response.text())
        .then(data => {
            loadingSpinner.style.display = "none"; // 스피너 숨기기
            aiResponseElement.innerText = data; // AI의 답변 표시
            aiResponseElement.style.display = "block"; // AI 답변 보이기
        })
        .catch(error => {
            console.error("Error fetching feedback:", error);
            loadingSpinner.style.display = "none"; // 스피너 숨기기
            aiResponseElement.innerText = "AI의 답변을 가져오는 데 오류가 발생했습니다."; // 오류 메시지 표시
            aiResponseElement.style.display = "block"; // 오류 메시지 보이기
        });
};



</script>

<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>