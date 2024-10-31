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
                                    <a href="/question/testView.do?testId=${testId}&questionId=${question.id}" class="btn ${question.id == selectedQuestionId ? 'btn-primary' : 'btn-outline-primary'} btn-block">
                                            문제 ${question.question_order}
                                        </a>
                                </div>
                            </c:forEach>
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

<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>