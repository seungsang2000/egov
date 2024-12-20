package egovframework.kss.main.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
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
import egovframework.kss.main.dto.QuestionListDTO;
import egovframework.kss.main.dto.SolveQuestionDTO;
import egovframework.kss.main.dto.SolveTestDTO;
import egovframework.kss.main.dto.TestReviewDTO;
import egovframework.kss.main.exception.CustomException;
import egovframework.kss.main.model.Option;
import egovframework.kss.main.model.Question;
import egovframework.kss.main.service.CourseService;
import egovframework.kss.main.service.NotificationService;
import egovframework.kss.main.service.QuestionService;
import egovframework.kss.main.service.TestService;
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

	@Resource(name = "TestService")
	private TestService testService;

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

		try {
			SolveTestDTO solveTestDTO = testService.solveTest(testId, questionId);

			model.addAttribute("endTime", solveTestDTO.getEndTime());
			model.addAttribute("testId", solveTestDTO.getTestId());
			model.addAttribute("userId", solveTestDTO.getUserId());
			model.addAttribute("selectedQuestionId", solveTestDTO.getSelectedQuestionId());
			model.addAttribute("questions", solveTestDTO.getQuestions());
			model.addAttribute("currentQuestion", solveTestDTO.getCurrentQuestion());
			model.addAttribute("editable", solveTestDTO.isEditable());
			model.addAttribute("nextQuestionId", solveTestDTO.getNextQuestionId());
			model.addAttribute("course", solveTestDTO.getCourse());

			return "solveQuestion";
		} catch (CustomException e) {
			model.addAttribute("errorMessage", e.getMessage());
			return "errorPage";
		}
	}

	@PostMapping("/solveTest.do")
	@Transactional
	public String solveQuestion(HttpServletRequest request, Model model, @RequestParam(value = "questionId", required = false) Integer questionId, @RequestParam(value = "nextQuestionId", required = false) Integer nextQuestionId) {

		try {
			SolveQuestionDTO solveQuestionDTO = testService.solveQuestion(request, questionId, nextQuestionId);

			// 모델에 값 설정
			model.addAttribute("questions", solveQuestionDTO.getQuestions());
			model.addAttribute("testId", solveQuestionDTO.getTestId());
			model.addAttribute("userId", solveQuestionDTO.getUserId());
			model.addAttribute("endTime", solveQuestionDTO.getEndTime());
			model.addAttribute("currentQuestion", solveQuestionDTO.getCurrentQuestion());
			model.addAttribute("selectedQuestionId", solveQuestionDTO.getSelectedQuestionId());
			model.addAttribute("editable", solveQuestionDTO.isEditable());
			model.addAttribute("nextQuestionId", solveQuestionDTO.getNextQuestionId());
			model.addAttribute("course", solveQuestionDTO.getCourse());

			return "solveQuestion";
		} catch (CustomException e) {
			model.addAttribute("errorMessage", e.getMessage());
			return "errorPage";
		}
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

		TestReviewDTO reviewDTO = testService.getTestReview(testId, questionId);

		model.addAttribute("testId", reviewDTO.getTestId());
		model.addAttribute("questions", reviewDTO.getQuestions());
		model.addAttribute("currentQuestion", reviewDTO.getCurrentQuestion());
		model.addAttribute("selectedQuestionId", reviewDTO.getSelectedQuestionId());
		model.addAttribute("questionDetail", reviewDTO.getQuestionDetail());
		model.addAttribute("editable", reviewDTO.isEditable());
		model.addAttribute("correct_answer", reviewDTO.getCorrectAnswer());
		model.addAttribute("course", reviewDTO.getCourse());

		return "testReview";
	}

}
