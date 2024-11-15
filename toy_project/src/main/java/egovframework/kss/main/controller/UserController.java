package egovframework.kss.main.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.RememberMeServices;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.kss.main.dto.PasswordKeyDTO;
import egovframework.kss.main.dto.UserRegisterDTO;
import egovframework.kss.main.exception.CustomException;
import egovframework.kss.main.service.CourseService;
import egovframework.kss.main.service.UserService;
import egovframework.kss.main.vo.CourseVO;
import egovframework.kss.main.vo.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	private static Logger Logger = LoggerFactory.getLogger(UserController.class);

	@Resource(name = "UserService")
	UserService userService;

	@Resource(name = "CourseService")
	private CourseService courseService;

	@Autowired
	@Qualifier("authenticationManager") // 명시적으로 빈 이름을 지정
	private AuthenticationManager authenticationManager;

	@Autowired
	private RememberMeServices rememberMeServices;

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

	@RequestMapping(value = "register.do")
	public String userRegisterPage(Model model) {

		return "user/register";
	}

	@PostMapping("register.do")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> userRegister(@RequestBody UserRegisterDTO userRegisterDTO) {
		Map<String, Object> response = new HashMap<>();

		try {
			System.out.println("register......");
			userService.userRegister(userRegisterDTO);

			response.put("success", true);
			response.put("message", "회원가입이 완료되었습니다.");
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "회원가입 실패: " + e.getMessage());
		}

		return ResponseEntity.ok(response);
	}

	@RequestMapping(value = "login.do")
	public String userLoginPage(Model model) {

		return "user/login";
	}

	@PostMapping("login.do")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> login(@RequestParam("user_id") String userId, @RequestParam("password") String password, @RequestParam(value = "remember-me", required = false) boolean rememberMe, // Remember Me 파라미터 추가
			HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {

		Map<String, Object> response = new HashMap<>();

		try {
			// 사용자 인증 시도
			Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(userId, password));

			// 인증 성공 시
			SecurityContextHolder.getContext().setAuthentication(authentication);

			/*			HttpSession session = httpServletRequest.getSession(true);
						CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
						UserVO user = userService.selectUserByUserId(customUserDetails.getUsername());
			
						user.setPassword(null); // 비밀번호 세션에 저장안되게
						session.setAttribute("loggedInUser", user); // 사용자의 세부 정보 저장
			*/

			if (rememberMe) {
				rememberMeServices.loginSuccess(httpServletRequest, httpServletResponse, authentication);
			}

			response.put("success", true);
		} catch (AuthenticationException e) {
			// 인증 실패
			response.put("success", false);
		}

		return ResponseEntity.ok(response);
	}

	@RequestMapping(value = "checkId.do")
	@ResponseBody
	public Map<String, Object> checkExistUserID(@RequestParam String userId) {
		boolean exists = userService.checkExistUserID(userId);
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("exists", exists);
		return response;
	}

	@RequestMapping(value = "checkEmail.do")
	@ResponseBody
	public Map<String, Object> checkExistUserEmail(@RequestParam String email) {
		boolean exists = userService.checkExistUserEmail(email);
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("exists", exists);
		return response;
	}

	/*	@PostMapping("logout.do")
		@ResponseBody
		public Map<String, Object> logout(HttpServletRequest httpServletRequest) {
			Map<String, Object> response = new HashMap<>();
	
			HttpSession session = httpServletRequest.getSession(false);
			if (session != null) {
				session.invalidate(); // 세션 무효화
			}
	
			response.put("success", true);
			return response;
		}*/

	@RequestMapping(value = "forgotPassword.do")
	public String forgotPasswordPage() {

		return "user/forgotPassword";
	}

	@PostMapping("emailCheck.do")
	@ResponseBody
	public Map<String, Object> mailSending(@RequestParam String email, HttpServletRequest request) {
		System.out.println("mailSending");

		return userService.sendMail(email);

	}

	@PostMapping("verifyAuthKey.do")
	@ResponseBody
	public Map<String, Object> verifyAuthKey(@RequestParam String inputKey, @RequestParam String email, HttpServletRequest request) {
		Map<String, Object> response = new HashMap<>();
		HttpSession session = request.getSession();

		Map<String, Object> params = new HashMap<>();
		params.put("email", email);
		params.put("key", inputKey);

		PasswordKeyDTO passwordKeyDTO = userService.getPasswordKeyByKeyAndEmail(params);

		if (passwordKeyDTO != null) {
			// 인증 키가 존재하는 경우
			Timestamp createdAt = passwordKeyDTO.getCreated_at();
			long currentTime = System.currentTimeMillis();
			long keyCreationTime = createdAt.getTime();

			if (currentTime - keyCreationTime <= 3600000) {
				// 키가 유효한 경우
				response.put("success", true);
				response.put("message", "인증이 완료되었습니다.");
				session.setAttribute("authKey", inputKey);
				session.setAttribute("email", email);
			} else {
				// 키가 만료된 경우
				response.put("success", false);
				response.put("message", "인증키가 만료되었습니다.");
			}
		} else {
			// 인증 키가 존재하지 않는 경우
			response.put("success", false);
			response.put("message", "인증키가 잘못되었습니다.");
		}

		return response;
	}

	@RequestMapping(value = "resetPassword.do")
	public String resetPasswordPage(HttpServletRequest request) {

		HttpSession session = request.getSession();
		String sessionKey = (String) session.getAttribute("authKey");
		String sessionEmail = (String) session.getAttribute("email");
		if (sessionKey == null || sessionEmail == null) {
			throw new CustomException("세션에 문제가 발생했습니다. 다시 시도해 주세요");
		} else {
			Map<String, Object> params = new HashMap<>();
			params.put("email", sessionEmail);
			params.put("key", sessionKey);
			PasswordKeyDTO passwordKeyDTO = userService.getPasswordKeyByKeyAndEmail(params);
			if (passwordKeyDTO != null) {
				// 인증 키가 존재하는 경우
				Timestamp createdAt = passwordKeyDTO.getCreated_at();
				long currentTime = System.currentTimeMillis();
				long keyCreationTime = createdAt.getTime();

				// 인증 키가 생성된 시각과 현재 시각 차이 계산 (1시간 = 3600000ms)
				if (currentTime - keyCreationTime <= 3600000) {
					// 키가 유효한 경우

				} else {
					throw new CustomException("인증키가 만료되었습니다. 다시 시도해 주세요");
				}
			} else {
				throw new CustomException("인증키가 잘못되었습니다. 다시 시도해 주세요");
			}
		}
		// 인증 키 세션에서 제거 (필요시)
		return "user/resetPassword"; // 비밀번호 변경 완료 페이지

	}

	@PostMapping("/resetPassword.do")
	@ResponseBody
	public Map<String, Object> resetPassword(@RequestParam String newPassword, HttpServletRequest request) {
		Map<String, Object> response = new HashMap<>();
		HttpSession session = request.getSession();
		String sessionKey = (String) session.getAttribute("authKey");
		String sessionEmail = (String) session.getAttribute("email");
		String errorMessage = null;
		Map<String, Object> params = new HashMap<>();
		params.put("email", sessionEmail);
		params.put("key", sessionKey);

		if (sessionKey == null || sessionEmail == null) {
			errorMessage = "접근이 제한된 페이지 입니다.";
		} else {

			PasswordKeyDTO passwordKeyDTO = userService.getPasswordKeyByKeyAndEmail(params);
			if (passwordKeyDTO != null) {
				// 인증 키가 존재하는 경우
				errorMessage = null;
				UserVO user = userService.selectUserByEmail(passwordKeyDTO.getEmail());
				userService.updatePassword(user, newPassword);
			} else {
				errorMessage = "인증키가 잘못되었습니다. 다시 시도해 주세요";
			}
		}

		if (errorMessage != null) {
			response.put("success", false);
			response.put("message", errorMessage);
		} else {
			response.put("success", true);
			response.put("message", "비밀번호가 변경되었습니다");
			userService.deletePasswordKeyByKeyAndEmail(params);
		}

		return response;
	}

	@RequestMapping(value = "/myPage.do")
	public String myPage(HttpServletRequest request, Model model) {

		UserVO user = userService.getCurrentUser();
		model.addAttribute("user", user);
		List<CourseVO> courseList = courseService.selectMyCourseList(user.getId());
		// 모델에 강좌 목록 추가
		model.addAttribute("list", courseList);
		model.addAttribute("pageName", "myPage");

		return "user/profile";
	}

	@PostMapping("/updateUserProfile.do")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> updateUserProfile(@RequestParam String name, @RequestParam String email, @RequestParam(required = false) MultipartFile uploadFile, HttpServletRequest request) {
		Map<String, Object> response = new HashMap<>();

		UserVO user = userService.getCurrentUser();

		Map<String, Object> param = new HashMap<>();
		param.put("email", email);
		param.put("id", user.getId());

		// 이메일 중복 검사
		if (userService.checkExistUserEmailForUpdate(param)) {

			response.put("success", false);
			response.put("message", "이미 사용 중인 이메일입니다.");
			return ResponseEntity.ok(response);
		}

		user.setName(name);
		user.setEmail(email);
		;

		if (uploadFile != null && !uploadFile.isEmpty()) {
			String imagePath = saveImage(uploadFile); // 이미지 저장
			user.setImage_path(imagePath); // CourseVO에 이미지 경로 설정
		}

		userService.updateUser(user);

		response.put("success", true);
		return ResponseEntity.ok(response);
	}

}
