package egovframework.kss.main.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import egovframework.kss.main.dao.QuestionDAO;
import egovframework.kss.main.dto.QuestionDetailDTO;
import egovframework.kss.main.dto.QuestionListDTO;
import egovframework.kss.main.model.Option;
import egovframework.kss.main.model.Question;
import egovframework.kss.main.service.QuestionService;

@Service("QuestionService")
public class QuestionServiceImpl implements QuestionService {

	@Resource(name = "QuestionDAO")
	QuestionDAO questionDAO;

	@Override
	public void insertSubjectiveQuestion(Question question) {
		questionDAO.insertSubjectiveQuestion(question);

	}

	@Override
	public void insertDescriptiveQuestion(Question question) {
		questionDAO.insertDescriptiveQuestion(question);

	}

	@Override
	@Transactional
	public void insertMultipleChoiceQuestion(Question question, List<Option> options) {
		questionDAO.insertMultipleChoiceQuestion(question, options);

	}

	@Override
	public List<QuestionListDTO> selectQuestionListsByTestId(int testId) {
		return questionDAO.selectQuestionListsByTestId(testId);

	}

	@Override
	public QuestionDetailDTO selectQuestionById(int questionId) {
		QuestionDetailDTO question = questionDAO.selectQuestionById(questionId);

		// 객관식 질문일 경우 옵션을 가져옴
		if ("객관식".equals(question.getQuestion_type())) {
			List<Option> options = questionDAO.getOptionsByQuestionId(questionId);
			question.setOptions(options);
		}

		return question;
	}

	@Override
	public int getTotalScoreByTestId(int testId) {

		return questionDAO.getTotalScoreByTestId(testId);
	}

	@Override
	public void deleteQuestion(int questionId) {
		questionDAO.deleteQuestion(questionId);

	}

	@Override
	public void updateSubjectiveQuestion(Question question) {
		deleteOptionByQuestionId(question.getId());
		questionDAO.updateSubjectiveQuestion(question);

	}

	@Override
	public void updateDescriptiveQuestion(Question question) {
		deleteOptionByQuestionId(question.getId());
		questionDAO.updateDescriptiveQuestion(question);
	}

	@Override
	public void updateMultipleChoiceQuestion(Question question, List<Option> options) {
		deleteOptionByQuestionId(question.getId());
		questionDAO.updateMultipleChoiceQuestion(question, options);
	}

	@Override
	public void deleteOptionByQuestionId(int questionId) {
		questionDAO.deleteOptionByQuestionId(questionId);

	}

}
