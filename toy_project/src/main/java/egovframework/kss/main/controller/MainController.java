package egovframework.kss.main.controller;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.kss.main.dto.CourseScoreDTO;
import egovframework.kss.main.dto.CourseUserCountDTO;
import egovframework.kss.main.service.CourseService;
import egovframework.kss.main.service.QuestionService;
import egovframework.kss.main.service.UserService;
import egovframework.kss.main.service.VideoService;
import egovframework.kss.main.vo.UserVO;

@Controller
public class MainController {

	private static Logger Logger = LoggerFactory.getLogger(UserController.class);

	@Resource(name = "QuestionService")
	private QuestionService questionService;

	@Resource(name = "UserService")
	private UserService userService;

	@Resource(name = "CourseService")
	private CourseService courseService;

	@Resource(name = "VideoService")
	private VideoService videoService;

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

		if (user.getRole().equals("admin")) {
			return "adminChart";
		} else {
			return "userChart";
		}

	}

	@PostMapping("/uploadVideo")
	@ResponseBody
	public String uploadVideo(@RequestParam("video") MultipartFile videoFile, @RequestParam("userId") String userId, @RequestParam("testId") String testId, @RequestParam("courseId") String courseId, @RequestParam("duration") String duration) {

		try {
			String result = videoService.uploadVideo(videoFile, userId, testId, courseId, duration);
			return "{\"message\":\"" + result + "\"}";
		} catch (Exception e) {
			e.printStackTrace();
			return "{\"message\":\"비디오 업로드 실패: " + e.getMessage() + "\"}";
		}
	}

}
