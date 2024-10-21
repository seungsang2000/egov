package egovframework.kss.main.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.kss.main.model.Option;
import egovframework.kss.main.model.Question;

@Repository("QuestionDAO")
public class QuestionDAO {

	@Autowired
	SqlSession sqlSession;

	public void insertSubjectiveQuestion(Question question) {
		// TODO Auto-generated method stub

	}

	public void insertDescriptiveQuestion(Question question) {
		// TODO Auto-generated method stub

	}

	public void insertMultipleChoiceQuestion(Question question, List<Option> options) {
		// TODO Auto-generated method stub

	}

}
