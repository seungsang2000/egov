package egovframework.kss.main.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.kss.main.dto.AnswerDTO;
import egovframework.kss.main.dto.QuestionDetailDTO;
import egovframework.kss.main.dto.QuestionDetailWithUserAnswerDTO;
import egovframework.kss.main.dto.QuestionListDTO;
import egovframework.kss.main.exception.CustomException;
import egovframework.kss.main.model.Option;
import egovframework.kss.main.model.Question;
import egovframework.kss.main.service.CourseService;
import egovframework.kss.main.service.NotificationService;
import egovframework.kss.main.service.QuestionService;
import egovframework.kss.main.service.UserService;
import egovframework.kss.main.vo.CourseVO;
import egovframework.kss.main.vo.ExamParticipationVO;
import egovframework.kss.main.vo.TestVO;
import egovframework.kss.main.vo.UserVO;

@Controller
@RequestMapping("/question")
public class QuestionController {

	private static Logger Logger = LoggerFactory.getLogger(QuestionController.class);

	@Resource(name = "QuestionService")
	private QuestionService questionService;

	@Resource(name = "UserService")
	private UserService userService;

	@Resource(name = "CourseService")
	private CourseService courseService;

	@Resource(name = "NotificationService")
	private NotificationService notificationService;

	@PostMapping("/questionCreate.do")
	public String questionCreate(Model model, HttpServletRequest request) { // request.getParameter 방식도 시도해본다

		String questionType = request.getParameter("question_type");
		int testId = Integer.parseInt(request.getParameter("test_id"));

		int score = Integer.parseInt(request.getParameter("score"));

		Question question = new Question();
		question.setTest_id(testId);
		question.setQuestion_type(questionType);
		question.setScore(score);

		// 주관식, 서술형, 객관식 구분 및 처리
		if (questionType.equals("주관식")) {
			String questionText = request.getParameter("subjectiveQuestion");
			String correctAnswer = request.getParameter("subjectiveAnswer");
			question.setQuestion_text(questionText);
			question.setCorrect_answer(correctAnswer);
			questionService.insertSubjectiveQuestion(question);
		} else if (questionType.equals("서술형")) {
			String questionText = request.getParameter("descriptiveQuestion");
			question.setQuestion_text(questionText);
			questionService.insertDescriptiveQuestion(question);
		} else if (questionType.equals("객관식")) {
			String questionText = request.getParameter("question");
			String correctAnswer = request.getParameter("answer");
			question.setQuestion_text(questionText);
			question.setCorrect_answer(correctAnswer);

			// 객관식 옵션 리스트
			List<Option> options = new ArrayList<>();
			options.add(new Option(1, request.getParameter("option1")));
			options.add(new Option(2, request.getParameter("option2")));
			options.add(new Option(3, request.getParameter("option3")));
			options.add(new Option(4, request.getParameter("option4")));

			questionService.insertMultipleChoiceQuestion(question, options);
		}

		return "redirect:/question/testEdit.do?testId=" + testId;
	}

	/*	@RequestMapping(value = "testEdit.do")
		public String testEditPage(@RequestParam("testId") int testId, Model model) {
	
			model.addAttribute("testId", testId);
	
			return "createQuestionPage";
		}*/

	@RequestMapping(value = "/testEdit.do")
	public String testEditPage(@RequestParam(value = "testId") int testId, @RequestParam(value = "questionId", required = false) Integer questionId, Model model) {
		model.addAttribute("testId", testId);
		model.addAttribute("selectedQuestionId", questionId);
		int totalScore = questionService.getTotalScoreByTestId(testId);
		model.addAttribute("totalScore", totalScore);

		TestVO test = courseService.selectTestById(testId);
		CourseVO course = courseService.selectCourseById(test.getCourse_id());
		model.addAttribute("test", test);
		model.addAttribute("course", course);

		if (questionId != null) {
			QuestionDetailDTO questionDetail = questionService.selectQuestionById(questionId);
			model.addAttribute("questionDetail", questionDetail);
			model.addAttribute("editable", false);

			List<QuestionListDTO> questions = questionService.selectQuestionListsByTestId(testId);
			model.addAttribute("questions", questions);

			return "viewQuestionPage";
		} else {
			// 문제 생성
			List<QuestionListDTO> questions = questionService.selectQuestionListsByTestId(testId);
			model.addAttribute("questions", questions);

			return "createQuestionPage";
		}

	}

