package egovframework.kss.main.vo;

import java.util.List;

import egovframework.kss.main.model.Option;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class QuestionVO {
	private int id;
	private int test_id;
	private String question_text;
	private String question_type;
	private String correct_answer;
	private int total_score;
	private List<Option> options;
}
