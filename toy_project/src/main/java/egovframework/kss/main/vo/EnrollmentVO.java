package egovframework.kss.main.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class EnrollmentVO {
	private int user_id;
	private int course_id;
	private Timestamp enrolled_at;
	private String status;
}
