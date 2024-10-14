package egovframework.kss.main.vo;

public class QnACommentVO {

	private int id;
	private String c_content;
	private int post_id;

	/**
	 * @post_id@ getter
	 * @return	post_id
	 */
	public int getPost_id() {
		return post_id;
	}

	/**
	 * @post_id@ setter
	 * @param	post_id
	 */
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}

	public String getC_content() {
		return c_content;
	}

	public void setC_content(String c_content) {
		this.c_content = c_content;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

}
