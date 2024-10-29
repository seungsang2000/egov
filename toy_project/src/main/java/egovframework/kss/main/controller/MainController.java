package egovframework.kss.main.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.kss.main.dto.CourseScoreDTO;
import egovframework.kss.main.dto.CourseUserCountDTO;
import egovframework.kss.main.service.CourseService;
import egovframework.kss.main.service.QuestionService;
import egovframework.kss.main.service.UserService;
import egovframework.kss.main.vo.UserVO;

@Controller
public class MainController {

	@Resource(name = "QuestionService")
	private QuestionService questionService;

	@Resource(name = "UserService")
	private UserService userService;

	@Resource(name = "CourseService")
	private CourseService courseService;

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

	@RequestMapping(value = "/chart.do")
	public String userChart(Model model) {
		UserVO user = userService.getCurrentUser();
		model.addAttribute("pageName", "userChart");
		List<CourseScoreDTO> courseScores = courseService.selectCourseScores(user.getId());
		model.addAttribute("courseScores", courseScores);

		List<CourseUserCountDTO> courseUserCount = courseService.selectCourseUserCounts(user.getId());
		model.addAttribute("courseUserCount", courseUserCount);

		return "userChart";

	}

}
