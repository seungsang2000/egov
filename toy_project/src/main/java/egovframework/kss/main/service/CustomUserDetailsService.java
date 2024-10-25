package egovframework.kss.main.service;

import javax.annotation.Resource;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import egovframework.kss.main.dao.UserDAO;
import egovframework.kss.main.model.CustomUserDetails;
import egovframework.kss.main.vo.UserVO;

@Service
public class CustomUserDetailsService implements UserDetailsService {

	@Resource(name = "UserDAO")
	private UserDAO userDAO;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserVO userVO = userDAO.selectUserByUserId(username); // DB에서 사용자 정보 조회
		if (userVO == null) {
			throw new UsernameNotFoundException("User not found");
		}

		// UserDetails 객체 생성 및 반환
		return new CustomUserDetails(userVO.getUser_id(), userVO.getPassword(), userVO.getRole(), userVO.getName(), userVO.getImage_path());
	}
}
