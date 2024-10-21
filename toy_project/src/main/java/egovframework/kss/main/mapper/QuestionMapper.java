package egovframework.kss.main.mapper;

import egovframework.kss.main.model.Option;
import egovframework.kss.main.model.Question;

public interface QuestionMapper {
	void insertQuestion(Question question);

	void insertOption(Option option);

}
