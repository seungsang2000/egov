package egovframework.kss.main.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ChatDTO {
	private int id;
	private int course_id;
	private String message;
	private Timestamp created_at;
	private Boolean is_me;
	private String user_name;
	private String user_image;
	private String recipient_name;
}
