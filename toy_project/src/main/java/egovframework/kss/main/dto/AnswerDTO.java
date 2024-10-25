package egovframework.kss.main.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class AnswerDTO {
	private int user_id;
	private int test_id;
	private int question_id;
	private String answer;
}
