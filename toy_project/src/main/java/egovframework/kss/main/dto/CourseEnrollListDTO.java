package egovframework.kss.main.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class CourseEnrollListDTO {
	private int id;
	private String title;
	private String description;
	private String instructor;
	private Timestamp created_at;
	private String status;
	private boolean enrolled;
	private int studentCount;
}
