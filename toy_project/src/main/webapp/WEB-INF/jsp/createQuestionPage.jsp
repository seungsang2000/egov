<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/include/header.jsp"%>

<div class="content-wrapper">
	<div class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h1 class="m-0">문제 생성</h1>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="/course.do?id=${course.id}">${course.title }</a></li>
						<li class="breadcrumb-item active">문제 생성</li>
					</ol>
				</div>
			</div>
		</div>
	</div>

	<section class="content">
		
			<div class="row">
				<div class="col-md-6">
				<form action="/question/questionCreate.do" method="post">
		<sec:csrfInput/>
			<input type="hidden" name="test_id" value="${testId}">
					<div class="card card-primary">
						<div class="card-header">
							<h3 class="card-title">문제 생성</h3>
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
									<option value="객관식">객관식</option>
									<option value="주관식">주관식</option>
									<!-- <option value="서술형">서술형</option> -->
								</select>
							</div>

							<!-- 객관식 문제 입력 필드 -->
							<div id="multipleChoiceFields">
								<div class="form-group">
									<label for="inputQuestion">문제 입력</label>
									<textarea id="inputQuestion" name="question"
										class="form-control" rows="4" required></textarea>
								</div>

								<div class="form-group">
									<label for="inputOption1">보기 1</label> <input type="text"
										id="inputOption1" name="option1" class="form-control" required>
								</div>
								<div class="form-group">
									<label for="inputOption2">보기 2</label> <input type="text"
										id="inputOption2" name="option2" class="form-control" required>
								</div>
								<div class="form-group">
									<label for="inputOption3">보기 3</label> <input type="text"
										id="inputOption3" name="option3" class="form-control" required>
								</div>
								<div class="form-group">
									<label for="inputOption4">보기 4</label> <input type="text"
										id="inputOption4" name="option4" class="form-control" required>
								</div>

								<div class="form-group">
									<label for="inputAnswer">정답 보기 번호</label> <select
										id="inputAnswer" name="answer"
										class="form-control custom-select" required>
										<option value="" disabled selected>정답을 선택하세요</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
									</select>
								</div>
							</div>

							<!-- 주관식 문제 입력 필드 -->
							<div id="subjectiveFields" style="display: none;">
								<div class="form-group">
									<label for="inputSubjectiveQuestion">주관식 문제 입력</label>
									<textarea id="inputSubjectiveQuestion"
										name="subjectiveQuestion" class="form-control" rows="4"
										required></textarea>

								</div>

								<div class="form-group">
									<label for="inputSubjectiveAnswer">정답 입력</label> <input
										type="text" id="inputSubjectiveAnswer" name="subjectiveAnswer"
										class="form-control" required>
								</div>
							</div>

							<!-- 서술형 문제 입력 필드 -->
							<div id="descriptiveFields" style="display: none;">
								<div class="form-group">
									<label for="inputDescriptiveQuestion">서술형 문제 입력</label>
									<textarea id="inputDescriptiveQuestion"
										name="descriptiveQuestion" class="form-control" rows="4"
										required></textarea>
								</div>
							</div>

							<div class="form-group">
								<label for="inputScore">문제 점수</label> <input type="number"
									id="inputScore" name="score" class="form-control" min="1"
									required> <small class="form-text text-muted">1
									이상의 숫자를 입력하세요.</small>
							</div>
							
							<div class="text-center mt-3">
                            <button type="submit" class="btn btn-primary">문제 생성</button>
                        </div>
						</div>
					</div>
					</form>
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
										<!-- 버튼을 2개씩 나열 -->
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
					
					        <div class="card card-success collapsed-card">
            <div class="card-header">
                <h3 class="card-title">테스트 설정</h3>
                <div class="card-tools">
                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                        <i class="fas fa-plus"></i>
                    </button>
                </div>
            </div>
        <div class="card-body">
