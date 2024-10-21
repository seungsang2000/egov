package egovframework.kss.main.service;

import java.util.List;

import egovframework.kss.main.model.Option;
import egovframework.kss.main.model.Question;

public interface QuestionService {

	public void insertSubjectiveQuestion(Question question);

	public void insertDescriptiveQuestion(Question question);

	public void insertMultipleChoiceQuestion(Question question, List<Option> options);

}
