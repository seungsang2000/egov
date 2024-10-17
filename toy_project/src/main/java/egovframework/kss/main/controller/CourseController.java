package egovframework.kss.main.controller;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.kss.main.dto.CourseEnrollListDTO;
import egovframework.kss.main.service.CourseService;
import egovframework.kss.main.service.ErrorService;
import egovframework.kss.main.service.UserService;
import egovframework.kss.main.vo.CourseVO;
import egovframework.kss.main.vo.TestVO;
import egovframework.kss.main.vo.UserVO;

@Controller
public class CourseController {
	private static Logger Logger = LoggerFactory.getLogger(CourseController.class);

	@Resource(name = "CourseService")
	private CourseService courseService;

	@Resource(name = "UserService")
	private UserService userService;

	@Resource(name = "ErrorService")
	ErrorService errorService;

	@RequestMapping(value = "/mainPage.do")
	public String home(Model model, HttpServletRequest request) {

		Logger.debug("CourseList.......");
		List<?> list = courseService.selectCourseList();
		model.addAttribute("list", list);

		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("loggedInUser");

		if (user == null) {
			model.addAttribute("message", "로그인해 주세요.");
		} else {
			UserVO CurrentUser = userService.selectUserByEmail(user.getEmail());

			// 강좌 목록을 가져온다
			List<CourseVO> courseList = courseService.selectMyCourseList(CurrentUser.getId());
			// 모델에 강좌 목록 추가
			model.addAttribute("list", courseList);
		}

		model.addAttribute("pageName", "myCourses");

		return "home";
	}

	@RequestMapping(value = "/courseRegister.do")
	public String courseRegister(Model model) {
		model.addAttribute("pageName", "courseRegister");

		return "courseAdd";
	}

	@PostMapping("/courseCreate.do")
	public String courseCreate(@ModelAttribute CourseVO course, HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("loggedInUser");

		if (user == null) {
			return errorService.redirectErrorPage("로그인 후 다시 시도해주세요");
		}

		course.setInstructor_id(user.getId());
		course.setCreated_at(Timestamp.from(Instant.now()));

		courseService.registerCourse(course);

		return "redirect:/mainPage.do";
	}

	@RequestMapping("/course.do")
	public String selectCourse(@RequestParam("id") int id, Model model) {
		System.out.println("course id: " + id);
		CourseVO course = courseService.selectCourseById(id);
		model.addAttribute("course", course);
		return "tests";
	}

	@RequestMapping("/courseEnroll.do")
	public String courseEnrollPage(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("loggedInUser");

		if (user == null) {
			List<?> courseList = courseService.selectCourseList();
			model.addAttribute("courseList", courseList);
		} else {
			UserVO CurrentUser = userService.selectUserByEmail(user.getEmail());

			// 강좌 목록을 가져온다
			List<CourseEnrollListDTO> courseList = courseService.selectCourseEnrollList(CurrentUser.getId());
			// 모델에 강좌 목록 추가
			model.addAttribute("courseList", courseList);
		}

		model.addAttribute("pageName", "courseEnroll");
		return "courseEnrolls";
	}

	@PostMapping("/courseEnroll.do")
	@ResponseBody
	public Map<String, Object> enrollCourse(@RequestParam("courseId") int courseId, HttpServletRequest request) {
		Logger.debug("enroll----------------------");
		Map<String, Object> response = new HashMap<>();
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("loggedInUser"); // 예시로 세션에서 사용자 이메일을 가져옴

		if (user == null) {
			response.put("success", false);
			response.put("message", "로그인 후 신청해 주세요.");
			return response;
		}

		UserVO CurrentUser = userService.selectUserByEmail(user.getEmail());

		try {
			// 강좌 등록 로직
			courseService.enrollUserInCourse(courseId, CurrentUser);
			response.put("success", true);
			response.put("message", "강좌가 등록되었습니다");
		} catch (Exception e) {
			// 예외 처리
			response.put("success", false);
			response.put("message", "강좌 등록 중 오류가 발생했습니다");
		}

		return response;
	}

	@RequestMapping(value = "/testCreatePage.do")
	public String testCreatePage(@RequestParam("courseId") int courseId, Model model) {

		model.addAttribute("courseId", courseId);
		return "testCreatePage";
	}

	@PostMapping("/testCreatePage.do")
	public String testCreate(@ModelAttribute TestVO test, HttpServletRequest request) {

		return "redirect:/course.do?id=" + test.getCourse_id();
	}

}
