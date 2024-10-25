package egovframework.kss.main.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.kss.main.dto.AnswerDTO;
import egovframework.kss.main.dto.QuestionDetailDTO;
import egovframework.kss.main.dto.QuestionListDTO;
import egovframework.kss.main.mapper.QuestionMapper;
import egovframework.kss.main.model.Option;
import egovframework.kss.main.model.Question;
import egovframework.kss.main.vo.ExamParticipationVO;

@Repository("QuestionDAO")
public class QuestionDAO {

	@Autowired
	SqlSession sqlSession;

	public void insertSubjectiveQuestion(Question question) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		questionMapper.insertQuestion(question);
	}

	public void insertDescriptiveQuestion(Question question) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		questionMapper.insertQuestion(question);
	}

	public void insertMultipleChoiceQuestion(Question question, List<Option> options) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		questionMapper.insertQuestion(question);

		int questionId = question.getId();
		System.out.println("questionId: " + questionId);

		for (Option option : options) {
			option.setQuestion_id(questionId);
			questionMapper.insertOption(option);
		}

	}

	public List<QuestionListDTO> selectQuestionListsByTestId(int testId) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		return questionMapper.selectQuestionListsByTestId(testId);
	}

	public QuestionDetailDTO selectQuestionById(int questionId) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		return questionMapper.selectQuestionById(questionId);
	}

	public List<Option> getOptionsByQuestionId(int questionId) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		return questionMapper.getOptionsByQuestionId(questionId);
	}

	public int getTotalScoreByTestId(int testId) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		return questionMapper.getTotalScoreByTestId(testId);
	}

	public void deleteQuestion(int questionId) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		questionMapper.deleteQuestion(questionId);

	}

	public void deleteOptionByQuestionId(int questionId) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		questionMapper.deleteOptionByQuestionId(questionId);

	}

	public void updateSubjectiveQuestion(Question question) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		questionMapper.updateQuestion(question);

	}

	public void updateDescriptiveQuestion(Question question) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		questionMapper.updateQuestion(question);
	}

	public void updateMultipleChoiceQuestion(Question question, List<Option> options) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		questionMapper.updateQuestion(question);

		int questionId = question.getId();
		System.out.println("questionId: " + questionId);

		for (Option option : options) {
			option.setQuestion_id(questionId);
			questionMapper.insertOption(option);
		}

	}

	public QuestionDetailDTO selectNextQuestionById(int currentQuestionId) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		return questionMapper.selectNextQuestionById(currentQuestionId);
	}

	public void insertUserAnswer(AnswerDTO answer) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		questionMapper.insertUserAnswer(answer);

	}

	public void updateUserAnswer(AnswerDTO answer) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		questionMapper.updateUserAnswer(answer);

	}

	public boolean checkUserAnswerExists(AnswerDTO answer) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		return questionMapper.checkUserAnswerExists(answer);
	}

	public String selectUserAnswer(Map<String, Object> params) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		return questionMapper.selectUserAnswer(params);
	}

	public boolean checkExamParticipationExists(Map<String, Object> params) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		return questionMapper.checkExamParticipationExists(params);
	}

	public void insertExamParticipation(Map<String, Object> params) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		questionMapper.insertExamParticipation(params);
	}

	public ExamParticipationVO selectExamParticipation(Map<String, Object> params) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		return questionMapper.selectExamParticipation(params);
	}

	public void updateExamParticipation(ExamParticipationVO examParticipation) {
		QuestionMapper questionMapper = sqlSession.getMapper(QuestionMapper.class);
		questionMapper.updateExamParticipation(examParticipation);

	}

}
