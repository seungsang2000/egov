package egovframework.kss.main.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Option {
	private int questionId;
	private int optionNumber;
	private String optionText;

	public Option(int optionNumber, String optionText) {
		this.optionNumber = optionNumber;
		this.optionText = optionText;
	}
}
