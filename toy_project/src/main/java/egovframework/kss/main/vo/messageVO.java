package egovframework.kss.main.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class messageVO {
	private int id;
	private int user_id;
	private int course_id;
	private String message;
	private Timestamp created_at;
	private Integer recipient_id;
}
