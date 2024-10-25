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
import egovframework.kss.main.service.QuestionService;
import egovframework.kss.main.service.UserService;
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

	@PostMapping("/questionCreate.do")
	public String questionCreate(Model model, HttpServletRequest request) { // request.getParameter 방식도 시도해본다

		Logger.debug("문제 생성 ---------------------------");

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
	
			return "testEditPage";
		}*/

	@RequestMapping(value = "/testEdit.do")
	public String testEditPage(@RequestParam(value = "testId") int testId, @RequestParam(value = "questionId", required = false) Integer questionId, Model model) {
		model.addAttribute("testId", testId);
		model.addAttribute("selectedQuestionId", questionId);
		int totalScore = questionService.getTotalScoreByTestId(testId);
		model.addAttribute("totalScore", totalScore);

		if (questionId != null) {
			// 특정 문제 확인
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

			return "testEditPage";
		}

	}

	@RequestMapping(value = "/testView.do")
	public String testViewPage(@RequestParam(value = "testId") int testId, @RequestParam(value = "questionId", required = false) Integer questionId, Model model) {
		Logger.debug("문제 보기 ---------------------------");

		model.addAttribute("testId", testId);

		int totalScore = questionService.getTotalScoreByTestId(testId);
		model.addAttribute("totalScore", totalScore);
		List<QuestionListDTO> questions = questionService.selectQuestionListsByTestId(testId);
		model.addAttribute("questions", questions);
		Integer id = 0;
		if (questionId == null) {
			id = questions.get(0).getId(); // 받은 문제 id가 없으면 첫번째 문제 보기
		} else {
			id = questionId;
		}

		model.addAttribute("selectedQuestionId", id);
		QuestionDetailDTO questionDetail = questionService.selectQuestionById(id);
		model.addAttribute("questionDetail", questionDetail);
		model.addAttribute("editable", false);

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

		return "updateQuestionPage";

	}

	@PostMapping("/questionUpdate.do")
	@ResponseBody
	public ResponseEntity<String> questionUpdate(HttpServletRequest request) {
		Logger.debug("문제 수정 ---------------------------");

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

			return ResponseEntity.ok("문제가 수정되었습니다."); // 성공 메시지 반환
		} catch (Exception e) {
			Logger.error("문제 수정 중 오류 발생: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("수정에 실패했습니다."); // 실패 메시지 반환
		}
	}

	@RequestMapping(value = "/solveTest.do")
	public String solveTest(@RequestParam(value = "testId") int testId, @RequestParam(value = "questionId", required = false) Integer questionId, Model model) {

		List<QuestionListDTO> questions = questionService.selectQuestionListsByTestId(testId);

		if (questionId == null) {
			questionId = questions.get(0).getId(); // 받은 문제 id가 없으면 첫번째 문제 보기
		}

		UserVO user = userService.getCurrentUser();
		int userId = user.getId();

		Map<String, Object> params = new HashMap<>();
		params.put("questionId", questionId);
		params.put("userId", userId);
		params.put("testId", testId);
		ExamParticipationVO userParticipation = questionService.selectExamParticipation(params);

		Timestamp now = new Timestamp(System.currentTimeMillis());
		if (userParticipation != null) {
			if (userParticipation.getEnd_time().before(now) || userParticipation.getStatus().equals("완료")) {
				throw new CustomException("이미 완료된 시험입니다");
			}
		}

		if (!questionService.checkExamParticipationExists(params)) {
			System.out.println("시험 응시 시작~~~~~~~~"); //유저 시험 참여
			TestVO test = courseService.selectTestById(testId);

			Timestamp startTime = new Timestamp(System.currentTimeMillis());

			// 시간 더하기
			Calendar calendar = Calendar.getInstance();
			calendar.setTimeInMillis(startTime.getTime());
			calendar.add(Calendar.MINUTE, test.getTime_limit());
			Timestamp endTime = new Timestamp(calendar.getTimeInMillis());

			String status = "시험중";
			params.put("startTime", startTime);
			params.put("endTime", endTime);
			params.put("status", status);

			questionService.insertExamParticipation(params);
		} else {
			System.out.println("시험 중복 응시~~~~~~~~");
		}

		model.addAttribute("endTime", userParticipation.getEndTimeAsISO());

		model.addAttribute("testId", testId);
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

		model.addAttribute("currentQuestion", detailWithAnswer);
		model.addAttribute("editable", false);

		if (questionId != questions.get(questions.size() - 1).getId()) {
			QuestionDetailDTO nextQuestionDetail = questionService.selectNextQuestionById(questionId);
			model.addAttribute("nextQuestionId", nextQuestionDetail.getId());
		}

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
		if (userParticipation != null) {
			if (userParticipation.getEnd_time().before(now) || userParticipation.getStatus().equals("완료")) {
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

		List<QuestionListDTO> questions = questionService.selectQuestionListsByTestId(testId);
		model.addAttribute("questions", questions);
		model.addAttribute("testId", testId);

		if (questionId != null) {
			// questionId가 있을 때의 처리
			// 예: 해당 질문에 대한 로직 수행
			// 예: 문제를 해결하거나 답변 제출
			currentQuestionId = questionId;
		} else {
			// questionId가 없을 때의 처리
			// 예: 기본 질문 또는 오류 처리
			currentQuestionId = nextQuestionId;
		}

		QuestionDetailDTO questionDetail = questionService.selectQuestionById(currentQuestionId);

		params.put("questionId", currentQuestionId);

		model.addAttribute("endTime", userParticipation.getEndTimeAsISO());

		String userAnswer = questionService.selectUserAnswer(params);

		QuestionDetailWithUserAnswerDTO detailWithAnswer = new QuestionDetailWithUserAnswerDTO(); // 변환
		detailWithAnswer.setId(questionDetail.getId());
		detailWithAnswer.setQuestion_text(questionDetail.getQuestion_text());
		detailWithAnswer.setQuestion_type(questionDetail.getQuestion_type());
		detailWithAnswer.setOptions(questionDetail.getOptions());
		detailWithAnswer.setUserAnswer(userAnswer);
		model.addAttribute("currentQuestion", detailWithAnswer);
		model.addAttribute("selectedQuestionId", questionDetail.getId());
		model.addAttribute("editable", false);

		if (currentQuestionId != questions.get(questions.size() - 1).getId()) {
			QuestionDetailDTO nextQuestionDetail = questionService.selectNextQuestionById(currentQuestionId);
			model.addAttribute("nextQuestionId", nextQuestionDetail.getId());
		}

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

		return "startTestPage";
	}

}
