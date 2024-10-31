package egovframework.kss.main.service;

import java.util.List;
import java.util.Map;

import egovframework.kss.main.dto.AnswerDTO;
import egovframework.kss.main.dto.QuestionDetailDTO;
import egovframework.kss.main.dto.QuestionListDTO;
import egovframework.kss.main.model.Option;
import egovframework.kss.main.model.Question;
import egovframework.kss.main.vo.ExamParticipationVO;

public interface QuestionService {

	public void insertSubjectiveQuestion(Question question);

	public void insertDescriptiveQuestion(Question question);

	public void insertMultipleChoiceQuestion(Question question, List<Option> options);

	List<QuestionListDTO> selectQuestionListsByTestId(int testId);

	List<QuestionListDTO> selectSloveQuestionListsByTestId(Map<String, Object> params);

	List<QuestionListDTO> selectReviewQuestionListsByTestId(Map<String, Object> params);

	public QuestionDetailDTO selectQuestionById(int questionId);

	public int getTotalScoreByTestId(int testId);

	public void deleteQuestion(int questionId);

	public void updateSubjectiveQuestion(Question question);

	public void updateDescriptiveQuestion(Question question);

	public void updateMultipleChoiceQuestion(Question question, List<Option> options);

	public void deleteOptionByQuestionId(int questionId);

	public QuestionDetailDTO selectNextQuestionById(int currentQuestionId);

	public void insertUserAnswer(AnswerDTO answer);

	public void updateUserAnswer(AnswerDTO answer);

	public boolean checkUserAnswerExists(AnswerDTO answer);

	public String selectUserAnswer(Map<String, Object> params);

	public boolean checkExamParticipationExists(Map<String, Object> params);

	public void insertExamParticipation(Map<String, Object> params);

	public ExamParticipationVO selectExamParticipation(Map<String, Object> params);

	public void updateExamParticipation(ExamParticipationVO examParticipation);

	public void testGrading(int testId);
}
