<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date"%>

<%@ include file="/WEB-INF/jsp/include/header.jsp"%>

<%
    // 현재 시간 가져오기
    Date currentTime = new Date();
    request.setAttribute("currentTime", currentTime);
%>

<link rel="stylesheet" href="/resources/chat.css">

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h1>강좌 세부사항</h1>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="/">나의 강좌</a></li>
						<li class="breadcrumb-item active">${course.title}</li>
					</ol>
				</div>
			</div>
		</div>
		<!-- /.container-fluid -->
	</section>

	<!-- Main content -->
	<section class="content">

<ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link" href="/course.do?id=${course.id}">시험 목록</a> <!-- 시험 목록 페이지 -->
        </li>
        <li class="nav-item">
            <a class="nav-link  active" href="#">소통</a> <!-- 소통 페이지 -->
        </li>
        <sec:authorize access="hasAuthority('admin')">
        <li class="nav-item">
            <a class="nav-link" href="/testVideo.do?id=${course.id}">시험영상</a> <!-- 소통 페이지 -->
        </li>
        </sec:authorize>
    </ul>
    <!-- Default box -->
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">${course.title}</h3>

            <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                    <i class="fas fa-minus"></i>
                </button>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="container">

      <div class="inbox_msg">
        <div class="inbox_people">
          <div class="headind_srch">
            <div class="recent_heading">
              <h4>유저 목록</h4>
            </div>
<!--             <div class="srch_bar">
              <div class="stylish-input-group">
                <input type="text" class="search-bar"  placeholder="Search" >
                <span class="input-group-addon">
                <button type="button"> <i class="fa fa-search" aria-hidden="true"></i> </button>
                </span> </div>
            </div> -->
          </div>
          <div class="inbox_chat">

            <c:forEach var="user" items="${users}">
            <div class="chat_list" onclick="setRecipient('${user.id}', '${user.name}')">
              <div class="chat_people">
                <div class="chat_img"> <img src="/${user.image_path}" 
                             alt="이미지 없음" 
                             class="img-circle" 
                             width="50" 
                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/question_mark.png';"> </div>
                <div class="chat_ib">
                  <h5 style="font-size: 17px">${user.name} <span class="chat_date"><fmt:formatDate value="${user.created_at}" pattern="yyyy-MM-dd" /></span></h5>
                  <p> <c:choose>
            	<c:when test="${user.role eq 'admin'}">
            	<p style="color: blue;">강사</p>
            	</c:when>
            	<c:otherwise>
            	학생
            	</c:otherwise>
            	</c:choose>
            	</p>
                </div>
              </div>
            </div>
            </c:forEach>
            
          </div>
        </div>
        <div class="mesgs">
    <div class="msg_history">
        <c:forEach var="chat" items="${chatMessages}">
<%--             <div class="${chat.is_me ? 'outgoing_msg' : 'incoming_msg'}">
                <div class="${chat.is_me ? 'sent_msg' : 'received_msg'}">
                    <p>${chat.message}</p>
                    <span class="time_date">${chat.created_at}</span>
                </div>
                <c:if test="${!chat.is_me}">
                    <div class="incoming_msg_img">
                        <img src="/${chat.user_image}" alt="${chat.user_name}">
                    </div>
                </c:if>
            </div> --%>
            <c:choose>
            	<c:when test="${chat.is_me}">
            	<div id="${chat.id}" class="outgoing_msg">
            	
            	<div class="sent_msg">
            	<c:if test="${not empty chat.recipient_name}">
            <div class="recipient-info-new">
                ${chat.recipient_name}에게
            </div>
        </c:if>
                <p>${chat.message}</p>
                <span class="time_date"><fmt:formatDate value="${chat.created_at}" pattern="yyyy. MM. dd. a h:mm:ss"/></span>
                </div>
            </div>
            	</c:when>
            	<c:otherwise>
<div id="${chat.id}" class="incoming_msg">
    <div class="incoming_msg_img"> 
        <img src="/${chat.user_image}" alt="${chat.user_name}" class="img-circle" width="50" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/question_mark.png';"> 
    </div>
    <div class="received_msg">
        <div class="msg_info">
            <span class="info-box-number">${chat.user_name}</span>
            <c:if test="${not empty chat.recipient_name}">
                <span class="recipient-message">
                    ${chat.recipient_name}에게
                </span>
            </c:if>
        </div>
        <div class="received_withd_msg">
            <p>${chat.message}</p>
            <span class="time_date"><fmt:formatDate value="${chat.created_at}" pattern="yyyy. MM. dd. a h:mm:ss"/></span>
        </div>
    </div>
</div>
            	</c:otherwise>
            </c:choose>
            
        </c:forEach>
    </div>
    <div class="type_msg">
    <div class="recipient-info" style="font-weight: bold; display: none; justify-content: space-between; align-items: center; margin-right: 50px;">
        <div style="display: flex; align-items: center; font-size: 15px">
            <i class="fas fa-angle-double-right" style="margin-right: 5px;"></i>
            <span></span>
        </div>
        <i class="fas fa-times" style="cursor: pointer;" onclick="clearRecipient()"></i>
    </div>
    <form id="chatForm" onsubmit="sendMessage(event)">
        <div class="input_msg_write " style="display: flex; align-items: center; margin-right: 50px;">
            <input type="text" class="write_msg" placeholder="메시지를 입력하세요..." required />
            <input type="hidden" id="course_id" value="${course.id}"/>
            
            <button class="msg_send_btn" type="submit">
            <i class="fa fa-paper-plane" aria-hidden="true">
            </i></button>
        </div>
    </form>
