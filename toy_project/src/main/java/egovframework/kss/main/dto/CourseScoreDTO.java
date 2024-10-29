package egovframework.kss.main.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor

public class CourseScoreDTO {
	private String course_title;
	private int user_total_score;
	private double average_score;

}
