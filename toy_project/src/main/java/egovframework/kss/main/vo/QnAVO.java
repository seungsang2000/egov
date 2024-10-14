package egovframework.kss.main.vo;

import java.sql.Timestamp;

public class QnAVO {
	private int id;                 // 공지 ID (Primary Key)
	private String division;        // 구분
	private String title;
	private Timestamp testDate;     // 날짜 및 시간
	private int view;               // 조회수
	private String writer;         // 담당자 이름
	private String email;           // 이메일 주소
	private String phone;           // 전화번호
	private String content;         // 공지 내용
	private String checked;         //답변 달렸는지 여부
	private int type;
	private String password;
	private boolean has_password;

	/**
	 * @division@ getter
	 * @return	division
	 */
	public String getDivision() {
		return division;
	}

	/**
	 * @division@ setter
	 * @param	division
	 */
	public void setDivision(String division) {
		this.division = division;
	}

	/**
	 * @checked@ getter
	 * @return	checked
	 */
	public String getChecked() {
		return checked;
	}

	/**
	 * @checked@ setter
	 * @param	checked
	 */
	public void setChecked(String checked) {
		this.checked = checked;
	}

	/**
	 * @has_password@ getter
	 * @return	has_password
	 */
	public boolean isHas_password() {
		return has_password;
	}

	/**
	 * @has_password@ setter
	 * @param	has_password
	 */
	public void setHas_password(boolean has_password) {
		this.has_password = has_password;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public QnAVO() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Timestamp getTestDate() {
		return testDate;
	}

	public void setTestDate(Timestamp testDate) {
		this.testDate = testDate;
	}

	public int getView() {
		return view;
	}

	public void setView(int view) {
		this.view = view;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
