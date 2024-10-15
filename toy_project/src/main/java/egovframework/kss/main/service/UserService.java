package egovframework.kss.main.service;

import egovframework.kss.main.dto.UserLoginDTO;
import egovframework.kss.main.dto.UserRegisterDTO;
import egovframework.kss.main.vo.UserVO;

public interface UserService {

	boolean checkExistUserID(String userId);

	void userRegister(UserRegisterDTO userRegisterDTO);

	boolean authenticate(UserLoginDTO userLoginDTO);

	UserVO selectUserLogin(UserLoginDTO userLoginDTO);

}
