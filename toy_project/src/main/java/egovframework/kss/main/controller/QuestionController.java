package egovframework.kss.main.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/question")
public class QuestionController {

	@PostMapping("/questionCreate.do")
	public String questionCreate(Model model, HttpServletRequest request) { // getParameter 방식도 시도해본다
		String question_type = request.getParameter("question_type");
		System.out.println(question_type);

		return "testEditPage";
	}

}
