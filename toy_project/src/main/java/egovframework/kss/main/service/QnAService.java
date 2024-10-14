package egovframework.kss.main.service;

import java.util.List;
import java.util.Map;

import egovframework.kss.main.vo.CheckedVO;
import egovframework.kss.main.vo.DivisionVO;
import egovframework.kss.main.vo.QnACommentVO;
import egovframework.kss.main.vo.QnAInsertVO;
import egovframework.kss.main.vo.QnAListVO;
import egovframework.kss.main.vo.QnAVO;

public interface QnAService {

	List<QnAVO> selectQnAlist();

	QnAVO selectQnAById(int id);

	List<QnAListVO> selectQnAlists();

	void addViews(int id);

	Map<String, Object> selectPageList(Map<String, Object> map);

	List<CheckedVO> selectCheckedList();

	List<DivisionVO> selectDivisionList();

	void registerQnA(QnAInsertVO qnAVO);

	void updateQnA(QnAInsertVO qnAVO);

	void deleteQnA(int id);

	void registerQnAComment(QnACommentVO qnACommentVO);

	QnACommentVO selectQnAComment(int id);

	void deleteQnAComment(int id);

	void updateQnAChecked(Map<String, Object> map);

	boolean validatePassword(int id, String password);

}
