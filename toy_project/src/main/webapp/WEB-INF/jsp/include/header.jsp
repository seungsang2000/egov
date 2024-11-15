<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<title>온라인 시험 시스템</title>
	
	<style>
#notification-dropdown {
    max-height: 500px; 
    overflow-y: auto;
    overflow-x: hidden;
    width: auto; 
}
#notification-items .dropdown-item {
    white-space: normal !important; 
    overflow-wrap: break-word !important; 
    word-wrap: break-word !important; 
    display: block !important; 
    padding: 10px; 
    box-sizing: border-box; 
    border-bottom: 1px solid rgba(0, 0, 0, 0.1); 
}
</style>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="/resources/plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/resources/dist/css/adminlte.min.css">
  
  <!-- REQUIRED SCRIPTS -->
  
  <!-- video.js -->
  <link href="https://vjs.zencdn.net/7.15.4/video-js.css" rel="stylesheet" />
<script src="https://vjs.zencdn.net/7.15.4/video.min.js"></script>

<!-- jQuery -->
<script src="/resources/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="/resources/dist/js/adminlte.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<!-- ChartJS -->
<script src="/resources/plugins/chart.js/Chart.min.js"></script>
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">

  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="/" class="nav-link">Home</a>
      </li>
    </ul>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
    <c:if test="${pageName == 'courseEnroll' || pageName == 'courseEdit'}">
      <!-- Navbar Search -->
      <li class="nav-item">
        <a class="nav-link" data-widget="navbar-search" href="#" role="button">
          <i class="fas fa-search"></i>
        </a>
        
        <div class="navbar-search-block">
          <form class="form-inline" method="get" onsubmit="return submitSearchForm(this);">
    <div class="input-group input-group-sm">
        <input class="form-control form-control-navbar" type="search" name="search" placeholder="Search" aria-label="Search">
        <div class="input-group-append">
            <button class="btn btn-navbar" type="submit">
                <i class="fas fa-search"></i>
            </button>
            <button class="btn btn-navbar" type="button" data-widget="navbar-search">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>
</form>
        </div>
      </li>
      </c:if>
	      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#">
          <i class="far fa-comments"></i>
          <span class="badge badge-danger navbar-badge" id="DMnotification-count" style="display: none">0</span>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right" id="DMnotification-dropdown">
        <span class="dropdown-header">채팅 알림</span>
        <div class="dropdown-divider"></div>
        <div id="DMnotification-items"></div> <!-- 알림 항목을 추가할 곳 -->
        <div class="dropdown-divider"></div>
          
         
         
          <a href="javascript:void(0);" class="dropdown-item dropdown-footer" onclick="deleteAllDM()">알림 모두 삭제</a>
        </div>
      </li>
      <li class="nav-item dropdown">
    <a class="nav-link" data-toggle="dropdown" href="#">
        <i class="far fa-bell"></i>
        <span class="badge badge-warning navbar-badge" id="notification-count" style="display: none">0</span>
    </a>
    <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right" id="notification-dropdown">
        <span class="dropdown-header">알림</span>
        <div class="dropdown-divider"></div>
        <div id="notification-items"></div> <!-- 알림 항목을 추가할 곳 -->
        <div class="dropdown-divider"></div>
        <a href="javascript:void(0);" class="dropdown-item dropdown-footer" onclick="deleteAllNotifications()">알림 모두 삭제</a>
    </div>
</li>
      <li class="nav-item">
        <a class="nav-link" data-widget="fullscreen" href="#" role="button">
          <i class="fas fa-expand-arrows-alt"></i>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button">
          <i class="fas fa-th-large"></i>
        </a>
      </li>
    </ul>
  </nav>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="/" class="brand-link">
      <img src="/resources/dist/img/TestHubLogo.png" alt="TestHub Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">TestHub</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
        <img src="/<sec:authentication property='principal.image_path' />" 
                             alt="이미지 없음" 
                             class="img-circle elevation-2" 
                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/question_mark.png';">
        </div>
        <div class="info">
          
          	<sec:authorize access="isAuthenticated()">
    <a href="/user/myPage.do" class="d-block"><p><sec:authentication property="principal.name" /></p></a>
</sec:authorize>
<sec:authorize access="!isAuthenticated()">
    <a href="/user/login.do" class="d-block"><p>로그인하세요.</p></a>
