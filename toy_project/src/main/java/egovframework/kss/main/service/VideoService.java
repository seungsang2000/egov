package egovframework.kss.main.service;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

public interface VideoService {

	public String uploadVideo(MultipartFile videoFile, String userId, String testId, String courseId, String duration) throws IOException, InterruptedException;

}
