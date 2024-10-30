package egovframework.kss.main.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class NotificationVO {
	private int id;
	private int user_id;
	private int course_id;
	private String message;
	private Timestamp create_at;
}
