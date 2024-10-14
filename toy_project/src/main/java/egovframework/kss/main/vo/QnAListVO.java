package egovframework.kss.main.vo;

import java.sql.Timestamp;

public class QnAListVO {

	private int id;
	private String title;
	private String writer;
	private String division;        // 구분
	private boolean checked;
	private Timestamp testDate;
	private boolean has_password;
	
	public QnAListVO() {
		
	}
	
	/**
	 * @id@ getter
	 * @return	id
	 */
	public int getId() {
		return id;
	}
	/**
	 * @id@ setter
	 * @param	id
	 */
	public void setId(int id) {
		this.id = id;
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
	public boolean isChecked() {
		return checked;
	}
	/**
	 * @checked@ setter
	 * @param	checked
	 */
	public void setChecked(boolean checked) {
		this.checked = checked;
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
	
	

}
