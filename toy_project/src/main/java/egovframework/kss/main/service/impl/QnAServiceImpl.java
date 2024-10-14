package egovframework.kss.main.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.kss.main.dao.QnADAO;
import egovframework.kss.main.service.QnAService;
import egovframework.kss.main.vo.CheckedVO;
import egovframework.kss.main.vo.DivisionVO;
import egovframework.kss.main.vo.QnACommentVO;
import egovframework.kss.main.vo.QnAInsertVO;
import egovframework.kss.main.vo.QnAListVO;
import egovframework.kss.main.vo.QnAVO;

@Service("QnAService")
public class QnAServiceImpl implements QnAService {

	@Resource(name = "QnADAO")
	private QnADAO qnaDAO;

	@Override
	public List<QnAVO> selectQnAlist() {

		return qnaDAO.selectQnAlist();
	}

	@Override
	public QnAVO selectQnAById(int id) {
		return qnaDAO.selectQnAById(id);
	}

	@Override
	public List<QnAListVO> selectQnAlists() {
		return qnaDAO.selectQnALists();
	}

	@Override
	public void addViews(int id) {
		qnaDAO.addViews(id);
	}

	@Override
	public Map<String, Object> selectPageList(Map<String, Object> map) {
		return qnaDAO.selectPageList(map);
	}

	@Override
	public List<CheckedVO> selectCheckedList() {
		return qnaDAO.selectCheckedList();
	}

	@Override
	public List<DivisionVO> selectDivisionList() {
		return qnaDAO.selectDivisionList();
	}

	@Override
	public void registerQnA(QnAInsertVO qnAVO) {
		qnaDAO.registerQnA(qnAVO);
	}

	@Override
	public void updateQnA(QnAInsertVO qnAVO) {
		qnaDAO.updateQnA(qnAVO);
	}

	@Override
	public void deleteQnA(int id) {
		qnaDAO.deleteQnA(id);
	}

	@Override
	public void registerQnAComment(QnACommentVO qnACommentVO) {
		qnaDAO.registerQnAComment(qnACommentVO);
	}

	@Override
	public QnACommentVO selectQnAComment(int id) {
		return qnaDAO.selectQnAComment(id);
	}

	@Override
	public void deleteQnAComment(int id) {
		qnaDAO.deleteQnAComment(id);
	}

	@Override
	public void updateQnAChecked(Map<String, Object> map) {
		qnaDAO.updateQnAChecked(map);
	}

	@Override
	public boolean validatePassword(int id, String password) {
		String storedPassword = qnaDAO.getPasswordById(id);
		System.out.println("storedPassword: " + storedPassword);
		return storedPassword != null && storedPassword.equals(password);
	}

}
