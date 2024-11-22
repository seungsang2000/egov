package egovframework.kss.main.dto;

import java.util.List;

import egovframework.kss.main.vo.CourseVO;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Getter
@Setter
public class SolveTestDTO {
	private String endTime;  // ISO 포맷의 종료 시간
	private int testId;
	private int userId;
	private int selectedQuestionId;
	private List<QuestionListDTO> questions;
	private QuestionDetailWithUserAnswerDTO currentQuestion;
	private Integer nextQuestionId;
	private CourseVO course;
	private boolean editable;
}
