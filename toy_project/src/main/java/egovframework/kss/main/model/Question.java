package egovframework.kss.main.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Question {
	private int id;
	private int testId;
	private String questionText;
	private String questionType;
	private int correctAnswer;
	private int score;
	private int questionOrder;
}
