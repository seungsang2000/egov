package egovframework.kss.main.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class CourseVO {
	private int id;
	private String instructor;
	private String title;
	private String description;
	private String status;
	private int instructor_id;
	private Timestamp created_at;
	private boolean enrolled = false;
	private int studentCount;
	private String image_path;
}
