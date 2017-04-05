
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/mainpageviewcss.css" type="text/css"/>
<script type="text/javascript">
$(document).ready(function(){
	sessionCheck(); //세션검사//
	$('#contentview').load('${pageContext.request.contextPath}/view.jsp'); //홈화면
});
		$(function(){
			//click의 function을 넣은것은 callback이다.(Javascript는 callback구조)//
			$('#btn_click').click(function(){
				alert('선택');
				$('#contentview').empty();
				$('#contentview').append(html_str); 
				 
				/*
				var html_str = "<h3>수강신청 주요 일정</h3>";
				html_str += "<p>안내메세지</p>";
				html_str += "<img src='resources/images/notice2.PNG' id='img-notice' width='957' height='281' > ";
				$('#contentview').empty();
				$('#contentview').append(html_str); 
				*/
				
			});
			$('#info_sub1').click(function(){
				alert('선택');
				
				var html_str = "<p>과목소개 1 뷰</p>";
				$('#contentview').empty();
				$('#contentview').append(html_str);
			});
			$('#info_sub2').click(function(){
				alert('선택');
				
				var html_str = "<p>과목소개 2 뷰</p>";
				$('#contentview').empty();
				$('#contentview').append(html_str);
			});
			$('#btn_myinfo_update').click(function(){
				alert("선택");
				
				var html_str = "<p>내 정보 수정 뷰</p>";
				$('#contentview').empty();
				$('#contentview').append(html_str);
			});
			$('#btn_home').click(function(){
				alert("홈으로 돌아가기");
				$('#contentview').empty();
				$('#contentview').load('${pageContext.request.contextPath}/view.jsp');
				//var html_str = "<div id='contentview'>";
				//html_str += "<h3>Home View</h3>";
				//html_str += "<p>현재는 홈 뷰 (각 메뉴에 따라 뷰가 변경)</p>";
				//html_str += "</div>";
				
				
				//$('#contentview').append(html_str);
			});
			$('#btn_logout').click(function(){
				alert("["+$('#sessionid').val() + "] 로그아웃... 이용해주셔서 감사합니다. (로그인 페이지로 이동합니다)");
			
				var sessionid = 'sessionid='+$('#sessionid').val();
				
				//ajax call//
				$.ajax({
					url: "http://localhost:8080/project/logoutajax",
					type: 'POST',
					dataType: 'text',
					data: sessionid,
					success: function(retVal){
						var is_check = retVal;
					
						if(is_check == 'true'){
							//세션종료 성공 시 다시 로그인 페이지로 리다이렉션
							var url = "http://localhost:8080/project/login";
							$(location).attr("href", url);
						}
						
						else if(is_check == 'false'){
							alert('세션종료 실패');	
						}
					},
					error: function(retVal, status, er){
						alert("error: "+retVal+" status: "+status+" er:"+er);
					}
				});
			});
		});
function sessionCheck(){
	var getsessionid = $('#sessionid').val();
	
	if(getsessionid == ''){
		alert('세션이 만료된 페이지 입니다.');
		
		var url = "http://localhost:8080/project/login";
		$(location).attr("href", url);
	}
}
</script>
</head>
<body>

<nav class="navbar navbar-inverse">
    <div class="collapse navbar-collapse" id="myNavbar-top">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#" id="btn_logout"><span class="glyphicon glyphicon-log-in"></span>&nbsp로그아웃</a></li>
      </ul>
    </div>
  </div>
</nav>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <!-- <a class="navbar-brand" href="#">수강신청</a> -->
      <img src="resources/images/uploadimg/luniv.png" id= "img-navbar" > 
    </div>
    <div class="collapse navbar-collapse navbar-right" id="myNavbar">
      <ul class="nav navbar-nav" id="nav-cont">
        <li class="active"><a href="#" id="btn_home">Home</a></li>
        <li><a href="#" id="btn_click">소개</a></li>
        <li><a href="#">과목소개</a></li>
        <li><a href="#">과목신청</a></li>
        <li><a href="#">과목취소</a></li>
        <li><a href="#">메모하기</a></li>
        <li><a href="#">학과 공지사항</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center" id="main-container">    
  <div class="row content">
     <div class="col-sm-2 sidenav">
      <div class="well">
        <p id="info_sub1">과목소개 - 1</p>
      </div>
      <div class="well">
        <p id="info_sub2">과목소개 - 2</p>
      </div>
    </div>
    <div class="col-sm-8 text-left"> 
      <!-- <h1>롯데대학교 수강신청 프로그램</h1> -->
      <img src="resources/images/uploadimg/enroll.png" id="img-maincont"> 
      <p>개발자: 윤태한</p>
      <hr>
      <div id="contentview">
      	<h3>Home View</h3>
      	<p>현재는 홈 뷰 (각 메뉴에 따라 뷰가 변경)</p>
      </div>
    </div>
   <div class="col-sm-2 sidenav">
      	<h2>Profile</h2>
		<div class="card">
  			<img src="resources/images/uploadimg/${imagefile}" class="" alt="Cinque Terre" style="width:100%">
  			<div>
	  			<h4 id="title"><b>서창욱(${sessionId})</b>
	  				<button type="button" class="btn btn-info" id="btn_myinfo_update">
	                <img src="resources/images/settings.png" id="btn_setting"></button>
	  			</h4> <!-- class="img-circle".....ㅎㅎ -->
  			</div>
  			<input type="hidden" id="sessionid" value='${sessionId}'>
  			<div>
    			<p id="info1">나이 : 26살</p> 
    			<p id="info1">학과 : ${major}</p>
    			<p id="info1">학년 : ${year}</p>
    		</div>
    		<!-- 
    		<div>
    			<button type="button" class="btn btn-info" id="btn_myinfo_update">내 정보 수정</button>
    		</div> 
    		-->
  			<div class="container">
  			</div>
		</div>
    </div>
  </div>
</div>

<footer class="container-fluid text-center">
  <p>LOTTE DATA COMMUNICATION Java Programming B class</p>
</footer>
</body>
</html>