package egovframework.kss.main.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.kss.main.dao.QuestionDAO;
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
		questionDAO.insertDescriptiveQuestion(question)

	}

	@Override
	public void insertMultipleChoiceQuestion(Question question, List<Option> options) {
		questionDAO.insertMultipleChoiceQuestion(question, options);

	}

}
