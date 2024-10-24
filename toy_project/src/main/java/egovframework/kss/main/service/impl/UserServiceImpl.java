package egovframework.kss.main.service.impl;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import egovframework.kss.main.dao.UserDAO;
import egovframework.kss.main.dto.PasswordKeyDTO;
import egovframework.kss.main.dto.UserLoginDTO;
import egovframework.kss.main.dto.UserRegisterDTO;
import egovframework.kss.main.exception.CustomException;
import egovframework.kss.main.mail.TempKey;
import egovframework.kss.main.model.CustomUserDetails;
import egovframework.kss.main.service.UserService;
import egovframework.kss.main.vo.UserVO;

@Service("UserService")
public class UserServiceImpl implements UserService {

	@Resource(name = "UserDAO")
	private UserDAO userDAO;

	private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

	@Autowired
	private JavaMailSender sender;

	@Override
	public boolean checkExistUserID(String userId) {

		return userDAO.checkExistUserID(userId);
	}

	@Override
	public void userRegister(UserRegisterDTO userRegisterDTO) {

		String hashedPassword = passwordEncoder.encode(userRegisterDTO.getPassword());
		userRegisterDTO.setPassword(hashedPassword); // 비밀번호 해싱

		userDAO.userRegister(userRegisterDTO);
	}

	@Override
	public boolean authenticate(UserLoginDTO userLoginDTO) {
		return userDAO.authenticate(userLoginDTO);
	}

	@Override
	public UserVO selectUserLogin(UserLoginDTO userLoginDTO) {

		UserVO user = userDAO.selectUserLogin(userLoginDTO);

		if (user != null) {
			if (passwordEncoder.matches(userLoginDTO.getPassword(), user.getPassword())) {
				user.setPassword(null);
				return user;
			}
		}
		return null;
	}

	@Override
	public void insertPasswordKey(PasswordKeyDTO passwordKeyDTO) {
		userDAO.insertPasswordKey(passwordKeyDTO);
	}

	@Override
	public boolean checkExistUserEmail(String email) {

		return userDAO.checkExistUserEmail(email);
	}

	@Override
	public PasswordKeyDTO getPasswordKeyByKeyAndEmail(Map<String, Object> params) {
		return userDAO.getPasswordKeyByKeyAndEmail(params);
	}

	@Override
	public UserVO selectUserByEmail(String email) {
		return userDAO.selectUserByEmail(email);
	}

	@Override
	public Map<String, Object> sendMail(String email) {
		Map<String, Object> response = new HashMap<>();

		UserVO user = selectUserByEmail(email);

		if (user == null) {
			response.put("success", false);
			response.put("message", "해당 이메일을 찾을 수 없습니다.");
			return response;
		}

		String setfrom = "rovin054@gmail.com";
		String key = new TempKey().getKey(20, false);

		String tomail = user.getEmail();     // 받는 사람 이메일
		String title = "TestHub 이메일 인증입니다.";
		String content = new StringBuilder().append(user.getName()).append("님! TestHub를 이용해주셔서 감사합니다.\n").append("사용자분의 id는 ").append(user.getUser_id()).append(" 입니다.\n").append("다음 인증키를 화면에 입력해주십시오.\n").append("인증키: ").append(key).toString();
		try {
			MimeMessage message = sender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom, "TestHub 운영진");  // 보내는사람 생략하거나 하면 정상작동을 안함 두번째 인자값은 보낼때의 이름이다.
			messageHelper.setTo(tomail);     // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content);  // 메일 내용

			sender.send(message);

			PasswordKeyDTO passwordKeyDTO = new PasswordKeyDTO();
			passwordKeyDTO.setCreated_at(Timestamp.from(Instant.now()));
			passwordKeyDTO.setEmail(tomail);
			passwordKeyDTO.setKey(key);

			insertPasswordKey(passwordKeyDTO);

			response.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			response.put("success", false);
			response.put("message", "이메일 발송에 실패했습니다.");
		}

		return response;
	}

	@Override
	public String checkPage(HttpServletRequest request) {
		return null;
	}

	@Override
	public void updatePassword(UserVO user, String newPassword) {
		String hashedPassword = passwordEncoder.encode(newPassword);
		user.setPassword(hashedPassword);
		userDAO.updatePassword(user);
	}

	@Override
	public boolean checkExistUserEmailForUpdate(Map<String, Object> params) {
		return userDAO.checkExistUserEmailForUpdate(params);
	}

	@Override
	public void updateUser(UserVO user) {
		userDAO.updateUser(user);

	}

	@Override
	public UserVO selectUserByUserId(String username) {
		return userDAO.selectUserByUserId(username);
	}

	@Override
	public UserVO getCurrentUser() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		Object principal = authentication.getPrincipal();

		try {
			CustomUserDetails currentUser = (CustomUserDetails) principal;
			UserVO user = selectUserByUserId(currentUser.getUsername());
			if (user == null) {
				throw new CustomException("로그인 후 다시 시도해주세요");
			}
			user.setPassword(null);
			return user;
		} catch (Exception e) {
			throw new CustomException("유저 정보에 이상이 생겼습니다");
		}
	}

}
