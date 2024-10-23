package egovframework.kss.main.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TestVO {

	private int id;
	private int course_id;
	private String name;
	private String description;
	private Timestamp start_time;
	private Timestamp end_time;
	private int time_limit;
	private boolean shutdown;
	private String status;

}
