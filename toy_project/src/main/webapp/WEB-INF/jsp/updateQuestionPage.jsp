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
					<h1 class="m-0">문제 수정</h1>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="/">메인 화면</a></li>
						<li class="breadcrumb-item active">문제 수정</li>
					</ol>
				</div>
			</div>
		</div>
	</div>

	<section class="content">
		<form id="questionForm" onsubmit="return confirmUpdate();" method="post">
			<input type="hidden" name="test_id" value="${testId}" /> <input
				type="hidden" name="questionId" value="${questionDetail.id}" />
			<div class="row">
				<div class="col-md-6">
					<div class="card card-primary">
						<div class="card-header">
							<h3 class="card-title">문제 수정</h3>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" title="Collapse">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body">
							<div class="form-group">
								<label for="inputStatus">문제 형식</label> <select id="inputStatus"
									name="question_type" class="form-control custom-select"
									required onchange="toggleFields()">
									<option value="객관식"
										${questionDetail.question_type == '객관식' ? 'selected' : ''}>객관식</option>
									<option value="주관식"
										${questionDetail.question_type == '주관식' ? 'selected' : ''}>주관식</option>
									<option value="서술형"
										${questionDetail.question_type == '서술형' ? 'selected' : ''}>서술형</option>
								</select>
							</div>

							<!-- 객관식 문제 입력 필드 -->
							<div id="multipleChoiceFields"
								style="${questionDetail.question_type == '객관식' ? '' : 'display: none;'}">
								<div class="form-group">
									<label for="inputQuestion">문제 입력</label>
									<textarea id="inputQuestion" name="question"
										class="form-control" rows="4" required>${questionDetail.question_text}</textarea>
								</div>
								<div class="form-group">
									<label for="inputOption1">보기 1</label> <input type="text"
										id="inputOption1" name="option1" class="form-control"
										value="${questionDetail.options[0] != null ? questionDetail.options[0].option_text : ''}"
										required>
								</div>
								<div class="form-group">
									<label for="inputOption2">보기 2</label> <input type="text"
										id="inputOption2" name="option2" class="form-control"
										value="${questionDetail.options[1] != null ? questionDetail.options[1].option_text : ''}"
										required>
								</div>
								<div class="form-group">
									<label for="inputOption3">보기 3</label> <input type="text"
										id="inputOption3" name="option3" class="form-control"
										value="${questionDetail.options[2] != null ? questionDetail.options[2].option_text : ''}"
										required>
								</div>
								<div class="form-group">
									<label for="inputOption4">보기 4</label> <input type="text"
										id="inputOption4" name="option4" class="form-control"
										value="${questionDetail.options[3] != null ? questionDetail.options[3].option_text : ''}"
										required>
								</div>
								<div class="form-group">
									<label for="inputAnswer">정답 보기 번호</label> <select
										id="inputAnswer" name="answer"
										class="form-control custom-select" required>
										<option value="" disabled>정답을 선택하세요</option>
										<option value="1"
											${questionDetail.correct_answer == '1' ? 'selected' : ''}>1</option>
										<option value="2"
											${questionDetail.correct_answer == '2' ? 'selected' : ''}>2</option>
										<option value="3"
											${questionDetail.correct_answer == '3' ? 'selected' : ''}>3</option>
										<option value="4"
											${questionDetail.correct_answer == '4' ? 'selected' : ''}>4</option>
									</select>
								</div>
							</div>

							<!-- 주관식 문제 입력 필드 -->
							<div id="subjectiveFields"
								style="${questionDetail.question_type == '주관식' ? '' : 'display: none;'}">
								<div class="form-group">
									<label for="inputSubjectiveQuestion">주관식 문제 입력</label>
									<textarea id="inputSubjectiveQuestion"
										name="subjectiveQuestion" class="form-control" rows="4"
										required>${questionDetail.question_text}</textarea>
								</div>
								<div class="form-group">
									<label for="inputSubjectiveAnswer">정답 입력</label> <input
										type="text" id="inputSubjectiveAnswer" name="subjectiveAnswer"
										class="form-control" value="${questionDetail.correct_answer}"
										required>
								</div>
							</div>

							<!-- 서술형 문제 입력 필드 -->
							<div id="descriptiveFields"
								style="${questionDetail.question_type == '서술형' ? '' : 'display: none;'}">
								<div class="form-group">
									<label for="inputDescriptiveQuestion">서술형 문제 입력</label>
									<textarea id="inputDescriptiveQuestion"
										name="descriptiveQuestion" class="form-control" rows="4"
										required>${questionDetail.question_text}</textarea>
								</div>
							</div>

							<div class="form-group">
								<label for="inputScore">문제 점수</label> <input type="number"
									id="inputScore" name="score" class="form-control" min="1"
									value="${questionDetail.score}" required> <small
									class="form-text text-muted">1 이상의 숫자를 입력하세요.</small>
							</div>

							<div class="text-center mt-3">
    <button type="submit" class="btn btn-primary">문제 수정</button>
</div>
						</div>
					</div>
				</div>

				<div class="col-md-6">
					<div class="card card-secondary">
						<div class="card-header">
							<h3 class="card-title">문제 목록</h3>
						</div>
						<div class="card-body">
							<div class="row">
								<c:forEach var="question" items="${questions}">
									<div class="col-2 mb-4">
										<a
											href="/question/testEdit.do?testId=${testId}&questionId=${question.id}"
											class="btn ${question.id == selectedQuestionId ? 'btn-primary' : 'btn-outline-primary'} btn-block">
											문제 ${question.question_order} </a>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="card card-info">
						<div class="card-header">
							<h3 class="card-title">현재 테스트의 총점</h3>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse" title="Collapse">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body">
							<p class="score-text">
								<strong>${totalScore}</strong> 점
							</p>
						</div>
					</div>
				</div>
			</div>
		</form>
	</section>