</sec:authorize>
    	
        </div>
      </div>

      <!-- SidebarSearch Form -->


      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item menu-open">
            <a href="#" class="nav-link active">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                강좌
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/" class="nav-link <c:if test="${pageName == 'myCourses'}">active</c:if>">
                  <i class="far fa-circle nav-icon"></i>
                  <p>나의 강좌</p>
                </a>
              </li>
              <sec:authorize access="hasAuthority('user')">
              <li class="nav-item">
                <a href="/courseEnroll.do" class="nav-link <c:if test="${pageName == 'courseEnroll'}">active</c:if>">
                  <i class="far fa-circle nav-icon"></i>
                  <p>강좌 등록</p>
                </a>
              </li>
              </sec:authorize>
            </ul>
          </li>
          
          <li class="nav-item menu-open">
          <a href="#" class="nav-link active">
              <i class="nav-icon fas fa-edit"></i>
              <p>
                강좌 관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <sec:authorize access="hasAuthority('admin')">
            <ul class="nav nav-treeview">
            <li class="nav-item">
                <a href="/courseCreate.do" class="nav-link <c:if test="${pageName == 'courseCreate'}">active</c:if>">
                  <i class="far fa-circle nav-icon"></i>
                  <p>강좌 생성</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/courseEditList.do" class="nav-link <c:if test="${pageName == 'courseEdit'}">active</c:if>">
                  <i class="far fa-circle nav-icon"></i>
                  <p>강좌 수정</p>
                </a>
              </li>
            </ul>
            </sec:authorize>
            <sec:authorize access="hasAuthority('user')">
            <ul class="nav nav-treeview">
            <li class="nav-item">
                <a href="/courseEnrollEdit.do" class="nav-link <c:if test="${pageName == 'courseEnrollEdit'}">active</c:if>">
                  <i class="far fa-circle nav-icon"></i>
                  <p>등록 강좌 관리</p>
                </a>
              </li>
            </ul>
            </sec:authorize>
          </li>
          
          <li class="nav-item menu-open">
            <a href="#" class="nav-link active">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                회원 정보
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
            <sec:authorize access="!isAuthenticated()">
              <li class="nav-item">
                <a href="user/register.do" class="nav-link ">
                  <i class="far fa-circle nav-icon"></i>
                  <p>회원가입</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/user/login.do" class="nav-link ">
                  <i class="far fa-circle nav-icon"></i>
                  <p>로그인</p>
                </a>
              </li>
              </ul>
              </sec:authorize>
              <form id="logoutForm" action="/user/logout.do" method="post" style="display: none;">
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
<input type="hidden" id="user_id" value="<sec:authentication property="principal.id" />">
</form>
<sec:authorize access="isAuthenticated()">
<li class="nav-item">
    <a href="/user/myPage.do" class="nav-link <c:if test="${pageName == 'myPage'}">active</c:if>">
        <i class="far fa-circle nav-icon"></i>
        <p>회원정보 수정</p>
    </a>
</li>
<li class="nav-item">
    <a href="/chart.do" class="nav-link <c:if test="${pageName == 'userChart'}">active</c:if>">
        <i class="far fa-circle nav-icon"></i>
        <p>통계</p>
    </a>
</li>
<li class="nav-item">
    <a href="javascript:void(0);" class="nav-link" onclick="confirmLogout();">
        <i class="far fa-circle nav-icon"></i>
        <p>로그아웃</p>
    </a>
</li>
<li class="nav-item">
    <a href="javascript:void(0);" class="nav-link" onclick="sendMessage();">
        <i class="far fa-circle nav-icon"></i>
        <p>예시 데이터 보내기</p>
    </a>
</li>
</sec:authorize>
            </ul>
          </li>

        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>
  
<!-- 로그아웃 모달 -->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="logoutModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="logoutModalLabel">로그아웃 확인</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                정말 로그아웃하시겠습니까?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" onclick="document.getElementById('logoutForm').submit();">로그아웃</button>
            </div>
        </div>
    </div>
</div>

<script>
let stompClient = null;

function connect() {
    const socket = new SockJS('/stomp'); 
    stompClient = Stomp.over(socket);

    stompClient.connect({}, function (frame) {
        

        const courseIds = JSON.parse('${sessionScope.courseIds}'); 
        

        
        courseIds.forEach(courseId => {
            if (courseId) {
                stompClient.subscribe('/topic/course/'+courseId+'/notifications', function (message) {
                    
                    const data = JSON.parse(message.body);
                    showNotification(data);
                });
            }
        });

       
        stompClient.subscribe('/topic/messages', function (message) {
            const data = JSON.parse(message.body);
            showNotification(data);
        });
    });
}

function connectDM() {
    const socket = new SockJS('/stomp'); 
    stompClient3 = Stomp.over(socket);

    stompClient3.connect({}, function (frame) {
        

        const userId = document.getElementById('user_id').value;
        
            stompClient3.subscribe('/topic/course/'+userId+'/DM', function (message) {
                    
                const data = JSON.parse(message.body);
                
                
                
                showDM(data)
                
             });
    });
}