<form id="testForm" method="post" onsubmit="changeTime(event); return false;">
    <div class="form-group">
        <label for="inputStartDateTime">시작일 및 시간</label>
        <input type="datetime-local" id="StartDate" class="form-control" name="start_time" 
               value="${test.start_time}" required>
    </div>
    <div class="form-group">
        <label for="inputEndDateTime">종료일 및 시간</label>
        <input type="datetime-local" id="EndDate" class="form-control" name="end_time" 
               value="${test.end_time}" required>
    </div>
    <div class="form-group">
        <label for="inputDuration">시험 시간 (분)</label>
        <input type="number" id="inputDuration" class="form-control" name="time_limit" 
               value="${test.time_limit}" required min="1" step="1">
    </div>
    <input type="hidden" name="test_id" value="${testId}"> 
    <div class="text-center mt-3">
    <button type="submit" class="btn btn-success">설정 변경</button>
    </div>
</form>
		</div>
					
				</div>
				
			</div>
			</div>
			
		
	</section>
</div>

<script>
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

function toggleFields() {
    var status = document.getElementById("inputStatus").value;
    var fields = {
        "객관식": document.getElementById("multipleChoiceFields"),
        "주관식": document.getElementById("subjectiveFields"),
        "서술형": document.getElementById("descriptiveFields")
    };
    
    // 모든 필드를 숨기고 required 초기화
    Object.values(fields).forEach(function(field) {
        field.style.display = "none";
    });

    // 모든 입력 필드에서 required 속성 제거
    document.getElementById("inputQuestion").required = false;
    document.getElementById("inputSubjectiveQuestion").required = false;
    document.getElementById("inputDescriptiveQuestion").required = false;


    // 객관식 옵션 필드에서 required 속성 제거
    ["inputOption1", "inputOption2", "inputOption3", "inputOption4"].forEach(id => {
        document.getElementById(id).required = false;
    });
    
    // 답안 제거
    document.getElementById("inputAnswer").required = false
	document.getElementById("inputSubjectiveAnswer").required = false
    
    
    // 선택된 문제 형식에 따라 필드 보이기 및 required 설정
    if (status === "객관식") {
        fields["객관식"].style.display = "block";
        document.getElementById("inputQuestion").required = true;
        ["inputOption1", "inputOption2", "inputOption3", "inputOption4"].forEach(id => {
            document.getElementById(id).required = true;
        });
        document.getElementById("inputAnswer").required = true;
    } else if (status === "주관식") {
        fields["주관식"].style.display = "block";
        document.getElementById("inputSubjectiveQuestion").required = true;
        document.getElementById("inputSubjectiveAnswer").required = true;
    } else if (status === "서술형") {
        fields["서술형"].style.display = "block";
        document.getElementById("inputDescriptiveQuestion").required = true;
    }
}

function checkOrder(){
    var order = doucument.get
}

const originalOnload = window.onload;
window.onload = function() {
    if(originalOnload) originalOnload();
    toggleFields();
};

function changeTime(event) {
    event.preventDefault(); // 기본 form 제출 방지

    const form = document.getElementById('testForm');
    const formData = new FormData(form);
    const testData = {};

    formData.forEach((value, key) => {
        testData[key] = value; 
    });

    
    const startTime = new Date(testData.start_time);
    const endTime = new Date(testData.end_time);
    const timeLimitMinutes = parseInt(testData.time_limit, 10); // 시험 시간(분 단위)

    const minimumEndTime = new Date(startTime.getTime() + timeLimitMinutes * 60000); // 시작 시간 + 시험 시간

    if (endTime < minimumEndTime) {
        alert("종료 시간은 시작 시간 이후 시험 시간보다 늦어야 합니다.");
        return;
    }
    
    

    fetch('/changeTestTime.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            [csrfHeader]: csrfToken // CSRF 토큰 추가
        },
    body: JSON.stringify(testData), 
    })
    .then(response => {
        if (response.ok) {
            alert("설정이 변경되었습니다.");
            window.location.reload(); 
        } else {
            alert("설정 변경이 실패했습니다.");
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert("서버와의 통신 중 오류가 발생했습니다.");
    });
}
</script>

<style>
    .score-text {
        font-size: 30px; 
        font-weight: bold; 
        color: #007bff;
    }
</style>

<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>