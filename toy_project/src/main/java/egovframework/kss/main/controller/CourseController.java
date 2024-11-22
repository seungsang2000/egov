package egovframework.kss.main.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.kss.main.dto.CourseDetailDTO;
import egovframework.kss.main.dto.CourseEnrollListDTO;
import egovframework.kss.main.exception.CustomException;
import egovframework.kss.main.model.ChatMessage;
import egovframework.kss.main.service.CourseService;
import egovframework.kss.main.service.NotificationService;
import egovframework.kss.main.service.QuestionService;
import egovframework.kss.main.service.UserService;
import egovframework.kss.main.vo.CourseVO;
import egovframework.kss.main.vo.ExamParticipationVO;
import egovframework.kss.main.vo.NotificationVO;
import egovframework.kss.main.vo.TestVO;
import egovframework.kss.main.vo.UserVO;
import egovframework.kss.main.vo.messageVO;

@Controller
public class CourseController {
	private static Logger Logger = LoggerFactory.getLogger(CourseController.class);

	@Resource(name = "CourseService")
	private CourseService courseService;

	@Resource(name = "UserService")
	private UserService userService;

	@Resource(name = "NotificationService")
	private NotificationService notificationService;

	@Resource(name = "QuestionService")
	private QuestionService questionService;

	private String saveImage(MultipartFile file) {
		String uploadDir = "C:\\upload\\"; // 실제 경로
		String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename(); // 중복 방지
		File destinationFile = new File(uploadDir + fileName);

		try {
			file.transferTo(destinationFile); // 파일 저장
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "upload/" + fileName;
	}

	@RequestMapping(value = "/mainPage.do")
	public String home(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		// 강좌 목록 가져오기
		UserVO user = userService.getCurrentUser();
		List<CourseVO> courseList = courseService.selectMyCourseList(user.getId());
		// 모델에 강좌 목록 추가
		model.addAttribute("list", courseList);

		model.addAttribute("pageName", "myCourses");

		List<Integer> courseIds = courseList.stream().map(CourseVO::getId).collect(Collectors.toList());
		session.setAttribute("courseIds", courseIds);

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
	public String courseEnrollPage(Model model, HttpServletRequest request, @RequestParam(required = false, value = "search") String search) {
		UserVO user = userService.getCurrentUser();

		Map<String, Object> params = new HashMap<>();
		params.put("currentUserId", user.getId());
		params.put("search", search);

		// 강좌 목록을 가져온다
		List<CourseEnrollListDTO> courseList = courseService.selectCourseEnrollList(params);
		// 모델에 강좌 목록 추가
		model.addAttribute("courseList", courseList);

		model.addAttribute("pageName", "courseEnroll");
		return "courseEnrolls";
	}

	@PostMapping("/courseEnroll.do")
	@ResponseBody
	public Map<String, Object> enrollCourse(@RequestParam("courseId") int courseId) {
		Logger.debug("-----------------강좌 등록 로직-------------------");
		Map<String, Object> response = new HashMap<>();
		UserVO user = userService.getCurrentUser();

		try {
			int enrolledCoursesCount = courseService.getEnrolledCoursesCountById(user.getId());

			if (enrolledCoursesCount >= 6) {
				response.put("success", false);
				response.put("message", "최대 6개의 강좌만 등록할 수 있습니다.");
				return response;
			}
			CourseVO course = courseService.selectCourseById(courseId);

			if (course.getMax_students() <= courseService.enrollmentCountByCourseId(courseId)) {
				response.put("success", false);
				response.put("message", "등록 가능 인원이 모두 찬 강좌입니다.");
				return response;
			}

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

	@PostMapping("/checkExamInCourse.do")
	@ResponseBody
	public Map<String, Object> checkExamInCourse(@RequestParam("courseId") int courseId) {
		Map<String, Object> response = new HashMap<>();
		boolean examExists = courseService.isExamRegisteredForCourse(courseId); // 시험 등록 여부 확인 메서드 호출
		response.put("examExists", examExists);
		return response;
	}

	@RequestMapping("/courseEnrollEdit.do")
	public String courseEnrollEdit(Model model) {

		UserVO user = userService.getCurrentUser();
		List<CourseVO> courseList = courseService.selectCourseEnrollEditList(user.getId());
		model.addAttribute("courseList", courseList);
		model.addAttribute("pageName", "courseEnrollEdit");

		return "courseEnrollEdit";
	}

	@RequestMapping("/courseEditList.do")
	public String courseEditList(Model model, @RequestParam(value = "search", required = false) String Search) {
		UserVO user = userService.getCurrentUser();

		Map<String, Object> params = new HashMap<>();
		params.put("userId", user.getId());
		params.put("search", Search);

		// 강좌 목록을 가져온다
		List<CourseVO> courseList = courseService.selectEditCourseList(params);
		// 모델에 강좌 목록 추가
		model.addAttribute("courseList", courseList);

		model.addAttribute("pageName", "courseEdit");
		return "courseEditList";
	}

	@RequestMapping("/courseEdit.do")
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
		course.setMax_students(newCourse.getMax_students());

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

		model.addAttribute("course", courseVO);
		return "testCreatePage";
	}

	@PostMapping("/testCreate.do")
	public String testCreate(HttpServletRequest request) {

		UserVO user = userService.getCurrentUser();

		String name = request.getParameter("name");
		String description = request.getParameter("description");
		int time_limit = Integer.parseInt(request.getParameter("time_limit"));
		String startTimeString = request.getParameter("start_time");
		String endTimeString = request.getParameter("end_time");
		int courseId = Integer.parseInt(request.getParameter("course_id"));

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
		LocalDateTime startDateTime = LocalDateTime.parse(startTimeString, formatter);
		LocalDateTime endDateTime = LocalDateTime.parse(endTimeString, formatter);

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

	@DeleteMapping("/courseDelete.do")
	public ResponseEntity<Void> deleteCourse(@RequestParam("id") int courseId) {
		try {
			courseService.deleteCourse(courseId);
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

	@DeleteMapping("/CancelEnrollment.do")
	public ResponseEntity<Void> CancelEnrollment(@RequestParam("id") int courseId) {
		try {
			UserVO user = userService.getCurrentUser();
			Map<String, Object> params = new HashMap<>();
			params.put("courseId", courseId);
			params.put("userId", user.getId());
			courseService.CancelEnrollment(params);

			return ResponseEntity.ok().build();
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

	@PostMapping("/changeTestTime.do")
	@ResponseBody
	public ResponseEntity<String> changeTestTime(@RequestBody Map<String, Object> requestData) {
		Logger.debug("------------- 시간 변경");
		try {
			int test_id = Integer.parseInt(requestData.get("test_id").toString());
			String startTimeString = requestData.get("start_time").toString();
			String endTimeString = requestData.get("end_time").toString();
			int time_limit = Integer.parseInt(requestData.get("time_limit").toString());

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
			LocalDateTime startDateTime = LocalDateTime.parse(startTimeString, formatter);
			LocalDateTime endDateTime = LocalDateTime.parse(endTimeString, formatter);

			Timestamp start_time = Timestamp.valueOf(startDateTime);
			Timestamp end_time = Timestamp.valueOf(endDateTime);

			TestVO test = new TestVO();
			test.setId(test_id);
			test.setStart_time(start_time);
			test.setEnd_time(end_time);
			test.setTime_limit(time_limit);

			courseService.updateTestTime(test);

			return ResponseEntity.ok("시험 설정 변경 성공");
		} catch (Exception e) {

		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
	}

	@PostMapping("/testComplete.do")
	@ResponseBody
	@Transactional
	public ResponseEntity<String> completeTest(@RequestParam("testId") int testId) {
		try {
			Logger.debug("-----------------시험 완료 로직-------------------");

			TestVO test = courseService.selectTestById(testId);
			CourseVO course = courseService.selectCourseById(test.getCourse_id());
			Timestamp currentTime = new Timestamp(System.currentTimeMillis());
			Timestamp end_time = test.getEnd_time();

			if (currentTime.after(end_time)) {
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("{\"message\":\"시험 완료일이 현재 시간 이전입니다.\"}");
			}

			String messageText = course.getTitle() + " 강좌에서 새로운 시험이 공개되었습니다: " + test.getName();
			notificationService.sendNotificationByTestId(testId, messageText);

			courseService.completeTest(testId);
			return ResponseEntity.ok("시험 완료 처리 성공");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}

	}

	@DeleteMapping("/notifications")
	public ResponseEntity<Void> deleteNotification(@RequestParam int id, @RequestParam String message) {
		UserVO user = userService.getCurrentUser();
		Map<String, Object> params = new HashMap<>();
		params.put("courseId", id);
		params.put("userId", user.getId());
		params.put("message", message);

		notificationService.deleteNotification(params);
		return ResponseEntity.noContent().build();
	}

	@DeleteMapping("/DM.do")
	public ResponseEntity<Void> deleteDirectMessage(@RequestParam int id) {

		notificationService.deleteDirectMessage(id);//삭제할거 넣어주면 된다

		return ResponseEntity.noContent().build();
	}

	@RequestMapping(value = "/notifications")
	public ResponseEntity<List<NotificationVO>> notificationList() {
		UserVO user = userService.getCurrentUser();

		List<NotificationVO> notifications = notificationService.selectNotificationByUserId(user.getId());
		return ResponseEntity.ok(notifications);
	}

	@RequestMapping(value = "/DMs.do")
	public ResponseEntity<List<ChatMessage>> DirectMessageList() {
		UserVO user = userService.getCurrentUser();

		List<ChatMessage> DMs = notificationService.selectDirectMessageByUserId(user.getId());
		return ResponseEntity.ok(DMs);
	}

	@DeleteMapping(value = "/allNotifications")
	public ResponseEntity<Void> deleteAllNotifications() {
		UserVO user = userService.getCurrentUser();

		notificationService.deleteAllNotifications(user.getId());
		return ResponseEntity.ok().build();
	}

	@DeleteMapping(value = "/allDMs")
	public ResponseEntity<Void> deleteDMs() {
		UserVO user = userService.getCurrentUser();

		notificationService.deleteAllDirectMessage(user.getId());
		return ResponseEntity.ok().build();
	}

	@RequestMapping("/chat.do")
	public String courseChat(@RequestParam("id") int id, @RequestParam(value = "messageId", required = false) Integer messageId, Model model) {
		UserVO user = userService.getCurrentUser();
		Map<String, Object> params = new HashMap<>();
		params.put("courseId", id);
		params.put("userId", user.getId());

		List<?> list = courseService.selectMessageByCourseIdAndUserId(params);
		model.addAttribute("chatMessages", list);

		CourseVO course = courseService.selectCourseById(id);
		model.addAttribute("course", course);

		list = courseService.selectUsersByCourseId(id);
		model.addAttribute("users", list);

		model.addAttribute("userId", user.getId());

		if (messageId != null) {
			model.addAttribute("messageId", messageId);
		}

		return "courseChat";
	}

	@PostMapping("/sendChat.do")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> sendChat(@RequestBody messageVO message) {
		Map<String, Object> response = new HashMap<>();
		try {
			UserVO user = userService.getCurrentUser();

			message.setUser_id(user.getId());
			Timestamp currentTime = new Timestamp(System.currentTimeMillis());
			message.setCreated_at(currentTime);
			// 메시지를 데이터베이스에 저장
			courseService.insertMessage(message);
			ChatMessage chatMessage = new ChatMessage();
			chatMessage.setContent(message.getMessage());
			chatMessage.setSender(user.getName());
			chatMessage.setCreated_at(message.getCreated_at());
			chatMessage.setSender_id(user.getId());
			chatMessage.setSender_image(user.getImage_path());
			chatMessage.setMessage_id(message.getId());
			chatMessage.setCourse_id(message.getCourse_id());

			if (message.getRecipient_id() != null) {
				UserVO recipientUser = userService.selectUserById(message.getRecipient_id());
				chatMessage.setRecipient_id(recipientUser.getId());
				chatMessage.setRecipient_name(recipientUser.getName());
				notificationService.sendDirectMessage(chatMessage);
			}

			notificationService.sendChatting(message.getCourse_id(), chatMessage);

			// 응답 데이터 설정
			response.put("message", message.getMessage());
			response.put("status", "success");

			return ResponseEntity.ok(response);
		} catch (Exception e) {
			response.put("error", "메시지 전송 중 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}

	@RequestMapping("/testVideo.do")
	public String testVideoPage(@RequestParam("id") int courseId, Model model) {
		CourseVO course = courseService.selectCourseById(courseId);
		model.addAttribute("course", course);

		// 비디오 파일 리스트를 가져올 디렉토리 경로
		String directoryPath = "C:\\videoupload\\" + courseId;
		File directory = new File(directoryPath);

		// 디렉토리 내 .webm 파일 리스트 생성
		List<Map<String, Object>> videoFiles = new ArrayList<>();
		if (directory.exists() && directory.isDirectory()) {
			File[] files = directory.listFiles((dir, name) -> name.endsWith(".webm"));
			if (files != null) {
				Arrays.sort(files, Comparator.comparingLong(File::lastModified).reversed());

				Pattern pattern = Pattern.compile("_(\\d+)_(\\d+)");
				for (File file : files) {
					try {
						// 파일 이름 가져오기
						String filename = file.getName();
						Matcher matcher = pattern.matcher(filename);

						// 패턴 일치 여부 확인
						if (matcher.find()) {
							int userId = Integer.parseInt(matcher.group(1));
							int testId = Integer.parseInt(matcher.group(2));

							// 데이터 처리
							Map<String, Object> item1 = new HashMap<>();
							UserVO test_user = userService.selectUserById(userId);
							TestVO test = courseService.selectTestById(testId);
							item1.put("user_id", userId);
							item1.put("test_id", testId);
							item1.put("user_name", test_user.getName());
							item1.put("test_name", test.getName());
							item1.put("last_modified", file.lastModified());
							videoFiles.add(item1);
						}
					} catch (Exception e) {
						// 처리 불가능한 파일에 대한 로그 기록 또는 사용자 알림
						System.err.println("파일 처리 중 문제가 발생했습니다: " + file.getName() + " - " + e.getMessage());
					}
				}

			}
		}

		// 모델에 비디오 파일 리스트 추가
		model.addAttribute("videoFiles", videoFiles);

		return "testVideoList";
	}

	@RequestMapping("/viewTestVideo.do")
	public String viewTestVideo(@RequestParam("courseId") int courseId, @RequestParam("userId") int userId, @RequestParam("testId") int testId, Model model) {

		String directoryPath = "C:\\videoupload\\" + courseId + "\\";
		String filePath = directoryPath + "video_" + userId + "_" + testId + ".webm";

		File videoFile = new File(filePath);

		if (!videoFile.exists()) {
			throw new CustomException("비디오파일에 문제가 생겼습니다.");
		} else {
			String videoUrl = "/video/" + courseId + "/" + userId + "/" + testId;
			model.addAttribute("videoUrl", videoUrl);

			long lastModifiedTime = videoFile.lastModified();

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String formattedDate = sdf.format(new Date(lastModifiedTime));

			model.addAttribute("lastModified", formattedDate);  // 포맷된 날짜를 모델에 추가
		}

		TestVO test = courseService.selectTestById(testId);
		UserVO user = userService.selectUserById(userId);
		model.addAttribute("test", test);
		model.addAttribute("user", user);
		model.addAttribute("courseId", courseId);

		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("testId", testId);
		ExamParticipationVO examParticipation = questionService.selectExamParticipation(params);

		// pause_positions_json을 List<String>으로 변환
		examParticipation.parsePausePositions();

		model.addAttribute("examParticipation", examParticipation);

		return "viewTestVideo";
	}

	@RequestMapping("/courseDetail.do")
	public String courseDetailPage(@RequestParam("courseId") int courseId, Model model) {
		CourseDetailDTO courseDetail = courseService.selectCourseDetailById(courseId);
		model.addAttribute("courseDetail", courseDetail);
		List<TestVO> testList = courseService.selectTestInCourse(courseId);
		model.addAttribute("testList", testList);
		System.out.println("------------");
		return "courseDetail";
	}

}
