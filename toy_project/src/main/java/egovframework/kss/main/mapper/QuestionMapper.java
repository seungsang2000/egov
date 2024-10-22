package egovframework.kss.main.mapper;

import java.util.List;

import egovframework.kss.main.dto.QuestionDetailDTO;
import egovframework.kss.main.dto.QuestionListDTO;
import egovframework.kss.main.model.Option;
import egovframework.kss.main.model.Question;

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

}
