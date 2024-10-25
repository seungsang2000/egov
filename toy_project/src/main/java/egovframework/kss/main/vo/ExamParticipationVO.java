package egovframework.kss.main.vo;

import java.sql.Timestamp;
import java.time.ZoneId;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ExamParticipationVO {

	private int user_id;
	private int test_id;
	private Timestamp start_time;
	private Timestamp end_time;
	private int score;
	private String status;

	public String getEndTimeAsISO() {
		// Timestamp를 Instant로 변환하고 ISO 8601 형식으로 변환
		return end_time.toInstant().atZone(ZoneId.of("UTC")).toString();
	}

}
