package egovframework.kss.main.dto;

import java.util.List;

import egovframework.kss.main.vo.CourseVO;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class SolveQuestionDTO {
	private List<QuestionListDTO> questions;
	private int testId;
	private int userId;
	private String endTime;
	private QuestionDetailWithUserAnswerDTO currentQuestion;
	private int selectedQuestionId;
	private Integer nextQuestionId;
	private CourseVO course;
	private boolean editable;

	// 생성자, Getter/Setter 생략
}
