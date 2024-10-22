package egovframework.kss.main.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class commonFileVo {

	private MultipartFile mpfile;

	private String id;
	private String fileName;
	private String action;

}
