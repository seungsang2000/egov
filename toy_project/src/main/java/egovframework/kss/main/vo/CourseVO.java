package egovframework.kss.main.vo;

import java.sql.Timestamp;

public class CourseVO {
	private int id;
	private String instructor;
	private String title;
	private String description;
	private String status;
	private int instructor_id;
	private Timestamp created_at;

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
	 * @instructor@ getter
	 * @return	instructor
	 */
	public String getInstructor() {
		return instructor;
	}

	/**
	 * @instructor@ setter
	 * @param	instructor
	 */
	public void setInstructor(String instructor) {
		this.instructor = instructor;
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
	 * @description@ getter
	 * @return	description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @description@ setter
	 * @param	description
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	public CourseVO() {

	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getInstructor_id() {
		return instructor_id;
	}

	public void setInstructor_id(int instructor_id) {
		this.instructor_id = instructor_id;
	}

	public Timestamp getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}

}
