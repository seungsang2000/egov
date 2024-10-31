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
				<div class="card card-info">
					<div class="card-header">
						<h3 class="card-title">AI 도움</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-tool"
								data-card-widget="collapse" title="Collapse">
								<i class="fas fa-minus"></i>
							</button>
						</div>
					</div>
					<div class="card-body">
						<p class="score-text">AI의 답변</p>
					</div>

				</div>
			</div>
		</div>
	</section>
</div>


<style>
.score-text {
	font-size: 30px;
	font-weight: bold;
	color: #007bff;
}

.custom-btn {
	padding: 15px 30px;
	font-size: 18px;
}
</style>

<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>