</div>
	</div>
      </div>
    </div>
    </div>

        </div>
        <!-- /.card-body -->
    </div>
    <!-- /.card -->


</section>
<!-- /.content -->
<!-- /.content-wrapper -->

<script>
let stompClient2 = null;
const userId = "${userId}"
let recipientId = null;
let recipientName = '';

function setRecipient(id, name) {
    if(userId != id){
    recipientId = id;
    recipientName = name;
    
    const recipientInfo = document.querySelector('.recipient-info');
    const recipientNameSpan = recipientInfo.querySelector('span');
    
    recipientNameSpan.innerHTML = '<span style="color: blue;">' + name + '</span>에게';
    recipientInfo.style.display = 'flex';
    }
}

function clearRecipient() {
    recipientId = null; // 수신자 ID 초기화
    recipientName = ''; // 수신자 이름 초기화
    const recipientInfo = document.querySelector('.recipient-info');
    const recipientNameSpan = recipientInfo.querySelector('span');
    
    recipientNameSpan.innerHTML = ''; // 수신자 이름 지우기
    recipientInfo.style.display = 'none';
}


function connectChat() {
    const socket = new SockJS('/stomp'); 
    stompClient2 = Stomp.over(socket);

    stompClient2.connect({}, function (frame) {
        

        const courseId = document.getElementById('course_id').value;
        
            stompClient2.subscribe('/topic/course/'+courseId+'/chat', function (message) {
                    
                const data = JSON.parse(message.body);
                
                addMessage(data);
                
             });
    });
}

function sendMessage(event) {
    event.preventDefault();

    const messageInput = document.querySelector('.write_msg');
    const message = messageInput.value;
    const courseId = document.getElementById('course_id').value;
    const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
    const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

    if (message) {
        fetch('/sendChat.do', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                [csrfHeader]: csrfToken
            },
            body: JSON.stringify({ message, course_id: courseId, recipient_id: recipientId }),
        })
        .then(response => response.json())
        .then(data => {
            
            messageInput.value = '';
        })
        .catch(error => console.error('Error:', error));
    }
    clearRecipient()
}

function addMessage(data) { 
    const msgHistory = document.querySelector('.msg_history');
    const newMsg = document.createElement('div');
    const currentTime = new Date(data.created_at).toLocaleString();
    let message = '';
    
    newMsg.innerHTML = '';
    
    
    if(userId != data.sender_id){
    
    newMsg.classList.add('incoming_msg');
    newMsg.id = data.message_id;
    if (data.recipient_name) {
        message = 
            '<span class="recipient-message"> ' +
                data.recipient_name + '에게' +
            '</span>';
    }
    newMsg.innerHTML += 
        '<div class="incoming_msg_img"> <img src="/'+ data.sender_image+'" class="img-circle"  alt="'+data.sender+'"' + ` onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/question_mark.png';"`+ '> </div><div class="received_msg"><span class="info-box-number">'+data.sender+'</span>'+message+'<div class="received_withd_msg"><p>'+data.content+
        '</p><span class="time_date">'+currentTime+'</span></div></div>';
    msgHistory.appendChild(newMsg);
    msgHistory.scrollTop = msgHistory.scrollHeight;
    } else{
        newMsg.classList.add('outgoing_msg');
        newMsg.id = data.message_id;
        if (data.recipient_name) {
            newMsg.insertAdjacentHTML('beforeend',
                '<div class="sent_msg">' +
                    '<div class="recipient-info-new">' +
                        data.recipient_name + '에게' +
                    '</div>' +
                    '<p>' + data.content + '</p>' +
                    '<span class="time_date">' + currentTime + '</span>' +
                '</div>'
            );
        } else {
            newMsg.insertAdjacentHTML('beforeend',
                '<div class="sent_msg">' +
                    '<p>' + data.content + '</p>' +
                    '<span class="time_date">' + currentTime + '</span>' +
                '</div>'
            );
        }
        msgHistory.appendChild(newMsg);
        msgHistory.scrollTop = msgHistory.scrollHeight;
    }
}


const originalOnload = window.onload;

window.onload = function() {
    if (originalOnload) originalOnload();
    const msgHistory = document.querySelector('.msg_history');
    
    
    var messageId = ${messageId != null ? messageId : 'null'};
    if (messageId != null) {
        var element = document.getElementById(messageId);
        if (element) {
            element.scrollIntoView({ behavior: 'smooth' });
        }
    } else{
        msgHistory.scrollTop = msgHistory.scrollHeight;
    }
    
    connectChat();
}




</script>

<style>
.recipient-info-new {
    font-size: 12px; 
    color: gray; 
    margin-bottom: 2px;
    text-align: left; 
    position: relative; 
    top: 0px; 
    left: 0; 
    padding-top:0px;
}

.recipient-message {
    font-size: 12px; 
    color: gray; 
    margin-bottom: 2px;
    text-align: right; 
    position: relative; 
    top: 0px; 
    left: 0; 
    margin-left: auto;
}

.chat_list {
    cursor: pointer; 
    transition: background-color 0.3s ease; 
}

.chat_list:hover {
    background-color: #f0f0f0; 
}
</style>



<%@ include file="/WEB-INF/jsp/include/footer.jsp"%>
