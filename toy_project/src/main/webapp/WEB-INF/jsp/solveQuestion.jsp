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
            <div class="col-md-12">
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">문제 정보</h3>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <label>문제</label>
                            <h4>${currentQuestion.question_text}</h4>
                        </div>

                        <c:if test="${currentQuestion.question_type == '객관식'}">
                            <div class="form-group">
                                <label>보기</label>
                                <c:forEach var="option" items="${currentQuestion.options}">
                                    <div>
                                        <input type="radio" name="answer" value="${option.id}" id="option${option.id}">
                                        <label for="option${option.id}">${option.option_text}</label>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>

                        <c:if test="${currentQuestion.question_type == '주관식'}">
                            <div class="form-group">
                                <label for="subjectiveAnswer">정답 입력</label>
                                <input type="text" id="subjectiveAnswer" name="subjectiveAnswer" class="form-control">
                            </div>
                        </c:if>

                        <c:if test="${currentQuestion.question_type == '서술형'}">
                            <div class="form-group">
                                <label for="descriptiveAnswer">서술형 문제 입력</label>
                                <textarea id="descriptiveAnswer" name="descriptiveAnswer" class="form-control" rows="4"></textarea>
                            </div>
                        </c:if>

                        <button id="submitAnswer" class="btn btn-success">답안 제출</button>
                        <div id="timer" class="mt-3"></div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<script>
    // 서버에서 전달받은 endTime (예: "2024-10-23T10:30:00")
    const endTime = new Date("${endTime}").getTime();

    const countdownTimer = () => {
        const now = new Date().getTime();
        const distance = endTime - now;

        if (distance < 0) {
            clearInterval(interval);
            document.getElementById('timer').textContent = "시간 초과";
            // 자동 제출 로직 추가
            document.getElementById('submitAnswer').click(); // 예시로 자동 제출
        } else {
            const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((distance % (1000 * 60)) / 1000);
            document.getElementById('timer').textContent = `${minutes}분 ${seconds}초 남음`;
        }
    };

    const interval = setInterval(countdownTimer, 1000);

    document.getElementById('submitAnswer').addEventListener('click', function() {
        const selectedAnswer = document.querySelector('input[name="answer"]:checked');
        let answer;
        if (selectedAnswer) {
            answer = selectedAnswer.value;
        } else {
            answer = document.getElementById('subjectiveAnswer').value || document.getElementById('descriptiveAnswer').value;
        }

        // 서버에 답안 제출
        fetch('/submitAnswer', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                questionId: "${currentQuestion.id}",
                answer: answer
            })
        }).then(response => response.json()).then(data => {
            alert(data.message);
            // 다음 문제로 이동 또는 결과 페이지로 리다이렉트
        }).catch(error => {
            console.error('Error:', error);
        });
    });
</script>

<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>