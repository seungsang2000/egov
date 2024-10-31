package egovframework.kss.main.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class QuestionListDTO {
	private int id;
	private int question_order;
	private Boolean is_answered;

}
