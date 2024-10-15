package egovframework.kss.main.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.kss.main.dto.UserLoginDTO;
import egovframework.kss.main.dto.UserRegisterDTO;
import egovframework.kss.main.mapper.UserMapper;
import egovframework.kss.main.vo.UserVO;

@Repository("UserDAO")
public class UserDAO {

	@Autowired
	SqlSession sqlSession;

	public boolean checkExistUserID(String userId) {
		UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
		return userMapper.checkExistUserID(userId);
	}

	public void userRegister(UserRegisterDTO userRegisterDTO) {
		UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
		userMapper.userRegister(userRegisterDTO);
	}

	public boolean authenticate(UserLoginDTO userLoginDTO) {
		UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
		return userMapper.authenticate(userLoginDTO);
	}

	public UserVO selectUserLogin(UserLoginDTO userLoginDTO) {
		UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
		return userMapper.selectUserLogin(userLoginDTO);
	}

}
