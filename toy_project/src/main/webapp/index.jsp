<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:forward page="/mainPage.do"/>
<!-- <!DOCTYPE html>
<html>
<head>
    <title>STOMP Example</title>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.3.0/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
</head>
<body>
    <h1>STOMP Example</h1>
    <button onclick="sendMessage()">Send Message</button>

    <script>
        var socket = new SockJS('http://localhost:8080/stomp'); // STOMP 엔드포인트에 연결
        var stompClient = Stomp.over(socket);

        stompClient.connect({}, function (frame) {
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/messages', function (message) {
                console.log('Received: ' + message.body);
            });
        });

        // 메시지를 전송하는 함수
        function sendMessage() {
            stompClient.send("/app/sendMessage", {}, JSON.stringify({'message': 'Hello, World!'}));
        }
    </script>
</body>
</html> -->