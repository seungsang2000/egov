package egovframework.kss.main.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PasswordKeyDTO {
	private String email;
	private String key;
	private Timestamp created_at;
}
