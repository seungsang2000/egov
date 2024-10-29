package egovframework.kss.main.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.kss.main.dto.CourseEnrollListDTO;
import egovframework.kss.main.exception.CustomException;
import egovframework.kss.main.model.Notification;
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

	private final SimpMessagingTemplate messagingTemplate;

	@Autowired
	public CourseController(SimpMessagingTemplate messagingTemplate) {
		this.messagingTemplate = messagingTemplate;
	}

	private String saveImage(MultipartFile file) {
		String uploadDir = "C:\\upload\\"; // 실제 경로
		String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename(); // 중복 방지
		File destinationFile = new File(uploadDir + fileName);

		try {
			file.transferTo(destinationFile); // 파일 저장
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "upload/" + fileName; // 저장된 이미지 경로 반환 (웹에서 접근할 수 있도록)
	}

	@RequestMapping(value = "/mainPage.do")
	public String home(Model model) {
		Logger.debug("CourseList.......");

		// 강좌 목록을 가져온다
		List<?> list = courseService.selectCourseList();
		model.addAttribute("list", list);

		// 강좌 목록 가져오기
		UserVO user = userService.getCurrentUser();
		List<CourseVO> courseList = courseService.selectMyCourseList(user.getId());
		// 모델에 강좌 목록 추가
		model.addAttribute("list", courseList);

		model.addAttribute("pageName", "myCourses");

		Notification notification = new Notification();
		notification.setMessage("유저가 입장하셨습니당: " + user.getName());

		// 클라이언트에 메시지 전송
		messagingTemplate.convertAndSend("/topic/notifications", notification);

		return "home";
	}

	@RequestMapping(value = "/courseCreate.do")
	public String courseRegister(Model model) {
		model.addAttribute("pageName", "courseCreate");

		return "courseAdd";
	}

	@PostMapping("/courseCreate.do")
	public String courseCreate(@ModelAttribute CourseVO course, @RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile, HttpServletRequest request) {
		UserVO user = userService.getCurrentUser();

		course.setInstructor_id(user.getId());
		course.setCreated_at(Timestamp.from(Instant.now()));

		if (uploadFile != null && !uploadFile.isEmpty()) {
			String imagePath = saveImage(uploadFile); // 이미지 저장
			course.setImage_path(imagePath); // CourseVO에 이미지 경로 설정
		}

		courseService.registerCourse(course);

		return "redirect:/mainPage.do";
	}

	@RequestMapping("/course.do")
	public String selectCourse(@RequestParam("id") int id, Model model, HttpServletRequest request) {
		UserVO user = userService.getCurrentUser();

		CourseVO course = courseService.selectCourseById(id);
		model.addAttribute("course", course);

		if (user.getRole().equals("user")) { // 학생
			Map<String, Object> params = new HashMap<>();
			params.put("courseId", id);
			params.put("userId", user.getId());

			List<?> list = courseService.selectTestInCourseWithUser(params);
			model.addAttribute("list", list);

			int totalStudent = courseService.selectTotalStudentsByCourseId(id);
			model.addAttribute("totalStudent", totalStudent);

			return "tests_user";
		} else { // 강사
			List<?> list = courseService.selectTestInCourse(id);
			model.addAttribute("list", list);
			int totalStudent = courseService.selectTotalStudentsByCourseId(id);
			model.addAttribute("totalStudent", totalStudent);
			if (course.getInstructor_id() == user.getId()) {
				model.addAttribute("is_instructor", true);
			} else {
				model.addAttribute("is_instructor", false);
			}
			return "tests";
		}

	}

	@RequestMapping("/courseEnroll.do")
	public String courseEnrollPage(Model model, HttpServletRequest request) {
		UserVO user = userService.getCurrentUser();

		// 강좌 목록을 가져온다
		List<CourseEnrollListDTO> courseList = courseService.selectCourseEnrollList(user.getId());
		// 모델에 강좌 목록 추가
		model.addAttribute("courseList", courseList);

		model.addAttribute("pageName", "courseEnroll");
		return "courseEnrolls";
	}

	@PostMapping("/courseEnroll.do")
	@ResponseBody
	public Map<String, Object> enrollCourse(@RequestParam("courseId") int courseId) {
		Logger.debug("enroll----------------------");
		Map<String, Object> response = new HashMap<>();
		UserVO user = userService.getCurrentUser();

		try {
			// 강좌 등록 로직
			courseService.enrollUserInCourse(courseId, user);
			response.put("success", true);
			response.put("message", "강좌가 등록되었습니다");
		} catch (Exception e) {
			// 예외 처리
			response.put("success", false);
			response.put("message", "강좌 등록 중 오류가 발생했습니다");
		}

		return response;
	}

	@RequestMapping("/courseEditList.do")
	public String courseEditList(Model model) {
		UserVO user = userService.getCurrentUser();

		// 강좌 목록을 가져온다
		List<CourseVO> courseList = courseService.selectEditCourseList(user.getId());
		// 모델에 강좌 목록 추가
		model.addAttribute("courseList", courseList);

		model.addAttribute("pageName", "courseEdit");
		return "courseEditList";
	}

	@RequestMapping("/couresEdit.do")
	public String courseEdit(Model model, @RequestParam("courseId") int courseId) {

		CourseVO courseVO = courseService.selectCourseById(courseId);

		model.addAttribute("course", courseVO);
		model.addAttribute("pageName", "courseEdit");
		return "courseEditPage";
	}

	@PostMapping("/courseUpdate.do")
	public String courseUpdate(@ModelAttribute CourseVO newCourse, @RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile, HttpServletRequest request) {

		CourseVO course = courseService.selectCourseById(newCourse.getId());
		course.setDescription(newCourse.getDescription());
		course.setStatus(newCourse.getStatus());
		course.setTitle(newCourse.getTitle());

		if (uploadFile != null && !uploadFile.isEmpty()) {
			String imagePath = saveImage(uploadFile); // 이미지 저장
			course.setImage_path(imagePath); // CourseVO에 이미지 경로 설정
		}

		courseService.updateCourse(course);

		return "redirect:/courseEditList.do";
	}

	@RequestMapping(value = "/testCreatePage.do")
	public String testCreatePage(@RequestParam("courseId") int courseId, Model model, HttpServletRequest request) {
		UserVO user = userService.getCurrentUser();

		CourseVO courseVO = courseService.selectCourseById(courseId);
		if (courseVO.getInstructor_id() != user.getId()) {
			throw new CustomException("해당 강좌에 대한 권한이 없습니다");
		}

		model.addAttribute("courseId", courseId);
		return "testCreatePage";
	}

	@PostMapping("/testCreate.do")
	public String testCreate(HttpServletRequest request) {
		Logger.debug("---------------");

		UserVO user = userService.getCurrentUser();

		String name = request.getParameter("name");
		String description = request.getParameter("description");
		int time_limit = Integer.parseInt(request.getParameter("time_limit"));
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

		CourseVO courseVO = courseService.selectCourseById(courseId);
		if (courseVO.getInstructor_id() != user.getId()) {
			throw new CustomException("해당 강좌에 대한 권한이 없습니다");
		}

		// TestVO 객체 생성
		TestVO test = new TestVO();
		test.setName(name);
		test.setDescription(description);
		test.setTime_limit(time_limit);
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

	@PostMapping("/testComplete.do")
	@ResponseBody
	public ResponseEntity<String> completeTest(@RequestParam("testId") int testId) {
		try {
			courseService.completeTest(testId);
			return ResponseEntity.ok("시험 완료 처리 성공");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}

	}

}
