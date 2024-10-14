package egovframework.kss.main.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.kss.main.mapper.QnAMapper;
import egovframework.kss.main.vo.CheckedVO;
import egovframework.kss.main.vo.DivisionVO;
import egovframework.kss.main.vo.QnACommentVO;
import egovframework.kss.main.vo.QnAInsertVO;
import egovframework.kss.main.vo.QnAListVO;
import egovframework.kss.main.vo.QnAVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Repository("QnADAO")
public class QnADAO {

	@Autowired
	SqlSession sqlSession;

	public List<QnAVO> selectQnAlist() {
		QnAMapper qnaMapper = sqlSession.getMapper(QnAMapper.class);
		return qnaMapper.selectQnAList();
	}

	public QnAVO selectQnAById(int id) {
		QnAMapper qnAMapper = sqlSession.getMapper(QnAMapper.class);
		return qnAMapper.selectQnAById(id);

	}

	public List<QnAListVO> selectQnALists() {
		QnAMapper qnaMapper = sqlSession.getMapper(QnAMapper.class);
		return qnaMapper.selectQnALists();
	}

	public void addViews(int id) {
		QnAMapper qnAMapper = sqlSession.getMapper(QnAMapper.class);
		qnAMapper.addViews(id);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map selectPageList(Object params) {
		// 넘어온 파라미터 값을 Map 객체로 만들어주고, PaginationInfo 객체 선언
		Map<String, Object> map = (Map<String, Object>) params;
		PaginationInfo paginationInfo = null; // 페이징에 필요한 정보들

		// Map객체로부터 currentPageNo을 가져왔는데 값이 없으면, 현재 페이지번호(currentPageNo)를 1로 설정
		if (!map.containsKey("currentPageNo") || StringUtils.isEmpty((String) map.get("currentPageNo"))) {
			map.put("currentPageNo", "1");
		}

		// PaginationInfo 객체 생성 및 설정
		paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(Integer.parseInt(map.get("currentPageNo").toString()));

		// Map 객체로부터 PAGE_ROW를 가져왔는데 값이 없을 경우 한 페이지당 게시물 개수를 15개로 설정
		if (!map.containsKey("PAGE_ROW") || StringUtils.isEmpty((String) map.get("PAGE_ROW"))) {
			paginationInfo.setRecordCountPerPage(10);
		} else {
			paginationInfo.setRecordCountPerPage(Integer.parseInt(map.get("PAGE_ROW").toString()));
		}

		// PageSize는 10으로 설정
		paginationInfo.setPageSize(10);

		// 페이지의 시작번호, 끝번호 계산해서 파라미터에 추가
		int start = paginationInfo.getFirstRecordIndex();
		int end = start + paginationInfo.getRecordCountPerPage();
		map.put("START", start + 1);
		map.put("END", end);

		// QnAMapper 인터페이스를 통해 쿼리 실행
		QnAMapper qnaMapper = sqlSession.getMapper(QnAMapper.class);
		List<Map<String, Object>> list = qnaMapper.selectPageList(map);

		Map<String, Object> returnMap = new HashMap<>();

		// List 객체가 비어있다면 (게시물이 없을 경우)
		if (list.isEmpty()) {
			map = new HashMap<>();
			map.put("TOTAL_COUNT", 0);
			list.add(map);

			if (paginationInfo != null) {
				paginationInfo.setTotalRecordCount(0);
				returnMap.put("paginationInfo", paginationInfo);
			}
		} else {
			if (paginationInfo != null) {
				paginationInfo.setTotalRecordCount(Integer.parseInt(list.get(0).get("TOTAL_COUNT").toString()));
				returnMap.put("TOTAL_COUNT", Integer.parseInt(list.get(0).get("TOTAL_COUNT").toString()));
				returnMap.put("paginationInfo", paginationInfo);
			}
		}

		returnMap.put("result", list);
		return returnMap;
	}

	public List<CheckedVO> selectCheckedList() {
		QnAMapper qnaMapper = sqlSession.getMapper(QnAMapper.class);
		return qnaMapper.selectCheckedList();
	}

	public List<DivisionVO> selectDivisionList() {
		QnAMapper qnaMapper = sqlSession.getMapper(QnAMapper.class);
		return qnaMapper.selectDivisionList();

	}

	public void registerQnA(QnAInsertVO qnAVO) {
		QnAMapper qnaMapper = sqlSession.getMapper(QnAMapper.class);
		qnAVO.setChecked_id(0);
		if (qnAVO.getPassword().equals("")) {
			qnAVO.setPassword(null);
		}
		qnaMapper.registerQnA(qnAVO);
	}

	public void updateQnA(QnAInsertVO qnAVO) {
		QnAMapper qnaMapper = sqlSession.getMapper(QnAMapper.class);
		qnaMapper.updateQnA(qnAVO);
	}

	public void deleteQnA(int id) {
		QnAMapper qnaMapper = sqlSession.getMapper(QnAMapper.class);
		qnaMapper.deleteQnA(id);
	}

	public void registerQnAComment(QnACommentVO qnACommentVO) {
		QnAMapper qnaMapper = sqlSession.getMapper(QnAMapper.class);
		qnaMapper.registerQnAComment(qnACommentVO);
	}

	public QnACommentVO selectQnAComment(int id) {
		QnAMapper qnaMapper = sqlSession.getMapper(QnAMapper.class);
		return qnaMapper.selectQnAComment(id);
	}

	public void deleteQnAComment(int id) {
		QnAMapper qnaMapper = sqlSession.getMapper(QnAMapper.class);
		qnaMapper.deleteQnAComment(id);
	}

	public void updateQnAChecked(Map params) {
		QnAMapper qnaMapper = sqlSession.getMapper(QnAMapper.class);
		qnaMapper.updateQnAChecked(params);
	}

	public String getPasswordById(int id) {
		QnAMapper qnaMapper = sqlSession.getMapper(QnAMapper.class);
		return qnaMapper.getPasswordById(id);
	}

}
