package egovframework.kss.main.service.impl;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.kss.main.dto.AnswerDTO;
import egovframework.kss.main.dto.QuestionDetailDTO;
import egovframework.kss.main.dto.QuestionDetailWithUserAnswerDTO;
import egovframework.kss.main.dto.QuestionListDTO;
import egovframework.kss.main.dto.SolveQuestionDTO;
import egovframework.kss.main.dto.SolveTestDTO;
import egovframework.kss.main.dto.TestReviewDTO;
import egovframework.kss.main.exception.CustomException;
import egovframework.kss.main.service.CourseService;
import egovframework.kss.main.service.QuestionService;
import egovframework.kss.main.service.TestService;
import egovframework.kss.main.service.UserService;
import egovframework.kss.main.vo.CourseVO;
import egovframework.kss.main.vo.ExamParticipationVO;
import egovframework.kss.main.vo.TestVO;
import egovframework.kss.main.vo.UserVO;

@Service("TestService")
public class TestServiceImpl implements TestService {
	@Autowired
	private UserService userService;

	@Autowired
	private QuestionService questionService;

	@Autowired
	private CourseService courseService;

	@Override
	public SolveTestDTO solveTest(int testId, Integer questionId) {
		UserVO user = userService.getCurrentUser();
		int userId = user.getId();

		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("testId", testId);

		List<QuestionListDTO> questions = questionService.selectSloveQuestionListsByTestId(params);

		if (questionId == null) {
			questionId = questions.get(0).getId();
		}

		params.put("questionId", questionId);

		ExamParticipationVO userParticipation = questionService.selectExamParticipation(params);

		Timestamp now = new Timestamp(System.currentTimeMillis());
		TestVO test = courseService.selectTestById(testId);

		if (test.getEnd_time().before(now)) {
			throw new CustomException("이미 완료된 시험입니다");
		}

		if (userParticipation != null && (userParticipation.getEnd_time().before(now) || userParticipation.getStatus().equals("완료"))) {
			throw new CustomException("이미 완료된 시험입니다");
		}

		if (!questionService.checkExamParticipationExists(params)) {
			initiateExamParticipation(params, test);
			userParticipation = questionService.selectExamParticipation(params);
		}

		QuestionDetailDTO questionDetail = questionService.selectQuestionById(questionId);
		String userAnswer = questionService.selectUserAnswer(params);

		QuestionDetailWithUserAnswerDTO detailWithAnswer = new QuestionDetailWithUserAnswerDTO();
		detailWithAnswer.setId(questionDetail.getId());
		detailWithAnswer.setQuestion_text(questionDetail.getQuestion_text());
		detailWithAnswer.setQuestion_type(questionDetail.getQuestion_type());
		detailWithAnswer.setOptions(questionDetail.getOptions());
		detailWithAnswer.setUserAnswer(userAnswer);
		detailWithAnswer.setScore(questionDetail.getScore());

		Integer nextQuestionId = null;
		if (questionId != questions.get(questions.size() - 1).getId()) {
			QuestionDetailDTO nextQuestionDetail = questionService.selectNextQuestionById(questionId);
			nextQuestionId = nextQuestionDetail.getId();
		}

		CourseVO course = courseService.selectCourseById(test.getCourse_id());

		return new SolveTestDTO(userParticipation.getEndTimeAsISO(), testId, userId, questionId, questions, detailWithAnswer, nextQuestionId, course, false);
	}

	@Override
	public SolveQuestionDTO solveQuestion(HttpServletRequest request, Integer questionId, Integer nextQuestionId) {
		String questionType = request.getParameter("questionType");
		int testId = Integer.parseInt(request.getParameter("testId"));
		int currentQuestionId = Integer.parseInt(request.getParameter("currentQuestionId"));
		UserVO user = userService.getCurrentUser();
		int userId = user.getId();

		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("testId", testId);
		params.put("questionId", questionId);

		ExamParticipationVO userParticipation = questionService.selectExamParticipation(params);

		Timestamp now = new Timestamp(System.currentTimeMillis());
		TestVO test = courseService.selectTestById(testId);

		// 시험 완료 여부 확인
		validateTestCompletion(test, userParticipation, now);

		// 사용자 답변 저장 또는 업데이트
		AnswerDTO answer = createAnswerDTO(request, questionType, testId, currentQuestionId, userId);
		if (!questionService.checkUserAnswerExists(answer)) {
			questionService.insertUserAnswer(answer);
		} else {
			questionService.updateUserAnswer(answer);
		}

		// 질문 목록 및 세부 정보
		List<QuestionListDTO> questions = questionService.selectSloveQuestionListsByTestId(params);
		if (questionId != null) {
			currentQuestionId = questionId;
		} else {
			currentQuestionId = nextQuestionId;
		}

		QuestionDetailDTO questionDetail = questionService.selectQuestionById(currentQuestionId);
		String userAnswer = questionService.selectUserAnswer(params);

		QuestionDetailWithUserAnswerDTO detailWithAnswer = new QuestionDetailWithUserAnswerDTO();
		detailWithAnswer.setId(questionDetail.getId());
		detailWithAnswer.setQuestion_text(questionDetail.getQuestion_text());
		detailWithAnswer.setQuestion_type(questionDetail.getQuestion_type());
		detailWithAnswer.setOptions(questionDetail.getOptions());
		detailWithAnswer.setUserAnswer(userAnswer);
		detailWithAnswer.setScore(questionDetail.getScore());

		Integer nextQuestionIdToSend = null;
		if (currentQuestionId != questions.get(questions.size() - 1).getId()) {
			QuestionDetailDTO nextQuestionDetail = questionService.selectNextQuestionById(currentQuestionId);
			nextQuestionIdToSend = nextQuestionDetail.getId();
		}

		CourseVO course = courseService.selectCourseById(test.getCourse_id());

		return new SolveQuestionDTO(questions, testId, userId, userParticipation.getEndTimeAsISO(), detailWithAnswer, currentQuestionId, nextQuestionIdToSend, course, false);
	}

