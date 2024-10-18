<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/jsp/include/header.jsp" %>

<div class="content-wrapper">
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">문제 생성</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="/">메인 화면</a></li>
                        <li class="breadcrumb-item active">문제 생성</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <section class="content">
        <form action="/question/questionCreate.do" method="post">
            <div class="row">
                <div class="col-md-6">
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3 class="card-title">문제 생성</h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="form-group">
                                <label for="inputStatus">문제 형식</label>
                                <select id="inputStatus" name="status" class="form-control custom-select" required onchange="toggleFields()">
                                    <option value="객관식">객관식</option>
                                    <option value="주관식">주관식</option>
                                    <option value="서술형">서술형</option>
                                </select>
                            </div>

                            <!-- 객관식 문제 입력 필드 -->
                            <div id="multipleChoiceFields">
                                <div class="form-group">
                                    <label for="inputQuestion">문제 입력</label>
                                    <textarea id="inputQuestion" name="question" class="form-control" rows="4" required></textarea>
                                </div>

                                <div class="form-group">
                                    <label for="inputOption1">보기 1</label>
                                    <input type="text" id="inputOption1" name="option1" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="inputOption2">보기 2</label>
                                    <input type="text" id="inputOption2" name="option2" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="inputOption3">보기 3</label>
                                    <input type="text" id="inputOption3" name="option3" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="inputOption4">보기 4</label>
                                    <input type="text" id="inputOption4" name="option4" class="form-control" required>
                                </div>

                                <div class="form-group">
                                    <label for="inputAnswer">정답 보기 번호</label>
                                    <select id="inputAnswer" name="answer" class="form-control custom-select" required>
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
                                    <textarea id="inputSubjectiveQuestion" name="subjectiveQuestion" class="form-control" rows="4" required></textarea>
                                </div>
                            </div>

                            <!-- 서술형 문제 입력 필드 -->
                            <div id="descriptiveFields" style="display: none;">
                                <div class="form-group">
                                    <label for="inputDescriptiveQuestion">서술형 문제 입력</label>
                                    <textarea id="inputDescriptiveQuestion" name="descriptiveQuestion" class="form-control" rows="4" required></textarea>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">문제 생성</button>
        </form>
    </section>
</div>

<script>
function toggleFields() {
    var status = document.getElementById("inputStatus").value;
    document.getElementById("multipleChoiceFields").style.display = "none";
    document.getElementById("subjectiveFields").style.display = "none";
    document.getElementById("descriptiveFields").style.display = "none";

    if (status === "객관식") {
        document.getElementById("multipleChoiceFields").style.display = "block";
    } else if (status === "주관식") {
        document.getElementById("subjectiveFields").style.display = "block";
    } else if (status === "서술형") {
        document.getElementById("descriptiveFields").style.display = "block";
    }
}
</script>

<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>