package egovframework.kss.main.controller;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.kss.main.dto.UserLoginDTO;
import egovframework.kss.main.dto.UserRegisterDTO;
import egovframework.kss.main.service.UserService;
import egovframework.kss.main.vo.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	private static Logger Logger = LoggerFactory.getLogger(UserController.class);

	@Resource(name = "UserService")
	UserService userService;

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
		System.out.println("user.... login...");

		return "login";
	}

	@PostMapping("login.do")
	@ResponseBody
	public Map<String, Object> login(@ModelAttribute UserLoginDTO userLoginDTO, HttpServletRequest httpServletRequest) {

		Map<String, Object> response = new HashMap<>();

		System.out.println("userId: " + userLoginDTO.getUser_id() + ", password: " + userLoginDTO.getPassword());

		// 사용자 인증 로직
		boolean isAuthenticated = userService.authenticate(userLoginDTO);

		UserVO userVO = userService.selectUserLogin(userLoginDTO);

		if (userVO != null) {
			response.put("success", true);
			// 로그인 성공 시 추가 작업: 세션 저장이나 스프링 시큐리티 같은거 작업 더 해야됨.
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
}