	@RequestMapping(value = "/testView.do")
	public String testViewPage(@RequestParam(value = "testId") int testId, @RequestParam(value = "questionId", required = false) Integer questionId, Model model) {

		model.addAttribute("testId", testId);

		int totalScore = questionService.getTotalScoreByTestId(testId);
		model.addAttribute("totalScore", totalScore);
		List<QuestionListDTO> questions = questionService.selectQuestionListsByTestId(testId);
		model.addAttribute("questions", questions);
		Integer id = 0;
		if (questionId == null) {
			id = questions.get(0).getId();
		} else {
			id = questionId;
		}

		model.addAttribute("selectedQuestionId", id);
		QuestionDetailDTO questionDetail = questionService.selectQuestionById(id);
		model.addAttribute("questionDetail", questionDetail);
		model.addAttribute("editable", false);

		TestVO test = courseService.selectTestById(testId);
		CourseVO course = courseService.selectCourseById(test.getCourse_id());

		model.addAttribute("course", course);

		return "onlyViewQuestion";

	}

	@DeleteMapping("/questionDelete.do")
	@ResponseBody
	public ResponseEntity<String> deleteQuestion(@RequestParam("questionId") int questionId) {
		try {
			questionService.deleteQuestion(questionId);
			return ResponseEntity.ok("삭제 완료되었습니다.");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제에 실패했습니다.");
		}
	}

	@RequestMapping(value = "/questionUpdate.do")
	public String updateQuestion(@RequestParam("questionId") int questionId, @RequestParam("testId") int testId, Model model) {
		model.addAttribute("testId", testId);
		model.addAttribute("selectedQuestionId", questionId);
		int totalScore = questionService.getTotalScoreByTestId(testId);
		model.addAttribute("totalScore", totalScore);

		QuestionDetailDTO questionDetail = questionService.selectQuestionById(questionId);
		model.addAttribute("questionDetail", questionDetail);
		model.addAttribute("editable", false);

		List<QuestionListDTO> questions = questionService.selectQuestionListsByTestId(testId);
		model.addAttribute("questions", questions);

		TestVO test = courseService.selectTestById(testId);
		CourseVO course = courseService.selectCourseById(test.getCourse_id());

		model.addAttribute("course", course);
		model.addAttribute("test", test);

		return "updateQuestionPage";

	}

