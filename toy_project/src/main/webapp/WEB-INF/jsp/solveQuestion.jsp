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
						<li class="breadcrumb-item"><a href="/course.do?id=${course.id}">${course.title}</a></li>
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
						<form action="/question/solveTest.do" method="POST" onsubmit="submitAnswer(event); return false;">
							<input type="hidden" name="currentQuestionId"
								value="${selectedQuestionId}" /> <input type="hidden"
								name="testId" value="${testId}" /> <input type="hidden"
								name="questionType" value="${currentQuestion.question_type}">
							<input type="hidden" name="nextQuestionId"
								value="${nextQuestionId}" />
							<sec:csrfInput />

							<div class="form-group d-flex justify-content-between align-items-center">
    <label class="mb-0">문제</label>
    <span class="badge badge-info">배점: ${currentQuestion.score}</span>
</div>
<h4>${currentQuestion.question_text}</h4>

							<c:if test="${currentQuestion.question_type == '객관식'}">
								<div class="form-group">
									<label>보기</label>
									<c:forEach var="option" items="${currentQuestion.options}">
										<div>
											<input type="radio" name="answer"
												value="${option.option_number}"
												id="option${option.option_number}"
												<c:if test="${currentQuestion.userAnswer == option.option_number}"> checked</c:if> onclick="check('${option.option_number}')">
											<label for="option${option.option_number}">${option.option_text}</label>
										</div>
									</c:forEach>
									<input type="radio" name="answer" value="" id="optionEmpty" style="display:none;">
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
									<button type="submit" id="submitAnswerButton" class="btn btn-success">답안
										제출</button>
								</c:when>
								<c:otherwise>
									<button type="button" id="endTest" class="btn btn-primary"
										onclick="submitEndTestForm(event)">시험 완료</button>
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
            class="btn 
                ${question.id == selectedQuestionId ? 'btn-primary' : (question.is_answered ? 'btn-warning btn-outline-primary' : 'btn-outline-primary')} 
                btn-block"
            onclick="submitAndNavigate(${question.id})">
            ${question.question_order}
        </button>
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
						<!-- <button id="stopExamBtn">시험 종료(영상 제출)</button> -->
					</div>
				</div>
			</div>
		</div>
	</section>
</div>


