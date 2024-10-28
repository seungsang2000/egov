package egovframework.kss.main.dto;

import java.util.List;

import egovframework.kss.main.model.Option;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class QuestionDetailWithUserAnswerDTO {
	private int id;
	private String question_text;
	private String question_type;
	private List<Option> options;
	private String userAnswer;
	private int score;

}
