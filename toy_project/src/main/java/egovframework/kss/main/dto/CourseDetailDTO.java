package egovframework.kss.main.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class CourseDetailDTO {
	private int id;
	private String instructor;
	private String title;
	private String description;
	private String status;
	private int instructor_id;
	private Timestamp created_at;
	private boolean enrolled = false;
	private int studentCount;
	private String course_image_path;
	private String user_image_path;
	private int max_students;
}
