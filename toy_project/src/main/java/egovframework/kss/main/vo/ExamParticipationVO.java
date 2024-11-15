package egovframework.kss.main.vo;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

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
	private String pause_positions_json;

	// pause_positions_json을 List<String>으로 변환할 필드
	private List<String> pause_positions;

	// pause_positions_json을 List<String>으로 변환
	public void parsePausePositions() {
		ObjectMapper objectMapper = new ObjectMapper();
		try {
			if (this.pause_positions_json != null) {
				this.pause_positions = objectMapper.readValue(this.pause_positions_json, new TypeReference<List<String>>() {});
			} else {
				this.pause_positions = new ArrayList<>(); // null일 때 빈 리스트로 초기화
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String getEndTimeAsISO() {
		// Timestamp를 Instant로 변환하고 ISO 8601 형식으로 변환
		return end_time.toInstant().atZone(ZoneId.of("UTC")).toString();
	}

}
