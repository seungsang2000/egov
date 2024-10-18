package egovframework.kss.main.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("QuestionDAO")
public class QuestionDAO {

	@Autowired
	SqlSession sqlSession;

}
