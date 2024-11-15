package egovframework.kss.main.controller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpRange;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class VideoController {

	private static final Logger logger = LoggerFactory.getLogger(VideoController.class);

	/*@GetMapping("/video/{courseId}/{userId}/{testId}")
	public Resource serveVideo(@PathVariable int courseId, @PathVariable int userId, @PathVariable int testId) {
		String filePath = "C:/videoupload/" + courseId + "/video_" + userId + "_" + testId + ".webm";
		File videoFile = new File(filePath);
	
		if (!videoFile.exists()) {
			throw new CustomException("비디오파일에 문제가 생겼습니다.");
		}
	
		return new FileSystemResource(videoFile);
	}*/

	@GetMapping("/video/{courseId}/{userId}/{testId}")
	public ResponseEntity<Resource> serveVideo(@PathVariable int courseId, @PathVariable int userId, @PathVariable int testId, @RequestHeader HttpHeaders headers) {
		try {
			String filePath = "C:/videoupload/" + courseId + "/video_" + userId + "_" + testId + ".webm";
			File videoFile = new File(filePath);

			if (!videoFile.exists()) {
				return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
			}

			long fileLength = videoFile.length();
			List<HttpRange> ranges = headers.getRange();

			if (ranges.isEmpty()) {
				return ResponseEntity.ok().header(HttpHeaders.CONTENT_LENGTH, String.valueOf(fileLength)).header(HttpHeaders.CONTENT_TYPE, "video/webm").body(new InputStreamResource(new ByteArrayInputStream(StreamUtils.copyToByteArray(new FileInputStream(videoFile)))));
			} else {
				HttpRange range = ranges.get(0);
				long start = range.getRangeStart(fileLength);
				long end = range.getRangeEnd(fileLength);
				long contentLength = end - start + 1;

				RandomAccessFile randomAccessFile = new RandomAccessFile(videoFile, "r");
				randomAccessFile.seek(start);

				byte[] data = new byte[(int) contentLength];
				randomAccessFile.readFully(data);
				randomAccessFile.close();

				InputStreamResource resource = new InputStreamResource(new ByteArrayInputStream(data));

				return ResponseEntity.status(HttpStatus.PARTIAL_CONTENT).header(HttpHeaders.CONTENT_TYPE, "video/webm").header(HttpHeaders.CONTENT_LENGTH, String.valueOf(contentLength)).header(HttpHeaders.CONTENT_RANGE, "bytes " + start + "-" + end + "/" + fileLength).body(resource);
			}
		} catch (IOException e) {

			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

}
