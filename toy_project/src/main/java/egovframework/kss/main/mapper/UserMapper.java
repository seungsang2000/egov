package egovframework.kss.main.mapper;

import java.util.Map;

import egovframework.kss.main.dto.PasswordKeyDTO;
import egovframework.kss.main.dto.UserLoginDTO;
import egovframework.kss.main.dto.UserRegisterDTO;
import egovframework.kss.main.vo.UserVO;

public interface UserMapper {

	boolean checkExistUserID(String userId);

	boolean checkExistUserEmail(String email);

	UserVO selectUserByEmail(String email);

	void userRegister(UserRegisterDTO userRegisterDTO);

	boolean authenticate(UserLoginDTO userLoginDTO);

	UserVO selectUserLogin(UserLoginDTO userLoginDTO);

	void insertPasswordKey(PasswordKeyDTO passwordKeyDTO);

	PasswordKeyDTO getPasswordKeyByKeyAndEmail(Map<String, Object> params);

	void updatePassword(UserVO user);

	boolean checkExistUserEmailForUpdate(Map<String, Object> params);

	void updateUser(UserVO user);

}
