package egovframework.kss.main.dto;

public class PasswordCheckRequest {
	private int id; // int 타입
	private String password;

	// Getters and Setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public PasswordCheckRequest() {

	}
}
