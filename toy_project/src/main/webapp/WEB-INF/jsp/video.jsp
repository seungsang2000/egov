<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>온라인 시험</title>
</head>
<body>
    <h1>온라인 시험</h1>
    <button id="stopExamBtn" disabled>시험 종료(영상 제출)</button>

    <script>
        let mediaRecorder;
        let recordedChunks = [];
        let currentStream; // 현재 스트림을 저장할 변수

        async function requestFullScreenCapture() {
            const stream = await navigator.mediaDevices.getDisplayMedia({
                video: {
                    cursor: "always"
                },
                audio: true
            });
            return stream;
        }

        async function startExam() {
            try {
                currentStream = await requestFullScreenCapture(); // 현재 스트림을 저장
                startRecording(currentStream);
                document.getElementById("stopExamBtn").disabled = false; // 종료 버튼 활성화
            } catch (error) {
                alert('전체 화면 녹화 권한이 필요합니다. 시험을 진행할 수 없습니다.');
                window.location.href = '/exam-cancelled'; // 시험 취소 페이지로 이동
            }
        }

        function startRecording(stream) {
            const options = {
                mimeType: 'video/webm; codecs=vp8,opus' // VP8 비디오 코덱과 Opus 오디오 코덱 지정
            };

            mediaRecorder = new MediaRecorder(stream, options);

            mediaRecorder.ondataavailable = (event) => {
                if (event.data.size > 0) {
                    recordedChunks.push(event.data);
                }
            };

            mediaRecorder.onstop = () => {
                const blob = new Blob(recordedChunks, { type: 'video/webm' });
                uploadVideo(blob);

                // 화면 공유 종료
                stream.getTracks().forEach(track => track.stop());
            };

            mediaRecorder.start();
        }

        function stopRecording(stream) {
            mediaRecorder.stop(); // 녹화 중지

            // 화면 공유 종료
            stream.getTracks().forEach(track => track.stop());
            document.getElementById("stopExamBtn").disabled = true; // 종료 버튼 비활성화
        }

        document.getElementById("stopExamBtn").onclick = () => {
            stopRecording(currentStream); // 화면 공유와 녹화 중지
        };

        // 페이지가 로드되면 자동으로 시험 시작
        window.onload = () => {
            startExam();
        };

        async function uploadVideo(blob) {
            const formData = new FormData();
            formData.append('video', blob, 'exam_video.webm');

            const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
            const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

            const response = await fetch('/uploadVideo', {
                method: 'POST',
                headers: {
                    [csrfHeader]: csrfToken // CSRF 토큰 추가
                },
                body: formData
            });

            if (response.ok) {
                alert('비디오가 성공적으로 업로드되었습니다.');
            } else {
                alert('비디오 업로드에 실패했습니다.');
            }
        }
        
    </script>
</body>
</html>