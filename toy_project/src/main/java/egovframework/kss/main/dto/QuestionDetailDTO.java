package egovframework.kss.main.dto;

import java.util.List;

import egovframework.kss.main.model.Option;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class QuestionDetailDTO {
	private int id;
	private String question_text;
	private String question_type;
	private String correct_answer;
	private List<Option> options;
	private int score;

}
