package egovframework.kss.main.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Option {
	private int question_id;
	private int option_number;
	private String option_text;

	public Option(int optionNumber, String optionText) {
		this.option_number = optionNumber;
		this.option_text = optionText;
	}
}
