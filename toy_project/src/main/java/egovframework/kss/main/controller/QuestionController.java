package egovframework.kss.main.controller;

import java.util.ArrayList;
import java.util.List;

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

import egovframework.kss.main.dto.QuestionDetailDTO;
import egovframework.kss.main.dto.QuestionListDTO;
import egovframework.kss.main.model.Option;
import egovframework.kss.main.model.Question;
import egovframework.kss.main.service.QuestionService;
import egovframework.kss.main.service.UserService;

@Controller
@RequestMapping("/question")
public class QuestionController {

	private static Logger Logger = LoggerFactory.getLogger(QuestionController.class);

	@Resource(name = "QuestionService")
	private QuestionService questionService;

	@Resource(name = "UserService")
	private UserService userService;

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
		model.addAttribute("selectedQuestionId", questionId);
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

}
