package egovframework.kss.main.service;

import javax.servlet.http.HttpServletRequest;

import egovframework.kss.main.dto.SolveQuestionDTO;
import egovframework.kss.main.dto.SolveTestDTO;
import egovframework.kss.main.dto.TestReviewDTO;

public interface TestService {
	public SolveTestDTO solveTest(int testId, Integer questionId);

	public SolveQuestionDTO solveQuestion(HttpServletRequest request, Integer questionId, Integer nextQuestionId);

	public TestReviewDTO getTestReview(int testId, Integer questionId);

}
