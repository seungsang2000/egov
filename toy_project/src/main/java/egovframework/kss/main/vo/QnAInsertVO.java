package egovframework.kss.main.vo;

import java.sql.Timestamp;

public class QnAInsertVO {
	private int id;
	private int division_id;        // 구분
	private String title;
	private Timestamp testDate;     // 날짜 및 시간
	private int view;               // 조회수
	private String writer;         // 담당자 이름
	private String email;           // 이메일 주소
	private String phone;           // 전화번호
	private String content;         // 공지 내용
	private String password;
	private int checked_id;

	/**
	 * @division_id@ getter
	 * @return	division_id
	 */
	public int getDivision_id() {
		return division_id;
	}

	/**
	 * @division_id@ setter
	 * @param	division_id
	 */
	public void setDivision_id(int division_id) {
		this.division_id = division_id;
	}

	/**
	 * @title@ getter
	 * @return	title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * @title@ setter
	 * @param	title
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * @testDate@ getter
	 * @return	testDate
	 */
	public Timestamp getTestDate() {
		return testDate;
	}

	/**
	 * @testDate@ setter
	 * @param	testDate
	 */
	public void setTestDate(Timestamp testDate) {
		this.testDate = testDate;
	}

	/**
	 * @view@ getter
	 * @return	view
	 */
	public int getView() {
		return view;
	}

	/**
	 * @view@ setter
	 * @param	view
	 */
	public void setView(int view) {
		this.view = view;
	}

	/**
	 * @writer@ getter
	 * @return	writer
	 */
	public String getWriter() {
		return writer;
	}

	/**
	 * @writer@ setter
	 * @param	writer
	 */
	public void setWriter(String writer) {
		this.writer = writer;
	}

	/**
	 * @email@ getter
	 * @return	email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @email@ setter
	 * @param	email
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * @phone@ getter
	 * @return	phone
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * @phone@ setter
	 * @param	phone
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * @content@ getter
	 * @return	content
	 */
	public String getContent() {
		return content;
	}

	/**
	 * @content@ setter
	 * @param	content
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * @password@ getter
	 * @return	password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * @password@ setter
	 * @param	password
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	public QnAInsertVO() {

	}

	public int getChecked_id() {
		return checked_id;
	}

	public void setChecked_id(int checked_id) {
		this.checked_id = checked_id;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

}