function showDM(data){
    const DMs = document.getElementById('DMnotification-items');
    const newDM = document.createElement('a');
    newDM.classList.add('dropdown-item');
    newDM.innerHTML = '<div class="media"><img src="/'+data.sender_image+'" alt="User Avatar" class="img-size-50 mr-3 img-circle"><div class="media-body"><h3 class="dropdown-item-title">'
        +data.sender+'<span class="float-right text-sm text-danger"><i class="fas fa-star"></i></span></h3><p class="text-sm">'+data.content+'</p><p class="text-sm text-muted"><i class="far fa-clock mr-1"></i>' 
        +new Date(data.created_at).toLocaleString()+'</p></div></div>'
        
        newDM.onclick = function() {
            const csrfToken = document.querySelector('meta[name="_csrf"]').content;
            const csrfHeader = document.querySelector('meta[name="_csrf_header"]').content
            
            fetch('/DM.do?id='+data.message_id, {
                method: 'DELETE',
                headers: {
                    [csrfHeader]: csrfToken 
                }
            })
            .then(response => {
                if (response.ok) {
                    window.location.href = '/chat.do?id=' + data.course_id+'&messageId='+data.message_id;
                } else {
                    console.error('알림 삭제 실패');
                }
            })
            .catch(error => console.error('Error deleting notification:', error));
        };
   
        
        
        
    DMs.insertBefore(newDM, DMs.firstChild);     
        
    const DMCount = document.getElementById('DMnotification-count');
    DMCount.innerText = parseInt(DMCount.innerText) + 1;
    
    if (parseInt(DMCount.innerText) === 0) {
        DMCount.style.display = 'none';
    } else {
        DMCount.style.display = 'block';  // 필요하면 다시 보이게 할 수 있음
    }
}

function showNotification(data) {
    const notificationItems = document.getElementById('notification-items');
    const newNotification = document.createElement('a');
    newNotification.classList.add('dropdown-item');
    newNotification.innerText = data.message; 

    
    newNotification.onclick = function() {
        const csrfToken = document.querySelector('meta[name="_csrf"]').content;
        const csrfHeader = document.querySelector('meta[name="_csrf_header"]').content
        
        fetch('/notifications?id='+data.course_id+"&message="+encodeURIComponent(data.message), {
            method: 'DELETE',
            headers: {
                [csrfHeader]: csrfToken 
            }
        })
        .then(response => {
            if (response.ok) {
                
                window.location.href = '/course.do?id=' + data.course_id;
            } else {
                console.error('알림 삭제 실패');
            }
        })
        .catch(error => console.error('Error deleting notification:', error));
    };

    notificationItems.insertBefore(newNotification, notificationItems.firstChild);

    
    const notificationCount = document.getElementById('notification-count');
    notificationCount.innerText = parseInt(notificationCount.innerText) + 1;
    
    if (parseInt(notificationCount.innerText) === 0) {
        notificationCount.style.display = 'none';
    } else {
        notificationCount.style.display = 'block';  // 필요하면 다시 보이게 할 수 있음
    }
}

function loadNotifications() {
    fetch('/notifications')
        .then(response => response.json())
        .then(data => {
            data.forEach(notification => {
                showNotification(notification);
            });
        })
        .catch(error => console.error('Error loading notifications:', error));
}

function loadDMs() {
    fetch('/DMs.do')
        .then(response => response.json())
        .then(data => {
            data.forEach(DM => {
                showDM(DM);
            });
        })
        .catch(error => console.error('Error loading DMs:', error));
}


window.onload = function() {
    loadNotifications();
    loadDMs()
    connect();
    connectDM();
};

function sendMessage() {
    const message = { message: "테스트 메시지입니다!" };
    stompClient.send("/app/sendMessage", {}, JSON.stringify(message));
}

    function confirmLogout() {
        
        $('#logoutModal').modal('show');
    }
    
    function deleteAllNotifications() {
        const csrfToken = document.querySelector('meta[name="_csrf"]').content;
        const csrfHeader = document.querySelector('meta[name="_csrf_header"]').content;
        fetch('/allNotifications', {
            method: 'DELETE',
            headers: {
                [csrfHeader]: csrfToken
            }
        })
        .then(response => {
            if (response.ok) {
                // 알림 삭제 후 UI 업데이트
                document.getElementById('notification-items').innerHTML = ''; // UI에서 알림 제거
                document.getElementById('notification-count').innerText = '0'; // 알림 카운트 초기화
                document.getElementById('notification-count').style.display = 'none';
                
            } else {
                console.error('알림 삭제 실패');
            }
        })
        .catch(error => console.error('Error deleting notifications:', error));
    }
    
    function deleteAllDM(){
        const csrfToken = document.querySelector('meta[name="_csrf"]').content;
        const csrfHeader = document.querySelector('meta[name="_csrf_header"]').content;
        fetch('/allDMs', {
            method: 'DELETE',
            headers: {
                [csrfHeader]: csrfToken
            }
        })
        .then(response => {
            if (response.ok) {
                // 알림 삭제 후 UI 업데이트
                document.getElementById('DMnotification-items').innerHTML = ''; // UI에서 알림 제거
                document.getElementById('DMnotification-count').innerText = '0'; // 알림 카운트 초기화
                document.getElementById('DMnotification-count').style.display = 'none';
                
            } else {
                console.error('알림 삭제 실패');
            }
        })
        .catch(error => console.error('Error deleting DMnotifications:', error));
    }
    
    function submitSearchForm(form) {
        // 현재 URL 가져오기
        const currentUrl = window.location.href.split('?')[0]; // 쿼리 파라미터 제거

        // 검색어 가져오기
        const searchQuery = form.search.value;

        // 새로운 URL 생성
        const newUrl = currentUrl + "?search=" + encodeURIComponent(searchQuery);

        
        window.location.href = newUrl;

       
        return false;
    }

</script>


