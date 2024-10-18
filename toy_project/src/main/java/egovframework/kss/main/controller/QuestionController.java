package egovframework.kss.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/question")
public class QuestionController {

	@PostMapping("/questionCreate.do")
	public String questionCreate(Model model) {

		return "testEditPage";
	}

}