	@Override
	public TestReviewDTO getTestReview(int testId, Integer questionId) {
		UserVO user = userService.getCurrentUser();
		int userId = user.getId();

		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("testId", testId);

		// 질문 목록 조회
		List<QuestionListDTO> questions = questionService.selectReviewQuestionListsByTestId(params);

		// 선택된 질문 ID 결정
		Integer id = (questionId == null) ? questions.get(0).getId() : questionId;
		params.put("questionId", id);

		// 질문 세부 정보 조회
		QuestionDetailDTO questionDetail = questionService.selectQuestionById(id);

		// 사용자 답안 조회
		String userAnswer = questionService.selectUserAnswer(params);

		// 사용자 답안과 질문 세부 정보를 변환
		QuestionDetailWithUserAnswerDTO detailWithAnswer = new QuestionDetailWithUserAnswerDTO();
		detailWithAnswer.setId(questionDetail.getId());
		detailWithAnswer.setQuestion_text(questionDetail.getQuestion_text());
		detailWithAnswer.setQuestion_type(questionDetail.getQuestion_type());
		detailWithAnswer.setOptions(questionDetail.getOptions());
		detailWithAnswer.setUserAnswer(userAnswer);
		detailWithAnswer.setScore(questionDetail.getScore());

		// 시험 및 강좌 정보 조회
		TestVO test = courseService.selectTestById(testId);
		CourseVO course = courseService.selectCourseById(test.getCourse_id());

		// DTO 생성 및 반환
		return new TestReviewDTO(testId, questions, detailWithAnswer, id, questionDetail, questionDetail.getCorrect_answer(), course, false);
	}

	private void validateTestCompletion(TestVO test, ExamParticipationVO userParticipation, Timestamp now) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis(test.getEnd_time().getTime());
		calendar.add(Calendar.MINUTE, 1);

		if (calendar.getTimeInMillis() < now.getTime()) {
			throw new CustomException("이미 완료된 시험입니다");
		}

		if (userParticipation != null) {
			calendar.setTimeInMillis(userParticipation.getEnd_time().getTime());
			calendar.add(Calendar.MINUTE, 1);
			if (calendar.getTimeInMillis() < now.getTime() || userParticipation.getStatus().equals("완료")) {
				throw new CustomException("이미 완료된 시험입니다");
			}
		}
	}

	private AnswerDTO createAnswerDTO(HttpServletRequest request, String questionType, int testId, int currentQuestionId, int userId) {
		AnswerDTO answer = new AnswerDTO();
		answer.setQuestion_id(currentQuestionId);
		answer.setTest_id(testId);
		answer.setUser_id(userId);

		if ("주관식".equals(questionType)) {
			String user_answer = request.getParameter("subjectiveAnswer");
			answer.setAnswer(user_answer);
		} else if ("객관식".equals(questionType)) {
			String user_answer = request.getParameter("answer");
			answer.setAnswer(user_answer);
		}
		// 서술형은 구현 생략
		return answer;
	}

	private void initiateExamParticipation(Map<String, Object> params, TestVO test) {
		Timestamp startTime = new Timestamp(System.currentTimeMillis());

		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis(startTime.getTime());
		calendar.add(Calendar.MINUTE, test.getTime_limit());
		Timestamp calculatedEndTime = new Timestamp(calendar.getTimeInMillis());
		Timestamp existingEndTime = test.getEnd_time();

		Timestamp endTime = calculatedEndTime.compareTo(existingEndTime) < 0 ? calculatedEndTime : existingEndTime;

		params.put("startTime", startTime);
		params.put("endTime", endTime);
		params.put("status", "시험중");

		questionService.insertExamParticipation(params);
	}

}
