<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/font-awesome.min.css">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/quiz.css">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.2/css/all.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js" />
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js" />


<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
	integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
	integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
	crossorigin="anonymous"></script>


<style>
        .icon-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .icon {
            width: 50px;
            height: 50px;
            background-color: #007bff;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .icon:hover {
            background-color: #0056b3;
        }
    </style>	



</head>
<body>
	<h1>Hello, world!</h1>
	<button class="btn btn-primary">ksks</button>

	<div class="dropdown">
		<button class="btn btn-secondary dropdown-toggle" type="button"
			data-bs-toggle="dropdown" aria-expanded="false">Dropdown
			button</button>
		<ul class="dropdown-menu">
			<li><a class="dropdown-item" href="#">Action</a></li>
			<li><a class="dropdown-item" href="#">Another action</a></li>
			<li><a class="dropdown-item" href="#">Something else here</a></li>
		</ul>
	</div>

	<div class="wrapper">
		<div class="wrap" id="q1">
			<div class="text-center pb-4">
				<div class="h5 font-weight-bold">
					<span id="number"> </span>1 of 3
				</div>
			</div>
			<div class="h4 font-weight-bold">1. Who is the Prime Minister
				of India?</div>
			<div class="pt-4">
				<form>
					<label class="options">Rahul Gandhi <input type="radio"
						name="radio"> <span class="checkmark"></span>
					</label> <label class="options">Indira Gandhi <input type="radio"
						name="radio"> <span class="checkmark"></span>
					</label> <label class="options">Narendra Modi <input type="radio"
						name="radio" id="rd" checked> <span class="checkmark"></span>
					</label> <label class="options">Ram Nath Kovind <input type="radio"
						name="radio"> <span class="checkmark"></span>
					</label>
				</form>
			</div>
			<div class="d-flex justify-content-end pt-2">
				<button class="btn btn-primary" id="next1">
					Next <span class="fas fa-arrow-right"></span>
				</button>
			</div>
		</div>
		<div class="wrap" id="q2">
			<div class="text-center pb-4">
				<div class="h5 font-weight-bold">
					<span id="number"> </span>2 of 3
				</div>
			</div>
			<div class="h4 font-weight-bold">2. IPV4 stand's for?</div>
			<div class="pt-4">
				<form>
					<label class="options">Internet Protocol <input
						type="radio" name="radio"> <span class="checkmark"></span>
					</label> <label class="options">Intranet Protocol <input
						type="radio" name="radio" checked> <span class="checkmark"></span>
					</label> <label class="options">internet Protocol <input
						type="radio" name="radio" id="rd"> <span class="checkmark"></span>
					</label> <label class="options">None of the above <input
						type="radio" name="radio"> <span class="checkmark"></span>
					</label>
				</form>
			</div>
			<div class="d-flex justify-content-end pt-2">
				<button class="btn btn-primary mx-3" id="back1">
					<span class="fas fa-arrow-left pr-1"></span>Previous
				</button>
				<button class="btn btn-primary" id="next2">
					Next <span class="fas fa-arrow-right"></span>
				</button>
			</div>
		</div>
		<div class="wrap" id="q3">
			<div class="text-center pb-4">
				<div class="h5 font-weight-bold">
					<span id="number"> </span>3 of 3
				</div>
			</div>
			<div class="h4 font-weight-bold">3. What is the full form of
				CSS?</div>
			<div class="pt-4">
				<form>
					<label class="options">Clarity Style Sheets <input
						type="radio" name="radio"> <span class="checkmark"></span>
					</label> <label class="options">Cascading Style Sheets <input
						type="radio" name="radio"> <span class="checkmark"></span>
					</label> <label class="options">Confirm Style sheets <input
						type="radio" name="radio" id="rd" checked> <span
						class="checkmark"></span>
					</label> <label class="options">Canvas Style Sheets <input
						type="radio" name="radio"> <span class="checkmark"></span>
					</label>
				</form>
			</div>
			<div class="d-flex justify-content-end pt-2">
				<button class="btn btn-primary mx-3" id="back2">
					<span class="fas fa-arrow-left pr-2"></span>Previous
				</button>
				<button class="btn btn-primary" id="next3">Submit</button>
			</div>
		</div>
	</div>




	<script>
	
	const questions = [
	    { text: "Who is the Prime Minister of India?", options: ["Rahul Gandhi", "Indira Gandhi", "Narendra Modi", "Ram Nath Kovind"] },
	    { text: "IPV4 stands for?", options: ["Internet Protocol", "Intranet Protocol", "internet Protocol", "None of the above"] },
	    { text: "What is the full form of CSS?", options: ["Clarity Style Sheets", "Cascading Style Sheets", "Confirm Style Sheets", "Canvas Style Sheets"] }
	    // 더 많은 문제 추가 가능
	];
	
  var q1 = document.getElementById("q1");
  var q2 = document.getElementById("q2");
  var q3 = document.getElementById("q3");

  var next1 = document.getElementById('next1')
  var back1 = document.getElementById('back1')
  var next2 = document.getElementById('next2')
  var back2 = document.getElementById('back2')
  document.addEventListener('DOMContentLoaded', function () {
  let query = window.matchMedia("(max-width: 767px)");
  if (query.matches) {
  next1.onclick = function () {
  q1.style.left = "-650px";
  q2.style.left = "15px";
  }
  back1.onclick = function () {
  q1.style.left = "15px";
  q2.style.left = "650px";
  }
  back2.onclick = function () {
  q2.style.left = "15px";
  q3.style.left = "650px";
  }
  next2.onclick = function () {
  q2.style.left = "-650px";
  q3.style.left = "15px";
  }
  }
  else {
  next1.onclick = function () {
  q1.style.left = "-650px";
  q2.style.left = "50px";
  }
  back1.onclick = function () {
  q1.style.left = "50px";
  q2.style.left = "650px";
  }
  back2.onclick = function () {
  q2.style.left = "50px";
  q3.style.left = "650px";
  }
  next2.onclick = function () {
  q2.style.left = "-650px";
  q3.style.left = "50px";
  }
  }
  });


  function uncheck() {
  var rad = document.getElementById('rd')
  rad.removeAttribute('checked')
  }

  
  </script>

</body>
</html>

<%--  <jsp:forward page="/egovSampleList.do"/> --%>