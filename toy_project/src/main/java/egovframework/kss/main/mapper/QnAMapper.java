package egovframework.kss.main.mapper;

import java.util.List;
import java.util.Map;

import egovframework.kss.main.vo.CheckedVO;
import egovframework.kss.main.vo.DivisionVO;
import egovframework.kss.main.vo.QnACommentVO;
import egovframework.kss.main.vo.QnAInsertVO;
import egovframework.kss.main.vo.QnAListVO;
import egovframework.kss.main.vo.QnAVO;

public interface QnAMapper {

	List<QnAVO> selectQnAList();

	QnAVO selectQnAById(int id);

	List<QnAListVO> selectQnALists();

	void addViews(int id);

	List<Map<String, Object>> selectPageList(Map params);

	List<CheckedVO> selectCheckedList();

	List<DivisionVO> selectDivisionList();

	void registerQnA(QnAInsertVO qnAVO);

	void updateQnA(QnAInsertVO qnAVO);

	void deleteQnA(int id);

	void registerQnAComment(QnACommentVO qnACommentVO);

	QnACommentVO selectQnAComment(int id);

	void deleteQnAComment(int id);

	void updateQnAChecked(Map params);

	String getPasswordById(int id);

}
