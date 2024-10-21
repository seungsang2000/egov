package egovframework.kss.main.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.kss.main.model.Option;
import egovframework.kss.main.model.Question;
import egovframework.kss.main.service.QuestionService;

@Controller
@RequestMapping("/question")
public class QuestionController {

	@Resource(name = "QuestionService")
	private QuestionService questionService;

	@PostMapping("/questionCreate.do")
	public String questionCreate(Model model, HttpServletRequest request) { // request.getParameter 방식도 시도해본다
		String questionType = request.getParameter("question_type");
		int testId = Integer.parseInt(request.getParameter("test_id"));

		Question question = new Question();
		question.setTestId(testId);
		question.setQuestionType(questionType);

		// 주관식, 서술형, 객관식 구분 및 처리
		if (questionType.equals("주관식")) {
			String questionText = request.getParameter("question");
			question.setQuestionText(questionText);
			questionService.insertSubjectiveQuestion(question);
		} else if (questionType.equals("서술형")) {
			String questionText = request.getParameter("descriptiveQuestion");
			question.setQuestionText(questionText);
			questionService.insertDescriptiveQuestion(question);
		} else if (questionType.equals("객관식")) {
			String questionText = request.getParameter("question");
			int correctAnswer = Integer.parseInt(request.getParameter("answer"));
			question.setQuestionText(questionText);
			question.setCorrectAnswer(correctAnswer);

			// 객관식 옵션 리스트
			List<Option> options = new ArrayList<>();
			options.add(new Option(1, request.getParameter("option1")));
			options.add(new Option(2, request.getParameter("option2")));
			options.add(new Option(3, request.getParameter("option3")));
			options.add(new Option(4, request.getParameter("option4")));

			questionService.insertMultipleChoiceQuestion(question, options);
		}

		return "redirect:/";
	}

}
