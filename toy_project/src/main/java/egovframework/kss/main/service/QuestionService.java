package egovframework.kss.main.service;

import java.util.List;

import egovframework.kss.main.dto.QuestionDetailDTO;
import egovframework.kss.main.dto.QuestionListDTO;
import egovframework.kss.main.model.Option;
import egovframework.kss.main.model.Question;

public interface QuestionService {

	public void insertSubjectiveQuestion(Question question);

	public void insertDescriptiveQuestion(Question question);

	public void insertMultipleChoiceQuestion(Question question, List<Option> options);

	List<QuestionListDTO> selectQuestionListsByTestId(int testId);

	public QuestionDetailDTO selectQuestionById(int questionId);

	public int getTotalScoreByTestId(int testId);

	public void deleteQuestion(int questionId);

	public void updateSubjectiveQuestion(Question question);

	public void updateDescriptiveQuestion(Question question);

	public void updateMultipleChoiceQuestion(Question question, List<Option> options);

	public void deleteOptionByQuestionId(int questionId);

}
