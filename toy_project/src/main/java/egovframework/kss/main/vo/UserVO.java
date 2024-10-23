package egovframework.kss.main.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserVO {
	private int id;
	private String user_id;
	private String role;
	private String email;
	private String name;
	private String password;
	private String image_path;

}