<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog"
	aria-labelledby="confirmModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="confirmModalLabel">시험 완료 확인</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">정말로 시험을 완료하시겠습니까?</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" id="confirmEndTest">확인</button>
			</div>
		</div>
	</div>
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

    const serverEndTime = "${endTime}";
    

    
    const formattedEndTime = serverEndTime.replace(/\[UTC\]/, '');
    const endTime = new Date(formattedEndTime).getTime();

    const countdownTimer = () => {
        const now = new Date().getTime();
        const distance = endTime - now;

        if (distance < 0) {
            clearInterval(interval);
            document.getElementById('timer').textContent = "시간 초과";
            submitTestForm(); // 자동 제출
        } else {
            const minutes = Math.floor(distance / (1000 * 60));
            const seconds = Math.floor((distance % (1000 * 60)) / 1000);
            
            const formattedSeconds = String(seconds).padStart(2, '0');
            
            document.getElementById('timer').textContent = minutes + ":" + formattedSeconds ;
        }
    };

    const interval = setInterval(countdownTimer, 1000);
    
    
    function submitAndNavigate(questionId) {
        const form = document.querySelector('form[action="/question/solveTest.do"]');
        const formData = new FormData(form);
        formData.append("questionId", questionId);

        fetch(form.action, {
            method: 'POST',
            body: formData,
        })
        .then(response => response.text())  // JSP의 HTML을 그대로 받음
        .then(html => {
            // 받은 HTML에서 필요한 부분만 업데이트
            document.querySelector('.content-wrapper').innerHTML = 
                $(html).find('.content-wrapper').html(); 
        })
        .catch(error => {
            console.error('문제를 불러오는 중 오류 발생:', error);
        });
    }
    
    function submitEndTestForm(event) {
        event.preventDefault();   
        const form = event.target.closest('form');
        var csrfToken = $('meta[name="_csrf"]').attr('content');

        
        $('#confirmModal').modal('show');

        
        document.getElementById('confirmEndTest').onclick = function() {
            $('#confirmModal').modal('hide');
            
            
            $.ajax({
                type: 'POST',
                url: '/question/userFinishTest.do',
                data: $(form).serialize(),
                success: function(courseId) {
                    testCompleted = true;
                    window.location.href = '/course.do?id=' + courseId;
                },
                error: function() {
                    
                    alert("시험 완료 처리 중 오류가 발생했습니다.");
                }
            });
        };
    }
    
    function submitTestForm() {
        const form = document.querySelector('form[action="/question/solveTest.do"]');
        
        
        $.ajax({
            type: 'POST',
            url: '/question/userFinishTest.do',
            data: $(form).serialize(),
            success: function(courseId) {
                window.location.href = '/course.do?id=' + courseId;
            },
            error: function() {
                alert("시험 완료 처리 중 오류가 발생했습니다.");
            }
        });
    }
    
    var checkNum =null;
    function check(num) {
        var obj = $('input:radio[name="answer"]'); 

        
        if (checkNum == num) {
            
            obj.each(function() {
                if ($(this).val() == num) {
                    $(this).prop('checked', false); 
                }
            });
            checkNum = null; 
        } else {
            
            checkNum = num; 
        }
        
        if (!obj.is(':checked')) {
            document.getElementById('optionEmpty').checked = true;
        }
    }
    
    function submitAnswer(event) {
        event.preventDefault(); // 폼 기본 제출 동작 방지

        const form = event.target;
        const formData = new FormData(form);

        fetch(form.action, {
            method: 'POST',
            body: formData,
        })
        .then(response => response.text())
        .then(html => {
            document.querySelector('.content-wrapper').innerHTML = 
                $(html).find('.content-wrapper').html();
        })
        .catch(error => {
            console.error('답안 제출 중 오류 발생:', error);
        });
    }
    
    let mediaRecorder;
    let recordedChunks = [];
    let currentStream; // 현재 스트림을 저장할 변수
    let testCompleted = false;
    
    const userId = "${userId}";
    const testId = "${testId}";
    const courseId = "${course.id}";
    let startTime;
    let videoDuration = 0;

    async function requestFullScreenCapture() {
        const stream = await navigator.mediaDevices.getDisplayMedia({
            video: {
                cursor: "always"
            },
            audio: true
        });
        return stream;
    }

    async function startExam() {
        try {
            currentStream = await requestFullScreenCapture(); // 현재 스트림을 저장
            startRecording(currentStream);
            startTime = Date.now();
        } catch (error) {
            alert('전체 화면 녹화 권한이 필요합니다. 시험을 진행할 수 없습니다.');
            window.location.href = '/question/startTestPage.do?testId='+"${testId}";
        }
    }

    function startRecording(stream) {
        const options = {
            mimeType: 'video/webm; codecs=vp8,opus' // VP8 비디오 코덱과 Opus 오디오 코덱 지정
        };

        mediaRecorder = new MediaRecorder(stream, options);

        mediaRecorder.ondataavailable = (event) => {
            if (event.data.size > 0) {
                recordedChunks.push(event.data);
            }
        };

        mediaRecorder.onstop = () => {
            videoDuration = (Date.now() - startTime) / 1000;
            const blob = new Blob(recordedChunks, { type: 'video/webm' });
            uploadVideo(blob);
            
            
            
            
            // 화면 공유 종료
            stream.getTracks().forEach(track => track.stop());
            if(!testCompleted){
                window.location.href = '/question/startTestPage.do?testId='+"${testId}";
            }
        };
        
        window.addEventListener("beforeunload", async (event) => {
            if (mediaRecorder && mediaRecorder.state !== "inactive") {
                stopRecording(); // 녹화 중지
                const blob = new Blob(recordedChunks, { type: 'video/webm' });
                await uploadVideo(blob); // 비디오 업로드
            }
        });

        mediaRecorder.start();
    }

    function stopRecording(stream) {
        mediaRecorder.stop(); // 녹화 중지

        // 화면 공유 종료
        stream.getTracks().forEach(track => track.stop());
    }

    // 페이지가 로드되면 자동으로 시험 시작
    window.onload = () => {
        startExam();
    };

    async function uploadVideo(blob) {
        const formData = new FormData();
        
        formData.append('video', blob, 'exam_video.webm');
        formData.append('userId', userId); // 사용자 ID 추가
        formData.append('testId', testId);
        formData.append('courseId',courseId);
        formData.append('duration', videoDuration);

        const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
        const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

        const response = await fetch('/uploadVideo', {
            method: 'POST',
            headers: {
                [csrfHeader]: csrfToken // CSRF 토큰 추가
            },
            body: formData
        });

        if (response.ok) {
            
        } else {
            alert('비디오 업로드에 실패했습니다.');
        }
    }
    
</script>

<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>