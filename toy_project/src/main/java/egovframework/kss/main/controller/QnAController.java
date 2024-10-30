package egovframework.kss.main.controller;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.kss.main.service.QnAService;
import egovframework.kss.main.vo.QnACommentVO;
import egovframework.kss.main.vo.QnAInsertVO;
import egovframework.kss.main.vo.QnAVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/QnA")
public class QnAController {
	private static Logger Logger = LoggerFactory.getLogger(QnAController.class);

	@Resource(name = "QnAService")
	private QnAService qnAService;

	@RequestMapping(value = "qnalist.do")
	public String selectQnAlist(Model model) {

		List<?> list = qnAService.selectQnAlists();
		model.addAttribute("list", list);

		int count = list.size();
		model.addAttribute("count", count);

		return "bbs/qnaList";
	}

	@RequestMapping(value = "qna.do")
	public String selectQnA(@RequestParam("id") int id, @RequestParam(value = "division_id", required = false) String divisionId, @RequestParam(value = "checked_id", required = false) String checkedId, @RequestParam(value = "searchKeyword", required = false) String searchKeyword, @RequestParam(value = "currentPageNo", required = false) Integer currentPageNo, Model model) {

		qnAService.addViews(id);

		QnAVO vo = qnAService.selectQnAById(id);
		model.addAttribute("qna", vo);

		QnACommentVO comment = qnAService.selectQnAComment(id);
		if (comment != null) {
			model.addAttribute("comment", comment);
		}

		System.out.println(vo.getTestDate());

		if (currentPageNo != null) {
			model.addAttribute("currentPageNo", currentPageNo);
		}

		// 추가적인 모델 데이터 추가 (divisionId, checkedId, searchKeyword 등)
		if (divisionId != null) {
			model.addAttribute("divisionId", divisionId);
		}
		if (checkedId != null) {
			model.addAttribute("checkedId", checkedId);
		}
		if (searchKeyword != null && !searchKeyword.isEmpty()) {
			model.addAttribute("searchKeyword", searchKeyword);
		}

		return "bbs/qnaInfo";
	}

	@RequestMapping(value = "qnaPageList.do")
	public String openBoardList(@RequestParam Map<String, Object> params, Model model) throws Exception {

		System.out.println("paging....");

		String divisionId = (String) params.get("division_id");
		String checkedId = (String) params.get("checked_id");
		String searchKeyword = (String) params.get("searchKeyword");

		if (searchKeyword != null && !searchKeyword.isEmpty()) {
			params.put("searchKeyword", searchKeyword);
			model.addAttribute("searchKeyword", searchKeyword);
		} else {
			params.remove("searchKeyword"); // 빈 문자열일 경우 params에서 제거
		}

		// division_id가 빈 문자열이 아닌 경우에만 params에 추가
		if (divisionId != null && !divisionId.isEmpty()) {
			params.put("division_id", Integer.parseInt(divisionId)); // Integer로 변환
			model.addAttribute("divisionId", divisionId);
		} else {
			params.remove("division_id"); // division_id가 없을 경우 params에서 제거
		}

		// checked_id가 빈 문자열이 아닌 경우에만 params에 추가
		if (checkedId != null && !checkedId.isEmpty()) {
			params.put("checked_id", Integer.parseInt(checkedId)); // Integer로 변환
			model.addAttribute("checkedId", checkedId);
		} else {
			params.remove("checked_id"); // checked_id가 없을 경우 params에서 제거
		}

		Map<String, Object> resultMap = qnAService.selectPageList(params);

		// JSP에서 가져다 쓰도록 Map 객체에서 paginationInfo랑 result 가져와서 올려주기
		model.addAttribute("paginationInfo", (PaginationInfo) resultMap.get("paginationInfo"));
		model.addAttribute("list", resultMap.get("result"));

		//		// 총 게시글 수 추가
		Integer totalCount = (Integer) resultMap.get("TOTAL_COUNT");
		if (totalCount == null) {
			totalCount = 0; // 기본값 설정
		}

		model.addAttribute("count", totalCount); // 모델에 추가

		List<?> checked = qnAService.selectCheckedList();
		model.addAttribute("checked", checked);

		List<?> division = qnAService.selectDivisionList();
		model.addAttribute("division", division);

		// 포워딩할 경로 지정
		return "bbs/qnaList"; // ModelAndView 대신 String 반환
	}

	@RequestMapping(value = "registerQnAPage.do")
	public String registerNoticePage(Model model) throws Exception {

		List<?> division = qnAService.selectDivisionList();
		model.addAttribute("division", division);

		return "bbs/qnaRegister";
	}

	@PostMapping(value = "QnARegister.do")
	public String registerNotice(QnAInsertVO qnAVO, Model model) throws Exception {

		qnAVO.setTestDate(Timestamp.from(Instant.now()));
		qnAVO.setView(0);

		// 저장 로직 수행
		qnAService.registerQnA(qnAVO);

		return "redirect:/QnA/qnaPageList.do";
	}

	@RequestMapping(value = "updatePage.do")
	public String updateNoticePage(@RequestParam("id") int id, Model model) throws Exception {
		QnAVO qnAVO = qnAService.selectQnAById(id);
		model.addAttribute("qna", qnAVO);

		List<?> division = qnAService.selectDivisionList();
		model.addAttribute("division", division);

		return "bbs/qnaUpdate";
	}

	@PostMapping(value = "updateQnA.do")
	public String updateNotice(QnAInsertVO qnAVO, Model model) throws Exception {
		qnAService.updateQnA(qnAVO);
		return "redirect:/QnA/qnaPageList.do";
	}

	@DeleteMapping("/deleteQnA.do")
	@ResponseBody
	public ResponseEntity<String> deleteQnA(@RequestParam("id") int id) {
		try {
			qnAService.deleteQnA(id);
			return ResponseEntity.ok("삭제되었습니다.");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패");
		}
	}

	@PostMapping(value = "commentRegister.do")
	public String commentRegister(QnACommentVO qnACommentVO, Model model) {
		qnAService.registerQnAComment(qnACommentVO);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("id", qnACommentVO.getPost_id());
		resultMap.put("checked_id", 1);
		qnAService.updateQnAChecked(resultMap);

		return "redirect:/QnA/qna.do?id=" + qnACommentVO.getPost_id();
	}

	@DeleteMapping("/deleteQnAComment.do")
	@ResponseBody
	public ResponseEntity<String> deleteQnAComment(@RequestParam("id") int id, @RequestParam("post_id") int post_id) {
		try {
			qnAService.deleteQnAComment(id);
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("id", post_id);
			resultMap.put("checked_id", 2);
			qnAService.updateQnAChecked(resultMap);

			return ResponseEntity.ok("삭제되었습니다.");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패");
		}
	}

	@PostMapping(value = "/checkPassword.do")
	@ResponseBody
	public Map<String, Object> checkPassword(@RequestBody Map<String, Object> request) {
		System.out.println("checkPassword");
		int id = Integer.parseInt((String) request.get("id"));
		String password = (String) request.get("password");
		System.out.println("id: " + id + " password: " + password);

		boolean isValid = qnAService.validatePassword(id, password);

		Map<String, Object> response = new HashMap<>();
		response.put("success", isValid);
		System.out.println(isValid);
		return response;
	}

}
