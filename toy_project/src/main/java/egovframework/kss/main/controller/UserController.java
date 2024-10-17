package egovframework.kss.main.controller;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.HashMap;
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

import egovframework.kss.main.dto.PasswordKeyDTO;
import egovframework.kss.main.dto.UserLoginDTO;
import egovframework.kss.main.dto.UserRegisterDTO;
import egovframework.kss.main.service.ErrorService;
import egovframework.kss.main.service.UserService;
import egovframework.kss.main.vo.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	private static Logger Logger = LoggerFactory.getLogger(UserController.class);

	@Resource(name = "UserService")
	UserService userService;

	@Resource(name = "ErrorService")
	ErrorService errorService;

	@RequestMapping(value = "register.do")
	public String userRegisterPage(Model model) {
		System.out.println("user.... register...");

		return "register";
	}

	@PostMapping("register.do")
	public String userRegister(UserRegisterDTO userRegisterDTO) {
		userRegisterDTO.setCreated_at(Timestamp.from(Instant.now()));
		userService.userRegister(userRegisterDTO);

		return "redirect:/user/login.do";

	}

	@RequestMapping(value = "login.do")
	public String userLoginPage(Model model) {

		return "login";
	}

	@PostMapping("login.do")
	@ResponseBody
	public Map<String, Object> login(@ModelAttribute UserLoginDTO userLoginDTO, HttpServletRequest httpServletRequest) {

		Map<String, Object> response = new HashMap<>();

		System.out.println("userId: " + userLoginDTO.getUser_id() + ", password: " + userLoginDTO.getPassword());

		// 사용자 인증 로직(현재 사용 X)
		//boolean isAuthenticated = userService.authenticate(userLoginDTO);

		UserVO userVO = userService.selectUserLogin(userLoginDTO);

		if (userVO != null) {
			response.put("success", true);
			HttpSession session = httpServletRequest.getSession(false);
			if (session != null) {
				session.invalidate(); // 기존 세션 무효화
			}
			session = httpServletRequest.getSession(true);
			session.setAttribute("loggedInUser", userVO); // 로그인 성공 시 추가 작업: 임시로 세션 해놓은 것. 후에 스프링 시큐리티로 대체 
		} else {
			response.put("success", false);
		}

		return response; // JSON 형태로 반환
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

	@PostMapping("logout.do")
	@ResponseBody
	public Map<String, Object> logout(HttpServletRequest httpServletRequest) {
		Map<String, Object> response = new HashMap<>();

		HttpSession session = httpServletRequest.getSession(false);
		if (session != null) {
			session.invalidate(); // 세션 무효화
		}

		response.put("success", true);
		return response;
	}

	@RequestMapping(value = "forgot-password.do")
	public String forgotPasswordPage() {
		System.out.println("user.... forgot...");

		return "forgotPassword";
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

		// 데이터베이스에서 인증 키 정보 조회
		PasswordKeyDTO passwordKeyDTO = userService.getPasswordKeyByKeyAndEmail(params);

		if (passwordKeyDTO != null) {
			// 인증 키가 존재하는 경우
			Timestamp createdAt = passwordKeyDTO.getCreated_at();
			long currentTime = System.currentTimeMillis();
			long keyCreationTime = createdAt.getTime();

			// 인증 키가 생성된 시각과 현재 시각 차이 계산 (1시간 = 3600000ms)
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

		return response; // JSON 형태로 반환
	}

	@RequestMapping(value = "resetPassword.do")
	public String resetPasswordPage(HttpServletRequest request) {

		HttpSession session = request.getSession();
		String sessionKey = (String) session.getAttribute("authKey");
		String sessionEmail = (String) session.getAttribute("email");
		String errorMessage = null;
		if (sessionKey == null || sessionEmail == null) {
			errorMessage = "접근이 제한된 페이지 입니다.";
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
					errorMessage = null;
				} else {
					errorMessage = "인증키가 만료되었습니다";
				}
			} else {
				errorMessage = "인증키가 잘못되었습니다. 다시 시도해 주세요";
			}
		}
		if (errorMessage != null) {
			return errorService.redirectErrorPage(errorMessage);
		} else {
			// 인증 키 세션에서 제거 (필요시)
			return "resetPassword"; // 비밀번호 변경 완료 페이지
		}

	}

	@PostMapping("resetPassword.do")
	@ResponseBody
	public Map<String, Object> resetPassword(@RequestParam String newPassword, HttpServletRequest request) {
		Map<String, Object> response = new HashMap<>();
		HttpSession session = request.getSession();
		String sessionKey = (String) session.getAttribute("authKey");
		String sessionEmail = (String) session.getAttribute("email");
		String errorMessage = null;
		if (sessionKey == null || sessionEmail == null) {
			errorMessage = "접근이 제한된 페이지 입니다.";
		} else {
			Map<String, Object> params = new HashMap<>();
			params.put("email", sessionEmail);
			params.put("key", sessionKey);
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
		}

		return response;
	}

}
