package egovframework.kss.main.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class CourseUserCountDTO {
	int course_id;
	private String course_name;
	int total_users;
}