</div>

<script>
function toggleFields() {
    var status = document.getElementById("inputStatus").value; // 현재 선택된 문제 형식
    var fields = {
        "객관식": document.getElementById("multipleChoiceFields"),
        "주관식": document.getElementById("subjectiveFields"),
        "서술형": document.getElementById("descriptiveFields")
    };

    // 모든 필드를 숨기고 required 초기화
    Object.values(fields).forEach(function(field) {
        if (field) {
            field.style.display = "none"; // 필드 숨기기
        }
    });

    // 모든 입력 필드에서 required 속성 제거
    var inputQuestion = document.getElementById("inputQuestion");
    if (inputQuestion) {
        inputQuestion.required = false;
    }

    var inputSubjectiveQuestion = document.getElementById("inputSubjectiveQuestion");
    if (inputSubjectiveQuestion) {
        inputSubjectiveQuestion.required = false;
    }

    var inputDescriptiveQuestion = document.getElementById("inputDescriptiveQuestion");
    if (inputDescriptiveQuestion) {
        inputDescriptiveQuestion.required = false;
    }

    // 객관식 옵션 필드에서 required 속성 제거
    ["inputOption1", "inputOption2", "inputOption3", "inputOption4"].forEach(id => {
        var optionField = document.getElementById(id);
        if (optionField) {
            optionField.required = false;
        }
    });

    // 답안 제거
    var inputAnswer = document.getElementById("inputAnswer");
    if (inputAnswer) {
        inputAnswer.required = false;
    }
    var inputSubjectiveAnswer = document.getElementById("inputSubjectiveAnswer");
    if (inputSubjectiveAnswer) {
        inputSubjectiveAnswer.required = false;
    }

    // 선택된 문제 형식에 따라 필드 보이기 및 required 설정
    if (status === "객관식") {
        fields["객관식"].style.display = "block"; // 객관식 필드 보이기
        if (inputQuestion) {
            inputQuestion.required = true; // 문제 입력 필드 required 설정
        }
        ["inputOption1", "inputOption2", "inputOption3", "inputOption4"].forEach(id => {
            var optionField = document.getElementById(id);
            if (optionField) {
                fields["객관식"].style.display = "block";
                optionField.required = true; // 옵션 필드 required 설정
            }
        });
        if (inputAnswer) {
            inputAnswer.required = true; // 정답 필드 required 설정
        }
    } else if (status === "주관식") {
        fields["주관식"].style.display = "block"; // 주관식 필드 보이기
        if (inputSubjectiveQuestion) {
            inputSubjectiveQuestion.required = true; // 주관식 문제 입력 필드 required 설정
        }
        if (inputSubjectiveAnswer) {
            inputSubjectiveAnswer.required = true; // 주관식 정답 필드 required 설정
        }
    } else if (status === "서술형") {
        fields["서술형"].style.display = "block"; // 서술형 필드 보이기
        if (inputDescriptiveQuestion) {
            inputDescriptiveQuestion.required = true; // 서술형 문제 입력 필드 required 설정
        }
    }
}

function confirmUpdate() {
    if (!confirm("수정하시겠습니까?")) {
        return false;
    }

    var form = document.getElementById("questionForm");
    var questionType = document.getElementById("inputStatus").value;
    var testId = document.querySelector('input[name="test_id"]').value;
    var questionId = document.querySelector('input[name="questionId"]').value;
    var score = document.getElementById("inputScore").value;
    var data = new URLSearchParams();

    data.append("test_id", testId);
    data.append("questionId", questionId);
    data.append("score", score);
    data.append("question_type", questionType);

    if (questionType === "객관식") {
        var question = document.getElementById("inputQuestion").value;
        var option1 = document.getElementById("inputOption1").value;
        var option2 = document.getElementById("inputOption2").value;
        var option3 = document.getElementById("inputOption3").value;
        var option4 = document.getElementById("inputOption4").value;
        var answer = document.getElementById("inputAnswer").value;

        data.append("question", question);
        data.append("option1", option1);
        data.append("option2", option2);
        data.append("option3", option3);
        data.append("option4", option4);
        data.append("answer", answer);
    } else if (questionType === "주관식") {
        var subjectiveQuestion = document.getElementById("inputSubjectiveQuestion").value;
        var subjectiveAnswer = document.getElementById("inputSubjectiveAnswer").value;

        data.append("subjectiveQuestion", subjectiveQuestion);
        data.append("subjectiveAnswer", subjectiveAnswer);
    } else if (questionType === "서술형") {
        var descriptiveQuestion = document.getElementById("inputDescriptiveQuestion").value;

        data.append("descriptiveQuestion", descriptiveQuestion);
    }

    fetch(form.action, {
        method: 'POST',
        body: data
    })
    .then(response => {
        if (response.ok) {
            return response.text();
        } else {
            throw new Error("수정에 실패했습니다.");
        }
    })
    .then(data => {
        alert("수정되었습니다.");
        const redirectUrl = `/question/testEdit.do?testId=${testId}&questionId=${questionId}`;
        window.location.href = redirectUrl;
    })
    .catch(error => {
        alert(error.message);
    });

    return false;
}

window.onload = function() {
    toggleFields();
};
</script>

<style>
.score-text {
	font-size: 30px; /* 원하는 크기로 설정 */
	font-weight: bold; /* 굵게 설정 */
	color: #007bff; /* 원하는 색상으로 설정 */
}
</style>

<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>
