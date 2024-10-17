package egovframework.kss.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainController {

	@RequestMapping(value = "/main.do")
	public String loginPage() {
		return "login";
	}

	@RequestMapping(value = "/list.do")
	public String listPage() {
		return "list";
	}

	@RequestMapping(value = "/chkusr.do")
	public String checkUser() {
		return "chkusr";
	}

	@RequestMapping(value = "/egovSampleList.do")
	public String egovSampleList() {
		return "home";
	}

	@RequestMapping(value = "/errorPage.do")
	public String errorPage(@RequestParam(required = false) String error, Model model) {
		model.addAttribute("error", error);
		return "error";
	}

}
