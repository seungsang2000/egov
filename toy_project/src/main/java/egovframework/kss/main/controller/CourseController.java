package egovframework.kss.main.controller;

import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.kss.main.dto.CourseEnrollListDTO;
import egovframework.kss.main.exception.CustomException;
import egovframework.kss.main.service.CourseService;
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
			System.out.println("CustomException 발생: 로그인 후 다시 시도해주세요");
			throw new CustomException("로그인 후 다시 시도해주세요");
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

		List<?> list = courseService.selectTestInCourse(id);
		model.addAttribute("list", list);
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
	public String testCreatePage(@RequestParam("courseId") int courseId, Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("loggedInUser");

		if (user == null) {

			throw new CustomException("로그인 후 다시 시도해주세요");

		} else {
			CourseVO courseVO = courseService.selectCourseById(courseId);
			if (courseVO.getInstructor_id() != user.getId()) {
				throw new CustomException("해당 강좌에 대한 권한이 없습니다");
			}
		}

		model.addAttribute("courseId", courseId);
		return "testCreatePage";
	}

	@PostMapping("/testCreate.do")
	public String testCreate(HttpServletRequest request) {
		Logger.debug("---------------");

		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("loggedInUser");

		String name = request.getParameter("name");
		String description = request.getParameter("description");
		int duration = Integer.parseInt(request.getParameter("duration"));
		String startTimeString = request.getParameter("start_time");
		String endTimeString = request.getParameter("end_time");
		int courseId = Integer.parseInt(request.getParameter("course_id"));

		// 날짜/시간 문자열을 LocalDateTime으로 변환
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
		LocalDateTime startDateTime = LocalDateTime.parse(startTimeString, formatter);
		LocalDateTime endDateTime = LocalDateTime.parse(endTimeString, formatter);

		// LocalDateTime을 Timestamp로 변환
		Timestamp start_time = Timestamp.valueOf(startDateTime);
		Timestamp end_time = Timestamp.valueOf(endDateTime);

		if (user == null) {
			throw new CustomException("로그인 후 다시 시도해주세요");
		} else {
			CourseVO courseVO = courseService.selectCourseById(courseId);
			if (courseVO.getInstructor_id() != user.getId()) {
				throw new CustomException("해당 강좌에 대한 권한이 없습니다");
			}
		}

		// TestVO 객체 생성
		TestVO test = new TestVO();
		test.setName(name);
		test.setDescription(description);
		test.setDuration(duration);
		test.setStart_time(start_time);
		test.setEnd_time(end_time);
		test.setCourse_id(courseId);

		courseService.registerTest(test);

		return "redirect:/course.do?id=" + test.getCourse_id();
	}

	@DeleteMapping("/testDelete.do")
	public ResponseEntity<Void> deleteTest(@RequestParam("id") int testId) { //ResponseEntity도 함 써보자
		try {
			courseService.deleteTest(testId);
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

}
