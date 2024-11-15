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
                        <li class="breadcrumb-item"><a href="/course.do?id=${course.id}">${course.title}</a></li>
                        <li class="breadcrumb-item active">문제 상세 보기</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">문제 정보</h3>
                        <div class="card-tools">
                            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                <i class="fas fa-minus"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <label for="inputStatus">문제 형식</label>
                            <select id="inputStatus" name="question_type" class="form-control custom-select" disabled>
                                <option value="객관식" ${questionDetail.question_type == '객관식' ? 'selected' : ''}>객관식</option>
                                <option value="주관식" ${questionDetail.question_type == '주관식' ? 'selected' : ''}>주관식</option>
                                <option value="서술형" ${questionDetail.question_type == '서술형' ? 'selected' : ''}>서술형</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="inputQuestion">문제 입력</label>
                            <textarea id="inputQuestion" name="question" class="form-control" rows="4" readonly>${questionDetail.question_text}</textarea>
                        </div>

                        <c:if test="${questionDetail.question_type == '객관식'}">
                            <c:forEach var="option" items="${questionDetail.options}">
                                <div class="form-group">
                                    <label for="inputOption${option.option_number}">보기 ${option.option_number}</label>
                                    <input type="text" id="inputOption${option.option_number}" name="option${option.option_number}" class="form-control" value="${option.option_text}" readonly>
                                </div>
                            </c:forEach>
                            <div class="form-group">
                                <label for="inputAnswer">정답 보기 번호</label>
                                <select id="inputAnswer" name="answer" class="form-control custom-select" disabled>
                                    <option value="1" ${questionDetail.correct_answer == '1' ? 'selected' : ''}>1</option>
                                    <option value="2" ${questionDetail.correct_answer == '2' ? 'selected' : ''}>2</option>
                                    <option value="3" ${questionDetail.correct_answer == '3' ? 'selected' : ''}>3</option>
                                    <option value="4" ${questionDetail.correct_answer == '4' ? 'selected' : ''}>4</option>
                                </select>
                            </div>
                        </c:if>

                        <c:if test="${questionDetail.question_type == '주관식'}">
                            <div class="form-group">
                                <label for="inputSubjectiveAnswer">정답 입력</label>
                                <input type="text" id="inputSubjectiveAnswer" name="subjectiveAnswer" class="form-control" value="${questionDetail.correct_answer}" readonly>
                            </div>
                        </c:if>

                        <c:if test="${questionDetail.question_type == '서술형'}">
                            <div class="form-group">
                                <label for="inputDescriptiveQuestion">서술형 문제 입력</label>
                                <textarea id="inputDescriptiveQuestion" name="descriptiveQuestion" class="form-control" rows="4" readonly>${questionDetail.question_text}</textarea>
                            </div>
                        </c:if>

                        <div class="form-group">
                            <label for="inputScore">문제 점수</label>
                            <input type="number" id="inputScore" name="score" class="form-control" min="1" value="${questionDetail.score}" readonly>
                        </div>

                         <div class="d-flex justify-content-between mt-3">
                            <a href="#" onclick="confirmDelete(${questionDetail.id})" class="btn btn-danger me-2">문제 삭제</a>
                            <a href="/question/questionUpdate.do?testId=${testId}&questionId=${questionDetail.id}" class="btn btn-success">문제 수정</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card card-secondary">
                    <div class="card-header">
                        <h3 class="card-title">문제 목록</h3>
                        <div class="card-tools">
                            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                <i class="fas fa-minus"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <c:forEach var="question" items="${questions}">
                                <div class="col-2 mb-4">
                                    <a href="/question/testEdit.do?testId=${testId}&questionId=${question.id}" class="btn ${question.id == selectedQuestionId ? 'btn-primary' : 'btn-outline-primary'} btn-block">
                                            문제 ${question.question_order}
                                        </a>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="text-center mt-3">
                            <a href="/question/testEdit.do?testId=${testId}" class="btn btn-success">문제 생성</a>
                        </div>
                    </div>
                </div>
				<div class="card card-info">
            <div class="card-header">
                <h3 class="card-title">현재 테스트의 총점</h3>
                <div class="card-tools">
                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
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
    <input type="hidden" name="test_id" value="${test.id}"> 
    <div class="text-center mt-3">
    <button type="submit" class="btn btn-success">설정 변경</button>
    </div>
</form>
		</div>
		
    </div>
    <div class="text-center mt-3">
    <button type="button" class="btn btn-primary custom-btn" onclick="completeTest()">시험 완료</button>
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
    
    .custom-btn{
    padding: 15px 30px; 
    font-size: 18px; 
    }
</style>

<script>
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
    function confirmDelete(questionId) {
        if (confirm("문제를 삭제하시겠습니까?")) {
            
            var url = "/question/questionDelete.do?questionId=" + questionId;
            
            fetch(url, {
                method: 'DELETE',
                headers: {
                    [csrfHeader]: csrfToken 
                }
            })
            .then(response => {
                if (response.ok) {
                    alert("삭제 완료되었습니다.");
                    
                    window.location.href = "/question/testEdit.do?testId=${testId}";
                } else {
                    alert("삭제에 실패했습니다.");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("삭제 중 오류가 발생했습니다.");
            });
        }
    }
    
    function completeTest() {
        
        if (confirm("시험 생성을 완료하시겠습니까? 등록된 유저들에게 시험이 공개되게 되며, 문제 수정이 불가능해집니다.")) {

            
            fetch('/testComplete.do?testId=${testId}', { 
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    [csrfHeader]: csrfToken 
                },
            })
            .then(response => {
                if (response.ok) {
                    alert("시험이 완료되었습니다.");
                    window.location.href = '/course.do?id=${course.id}';
                } else {
                    return response.json().then(errorMessage  => {
                        alert("시험 완료 요청에 실패했습니다: " + errorMessage.message ); 
                    });
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("서버와의 통신 중 오류가 발생했습니다.");
            });
        } else {
            
            
        }
    }
    
    
    function changeTime(event) {
        event.preventDefault(); // 기본 form 제출 방지

        const form = document.getElementById('testForm');
        const formData = new FormData(form);
        const testData = {};

        formData.forEach((value, key) => {
            testData[key] = value; // FormData에서 JSON 객체로 변환
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
                window.location.reload(); // 페이지 리로드
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

<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>