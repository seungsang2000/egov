package egovframework.kss.main.service.impl;

import javax.annotation.Resource;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import egovframework.kss.main.dao.UserDAO;
import egovframework.kss.main.dto.UserLoginDTO;
import egovframework.kss.main.dto.UserRegisterDTO;
import egovframework.kss.main.service.UserService;
import egovframework.kss.main.vo.UserVO;

@Service("UserService")
public class UserServiceImpl implements UserService {

	@Resource(name = "UserDAO")
	private UserDAO userDAO;

	private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

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

}