	@PostMapping("/questionUpdate.do")
	@ResponseBody
	public ResponseEntity<String> questionUpdate(HttpServletRequest request) {
		try {
			String questionType = request.getParameter("question_type");
			int testId = Integer.parseInt(request.getParameter("test_id"));
			int questionId = Integer.parseInt(request.getParameter("questionId"));
			int score = Integer.parseInt(request.getParameter("score"));

			Question question = new Question();
			question.setId(questionId); // 수정할 문제 ID 설정
			question.setTest_id(testId);
			question.setQuestion_type(questionType);
			question.setScore(score);

			// 주관식, 서술형, 객관식 구분 및 처리
			if (questionType.equals("주관식")) {
				String questionText = request.getParameter("subjectiveQuestion");
				String correctAnswer = request.getParameter("subjectiveAnswer");
				question.setQuestion_text(questionText);
				question.setCorrect_answer(correctAnswer);
				questionService.updateSubjectiveQuestion(question);
			} else if (questionType.equals("서술형")) {
				String questionText = request.getParameter("descriptiveQuestion");
				question.setQuestion_text(questionText);
				questionService.updateDescriptiveQuestion(question);
			} else if (questionType.equals("객관식")) {
				String questionText = request.getParameter("question");
				String correctAnswer = request.getParameter("answer");
				question.setQuestion_text(questionText);
				question.setCorrect_answer(correctAnswer);

				// 객관식 옵션 리스트
				List<Option> options = new ArrayList<>();
				options.add(new Option(1, request.getParameter("option1")));
				options.add(new Option(2, request.getParameter("option2")));
				options.add(new Option(3, request.getParameter("option3")));
				options.add(new Option(4, request.getParameter("option4")));

				questionService.updateMultipleChoiceQuestion(question, options);
			}

			return ResponseEntity.ok("문제가 수정되었습니다.");
		} catch (Exception e) {
			Logger.error("문제 수정 중 오류 발생: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("수정에 실패했습니다.");
		}
	}

	@RequestMapping(value = "/solveTest.do")
	@Transactional
	public String solveTest(@RequestParam(value = "testId") int testId, @RequestParam(value = "questionId", required = false) Integer questionId, Model model) {

		UserVO user = userService.getCurrentUser();
		int userId = user.getId();

		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("testId", testId);

		List<QuestionListDTO> questions = questionService.selectSloveQuestionListsByTestId(params);

		if (questionId == null) {
			questionId = questions.get(0).getId(); // 받은 문제 id가 없으면 첫번째 문제 보기
		}

		params.put("questionId", questionId);

		ExamParticipationVO userParticipation = questionService.selectExamParticipation(params);

		Timestamp now = new Timestamp(System.currentTimeMillis());

		TestVO test = courseService.selectTestById(testId);
		if (test.getEnd_time().before(now)) {
			throw new CustomException("이미 완료된 시험입니다");
		}

		if (userParticipation != null) {
			if (userParticipation.getEnd_time().before(now) || userParticipation.getStatus().equals("완료")) {
				throw new CustomException("이미 완료된 시험입니다");
			}
		}

		if (!questionService.checkExamParticipationExists(params)) {
			System.out.println("시험 응시 시작~~~~~~~~"); //유저 시험 참여

			Timestamp startTime = new Timestamp(System.currentTimeMillis());

			// 시간 더하기
			Calendar calendar = Calendar.getInstance();
			calendar.setTimeInMillis(startTime.getTime());
			calendar.add(Calendar.MINUTE, test.getTime_limit());
			Timestamp calculatedEndTime = new Timestamp(calendar.getTimeInMillis());
			Timestamp existingEndTime = test.getEnd_time();

			Timestamp endTime = calculatedEndTime.compareTo(existingEndTime) < 0 ? calculatedEndTime : existingEndTime;

			String status = "시험중";
			params.put("startTime", startTime);
			params.put("endTime", endTime);
			params.put("status", status);

			questionService.insertExamParticipation(params);
			userParticipation = questionService.selectExamParticipation(params);
		} else {
			System.out.println("시험 중복 응시~~~~~~~~");
		}

		model.addAttribute("endTime", userParticipation.getEndTimeAsISO());

		model.addAttribute("testId", testId);
		model.addAttribute("userId", user.getId());
		model.addAttribute("selectedQuestionId", questionId);

		model.addAttribute("questions", questions);

		QuestionDetailDTO questionDetail = questionService.selectQuestionById(questionId);

		String userAnswer = questionService.selectUserAnswer(params);

		QuestionDetailWithUserAnswerDTO detailWithAnswer = new QuestionDetailWithUserAnswerDTO(); // 변환
		detailWithAnswer.setId(questionDetail.getId());
		detailWithAnswer.setQuestion_text(questionDetail.getQuestion_text());
		detailWithAnswer.setQuestion_type(questionDetail.getQuestion_type());
		detailWithAnswer.setOptions(questionDetail.getOptions());
		detailWithAnswer.setUserAnswer(userAnswer);
		detailWithAnswer.setScore(questionDetail.getScore());

		model.addAttribute("currentQuestion", detailWithAnswer);
		model.addAttribute("editable", false);

		if (questionId != questions.get(questions.size() - 1).getId()) {
			QuestionDetailDTO nextQuestionDetail = questionService.selectNextQuestionById(questionId);
			model.addAttribute("nextQuestionId", nextQuestionDetail.getId());
		}

		CourseVO course = courseService.selectCourseById(test.getCourse_id());

		model.addAttribute("course", course);

		return "solveQuestion";
	}

	@PostMapping("/solveTest.do")
	public String solveQuestion(HttpServletRequest request, Model model, @RequestParam(value = "questionId", required = false) Integer questionId, @RequestParam(value = "nextQuestionId", required = false) Integer nextQuestionId) {
		String questionType = request.getParameter("questionType");
		int testId = Integer.parseInt(request.getParameter("testId"));
		int currentQuestionId = Integer.parseInt(request.getParameter("currentQuestionId"));
		UserVO user = userService.getCurrentUser();
		int userId = user.getId();
		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("testId", testId);
		ExamParticipationVO userParticipation = questionService.selectExamParticipation(params);

		Timestamp now = new Timestamp(System.currentTimeMillis());

		TestVO test = courseService.selectTestById(testId);

		Timestamp endTime = test.getEnd_time();
		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis(endTime.getTime());
		calendar.add(Calendar.MINUTE, 1); // 1분 추가(제출시 네트워크 오류등 대비하기 위해, post제출은 제한시간+ 1분까지 허용)

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

		AnswerDTO answer = new AnswerDTO();
		answer.setQuestion_id(currentQuestionId);
		answer.setTest_id(testId);
		answer.setUser_id(user.getId());

		if (questionType.equals("주관식")) {
			String user_answer = request.getParameter("subjectiveAnswer");
			answer.setAnswer(user_answer);
		} else if (questionType.equals("서술형")) {

		} else if (questionType.equals("객관식")) {

			String user_answer = request.getParameter("answer");
			answer.setAnswer(user_answer);
		}

		if (!questionService.checkUserAnswerExists(answer)) {
			System.out.println("답변 저장");
			questionService.insertUserAnswer(answer);
		} else {
			System.out.println("답변 업데이트");
			questionService.updateUserAnswer(answer);
		}

		List<QuestionListDTO> questions = questionService.selectSloveQuestionListsByTestId(params);
		model.addAttribute("questions", questions);
		model.addAttribute("testId", testId);
		model.addAttribute("userId", user.getId());
		if (questionId != null) {
			currentQuestionId = questionId;
		} else {
			currentQuestionId = nextQuestionId;
		}

		QuestionDetailDTO questionDetail = questionService.selectQuestionById(currentQuestionId);

		params.put("questionId", currentQuestionId);

		model.addAttribute("endTime", userParticipation.getEndTimeAsISO());

		String userAnswer = questionService.selectUserAnswer(params);

		QuestionDetailWithUserAnswerDTO detailWithAnswer = new QuestionDetailWithUserAnswerDTO();
		detailWithAnswer.setId(questionDetail.getId());
		detailWithAnswer.setQuestion_text(questionDetail.getQuestion_text());
		detailWithAnswer.setQuestion_type(questionDetail.getQuestion_type());
		detailWithAnswer.setOptions(questionDetail.getOptions());
		detailWithAnswer.setUserAnswer(userAnswer);
		detailWithAnswer.setScore(questionDetail.getScore());
		model.addAttribute("currentQuestion", detailWithAnswer);
		model.addAttribute("selectedQuestionId", questionDetail.getId());
		model.addAttribute("editable", false);

		if (currentQuestionId != questions.get(questions.size() - 1).getId()) {
			QuestionDetailDTO nextQuestionDetail = questionService.selectNextQuestionById(currentQuestionId);
			model.addAttribute("nextQuestionId", nextQuestionDetail.getId());
		}

		CourseVO course = courseService.selectCourseById(test.getCourse_id());

		model.addAttribute("course", course);

		return "solveQuestion";
	}

	@PostMapping("/userFinishTest.do")
	@ResponseBody
	public ResponseEntity<Integer> completeTest(HttpServletRequest request) {
		try {
			String questionType = request.getParameter("questionType");
			int testId = Integer.parseInt(request.getParameter("testId"));
			int currentQuestionId = Integer.parseInt(request.getParameter("currentQuestionId"));
			UserVO user = userService.getCurrentUser();
			int userId = user.getId();

			AnswerDTO answer = new AnswerDTO();
			answer.setQuestion_id(currentQuestionId);
			answer.setTest_id(testId);
			answer.setUser_id(user.getId());

			if (questionType.equals("주관식")) {
				String user_answer = request.getParameter("subjectiveAnswer");
				answer.setAnswer(user_answer);
			} else if (questionType.equals("서술형")) {

			} else if (questionType.equals("객관식")) {
				String user_answer = request.getParameter("answer");
				answer.setAnswer(user_answer);
			}

			if (!questionService.checkUserAnswerExists(answer)) {
				System.out.println("답변 저장");
				questionService.insertUserAnswer(answer);
			} else {
				System.out.println("답변 업데이트");
				questionService.updateUserAnswer(answer);
			}

			TestVO test = courseService.selectTestById(testId);
			int courseId = test.getCourse_id();

			Map<String, Object> params = new HashMap<>();
			params.put("testId", testId);
			params.put("userId", userId);
			ExamParticipationVO examParticipation = questionService.selectExamParticipation(params);
			examParticipation.setStatus("완료");
			questionService.updateExamParticipation(examParticipation);
			return ResponseEntity.ok(courseId);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}

	}

	@RequestMapping(value = "startTestPage.do")
	public String solveTestPage(@RequestParam("testId") int testId, Model model) {
		TestVO test = courseService.selectTestById(testId);
		model.addAttribute("test", test);

		UserVO user = userService.getCurrentUser();

		Map<String, Object> params = new HashMap<>();
		params.put("testId", test.getId());
		params.put("userId", user.getId());

		ExamParticipationVO examParticipation = questionService.selectExamParticipation(params);
		Timestamp now = new Timestamp(System.currentTimeMillis());

		if (test.getEnd_time().before(now)) {
			throw new CustomException("이미 완료된 시험입니다");
		}

		if (examParticipation != null) {
			if (examParticipation.getEnd_time().before(now) || examParticipation.getStatus().equals("완료")) {
				throw new CustomException("이미 완료된 시험입니다");
			} else {
				//참여한 적은 있는데, 시험 종료가 아직 안된경우. 즉 뒤로 가거나 튕겼다가 돌아온 경우
				model.addAttribute("examParticipation", examParticipation);
			}

		}

		CourseVO course = courseService.selectCourseById(test.getCourse_id());

		model.addAttribute("course", course);

		return "startTestPage";
	}

	@PostMapping("/testReEdit.do")
	public ResponseEntity<String> testReEdit(@RequestParam("id") int testId) {
		try {

			if (questionService.checkParticipatedStudentExists(testId)) {
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("이미 시험에 응시한 학생이 있습니다.");
			}

			courseService.incompleteTest(testId);

			return ResponseEntity.ok().build();
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

	@PostMapping("testGrading.do")
	public ResponseEntity<Void> testGrading(@RequestParam("id") int testId) { //ResponseEntity도 함 써보자
		try {
			TestVO test = courseService.selectTestById(testId);
			CourseVO course = courseService.selectCourseById(test.getCourse_id());
			String messageText = course.getTitle() + " 강좌에서 " + test.getName() + " 시험의 채점이 완료되었습니다";
			notificationService.sendNotificationByTestId(testId, messageText);

			questionService.testGrading(testId);
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

	@RequestMapping(value = "/testReview.do")
	public String testReview(@RequestParam("testId") int testId, @RequestParam(value = "questionId", required = false) Integer questionId, Model model) {
		model.addAttribute("testId", testId);

		UserVO user = userService.getCurrentUser();
		int userId = user.getId();

		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("testId", testId);

		List<QuestionListDTO> questions = questionService.selectReviewQuestionListsByTestId(params);
		model.addAttribute("questions", questions);

		Integer id = 0;
		if (questionId == null) {
			id = questions.get(0).getId();
		} else {
			id = questionId;
		}
		params.put("questionId", id);

		QuestionDetailDTO questionDetail = questionService.selectQuestionById(id);

		String userAnswer = questionService.selectUserAnswer(params);

		QuestionDetailWithUserAnswerDTO detailWithAnswer = new QuestionDetailWithUserAnswerDTO(); // 변환
		detailWithAnswer.setId(questionDetail.getId());
		detailWithAnswer.setQuestion_text(questionDetail.getQuestion_text());
		detailWithAnswer.setQuestion_type(questionDetail.getQuestion_type());
		detailWithAnswer.setOptions(questionDetail.getOptions());
		detailWithAnswer.setUserAnswer(userAnswer);
		detailWithAnswer.setScore(questionDetail.getScore());

		model.addAttribute("currentQuestion", detailWithAnswer);

		model.addAttribute("selectedQuestionId", id);
		model.addAttribute("questionDetail", questionDetail);
		model.addAttribute("editable", false);

		model.addAttribute("correct_answer", questionDetail.getCorrect_answer());

		TestVO test = courseService.selectTestById(testId);
		CourseVO course = courseService.selectCourseById(test.getCourse_id());

		model.addAttribute("course", course);

		return "testReview";
	}

}
