package egovframework.kss.main.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.kss.main.dto.PasswordKeyDTO;
import egovframework.kss.main.dto.UserLoginDTO;
import egovframework.kss.main.dto.UserRegisterDTO;
import egovframework.kss.main.vo.UserVO;

public interface UserService {

	boolean checkExistUserID(String userId);

	void userRegister(UserRegisterDTO userRegisterDTO);

	boolean authenticate(UserLoginDTO userLoginDTO);

	UserVO selectUserLogin(UserLoginDTO userLoginDTO);

	void insertPasswordKey(PasswordKeyDTO passwordKeyDTO);

	boolean checkExistUserEmail(String email);

	PasswordKeyDTO getPasswordKeyByKeyAndEmail(Map<String, Object> params);

	void deletePasswordKeyByEmail(String email);

	void deletePasswordKeyByKeyAndEmail(Map<String, Object> params);

	UserVO selectUserByEmail(String email);

	Map<String, Object> sendMail(String email);

	String checkPage(HttpServletRequest request);

	void updatePassword(UserVO user, String newPassword);

	boolean checkExistUserEmailForUpdate(Map<String, Object> params);

	void updateUser(UserVO user);

	public UserVO selectUserByUserId(String username);

	UserVO getCurrentUser();

	void updateAuthentication(UserVO updatedUser);

	UserVO selectUserById(int id);
}
