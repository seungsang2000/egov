package egovframework.kss.main.mapper;

import java.util.List;
import java.util.Map;

import egovframework.kss.main.dto.AnswerDTO;
import egovframework.kss.main.dto.QuestionDetailDTO;
import egovframework.kss.main.dto.QuestionListDTO;
import egovframework.kss.main.model.Option;
import egovframework.kss.main.model.Question;
import egovframework.kss.main.vo.ExamParticipationVO;

public interface QuestionMapper {
	void insertQuestion(Question question);

	void insertOption(Option option);

	List<QuestionListDTO> selectQuestionListsByTestId(int testId);

	// 질문 ID로 상세 정보 가져오기
	QuestionDetailDTO selectQuestionById(int questionId);

	// 질문 ID로 옵션 가져오기
	List<Option> getOptionsByQuestionId(int questionId);

	int getTotalScoreByTestId(int testId);

	void deleteQuestion(int questionId);

	void updateQuestion(Question question);

	void deleteOptionByQuestionId(int questionId);

	QuestionDetailDTO selectNextQuestionById(int currentQuestionId);

	void insertUserAnswer(AnswerDTO answer);

	void updateUserAnswer(AnswerDTO answer);

	boolean checkUserAnswerExists(AnswerDTO answer);

	String selectUserAnswer(Map<String, Object> params);

	boolean checkExamParticipationExists(Map<String, Object> params);

	void insertExamParticipation(Map<String, Object> params);

	ExamParticipationVO selectExamParticipation(Map<String, Object> params);

	void updateExamParticipation(ExamParticipationVO examParticipation);

	void testGrading(int testId);

	void assignZeroScoreToNonParticipants(int testId); //testGrading과 한 세트

	void updateIsScoredComplete(int testId); //testGrading과 한 세트

}
