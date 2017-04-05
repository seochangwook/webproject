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
});
function memoview(memostr){
	alert(memostr);
}
function modalview_deletecourse(){
	//과목취소//
	var cnumber = $('#dnumber').val();
	var stuNumber = $('#stunum').val();
	
	alert('제거할 과목 번호: ' + cnumber + '/' + stuNumber);
}
//Modal Dialog 이벤트//
function memowriteModalsshow(cnumber){
	//hidden필드 추가//
	$('#memocnumber').val(cnumber); //히든값 설정//
	
	$("#memowrite").modal('show'); //다이얼로그를 띄운다.//
}
function deletecourse(coursenumber){
	$('#dnumber').val(coursenumber); //히든값 설정//
	//다이얼로그 호출//
	$("#deletecou").modal('show');
}
function refreshcall(){
	var stunumber = $('#stunum').val();
	
	//ajax call//
	var trans_objeect = 
	{
    	'stuNumber':stunumber,
    }
	
	var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
	
	$.ajax({
		url: "http://localhost:8080/project/myenrolllistajax",
		type: 'POST',
		dataType: 'json',
		data: trans_json,
		contentType: 'application/json',
		mimeType: 'application/json',
		success: function(retVal){
			var checkVal = retVal.check;	
			//테이블을 뿌려준다.//
			var user_array = [];
			//배열적용(ajax컨트롤러에서 HashMap으로 저장한 값을 불러온다.)//
			user_array = retVal.list;
			var row_count = user_array.length;
		 	var total_grade = 0;
		 	
		 	$('#contentview').empty();
		 	
		 	if(row_count >= 1){
				print_str = "<table class='table table-hover'>";
				print_str += "<thead>";
				print_str += "<tr>";
				print_str += "<th>구분</th>";
				print_str += "<th>과목번호</th>";
				print_str += "<th>과목이름</th>";
				print_str += "<th>교수명</th>";
				print_str += "<th>수강시간</th>";
				print_str += "<th>과목학점</th>";
				print_str += "<th>메모사항(동일번호 전부 등록)</th>";
				print_str += "<th>제거(동일번호 전부 취소)</th>";
				print_str += "</tr>";
				print_str += "</thead>";
				
				print_str += "<tbody>";
				//배열 출력(.each를 이용)//
				$.each(user_array, function(index,value) {
					//총 학점을 구하기 위한 계산//
					if((index+1) % 4 ==0){
						total_grade += value.c_grade;
					}
					
					print_str += "<tr>";
	            	print_str += "<td>"+(index+1)+"</td>";
	            	print_str += "<td>"+value.c_number+"</td>";
	            	print_str += "<td>"+value.c_name+"</td>";
	            	print_str += "<td>"+value.pro_name+"</td>";
	            	print_str += "<td>"+value.c_date_time+"</td>";
	            	print_str += "<td>"+value.c_grade+"</td>";
	            	print_str += "<td><button value='"+value.c_memo+"' class='btn btn-primary' onclick='memoview(this.value)'>보기</button> &nbsp&nbsp";
	            	print_str += "<button value='"+value.c_number+"' class='btn btn-success' onclick='memowriteModalsshow(this.value)'>작성</button></td>";
	            	//onclick속성을 이용해서 직접 함수를 호출하고 값으로 현재 button태그에 value값을(pid) 이용한다.//
	            	print_str += "<td><button value='"+value.c_number+"' class='btn btn-danger' onclick='deletecourse(this.value)'>과목취소</button></td>";
	            	print_str += "</tr>";
	            });	
				print_str += "</tbody>";
			}
		 	
		 	else if(row_count == 0){
				print_str = "<table class='table table-hover'>";
				print_str += "<tbody>";
				print_str += "<tr>";
				print_str += "<td><img src='/resources/images/emptypage_image.png' width='400' height='150'></td>";
				print_str += "<td><p>테이블에 데이터가 없습니다</p</td>";
				print_str += "</tr>";
				print_str += "</tbody>";
			}
            
            print_str += "</table>";
            
            print_str += "<div>";
            print_str += "<p>* 총 학점: "+total_grade+"</p>";
            print_str += "</div>";
            
            $('#contentview').append(print_str);
		},
		error: function(retVal, status, er){
			alert("error: "+retVal+" status: "+status+" er:"+er);
		}
	});
}
function modalview_memowrite(){
	var cnumber = $('#memocnumber').val();
	var stuNumber = $('#stunum').val();
	var memostr = $('#memoinput').val();
	
	//alert("메모 등록"+cnumber+"/"+stuNumber+"/"+memostr);
	
	//ajax call//
	var trans_objeect = 
	{
		'memoCnumber':cnumber,
		'stuNumber' : stuNumber,
		'memoStr' : memostr
	}
				
	var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
	
	$.ajax({
		url: "http://localhost:8080/project/memoupdateajax",
		type: 'POST',
		dataType: 'json',
		data: trans_json,
		contentType: 'application/json',
		mimeType: 'application/json',
		success: function(retVal){
			if(retVal.check == 'true'){
				alert('메모등록  및 변경 성공');
				
				//location.reload();
				refreshcall(); //해당 테이블을 다시 호출한다.//
			}
			
			else{
				alert('메모등록  실패');
				
				//location.reload();
				refreshcall();
			}
		},
		error: function(retVal, status, er){
			alert("error: "+retVal+" status: "+status+" er:"+er);
		}
	});
}
function modalview_deletecourse(){
	var delete_coursenumber = $('#dnumber').val();
	var stuNumber = $('#stunum').val();
	
	//ajax call//
	var trans_objeect = 
	{
    	'stuNumber':stuNumber,
    	'deleteCourseNumber':delete_coursenumber
    }
	
	var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
	
	//ajax call
	$.ajax({
		url: "http://localhost:8080/project/deletecourseajax",
		type: 'POST',
		dataType: 'json',
		data: trans_json,
		contentType: 'application/json',
		mimeType: 'application/json',
		success: function(retVal){
			var check = retVal.check;
			
			if(check == 'true'){
				alert('과목 삭제 성공');
				
				refreshcall();
			}
			
			else if(check == 'false'){
				alert('과목 삭제 실패');	
				
				refreshcall();
			}
		},
		error: function(retVal, status, er){
			alert("error: "+retVal+" status: "+status+" er:"+er);
		}
	});
}
function sessionCheck(){
	var getsessionid = $('#sessionid').val();

	if(getsessionid == ''){
		alert('세션이 만료된 페이지 입니다.');
	
		var url = "http://localhost:8080/project/login";
		$(location).attr("href", url);
}
		$(function(){
			//click의 function을 넣은것은 callback이다.(Javascript는 callback구조)//
			$('#btn__info_click').click(function(){
				alert('선택');
				
				var html_str = "<p>소개관련 뷰</p>";
				
				$('#contentview').empty();
				$('#contentview').append(html_str);
			});
			$('#btn__enrolllist_click').click(function(){
				alert('선택');
				
				var html_str = "<p>수강신청 관련 뷰</p>";
				
				$('#contentview').empty();
				$('#contentview').append(html_str);
			});
			$('#btn__myenrolllist_click').click(function(){
				var stunumber = $('#stunum').val();
			
				//ajax call//
				var trans_objeect = 
		    	{
		        	'stuNumber':stunumber,
			    }
				
				var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
				
				$.ajax({
					url: "http://localhost:8080/project/myenrolllistajax",
					type: 'POST',
					dataType: 'json',
					data: trans_json,
					contentType: 'application/json',
					mimeType: 'application/json',
					success: function(retVal){
						var checkVal = retVal.check;	
						//테이블을 뿌려준다.//
						var user_array = [];
						//배열적용(ajax컨트롤러에서 HashMap으로 저장한 값을 불러온다.)//
						user_array = retVal.list;
						var row_count = user_array.length;
					 	var total_grade = 0;
					 	
					 	$('#contentview').empty();
					 	
					 	if(row_count >= 1){
							print_str = "<table class='table table-hover'>";
							print_str += "<thead>";
							print_str += "<tr>";
							print_str += "<th>구분</th>";
							print_str += "<th>과목번호</th>";
							print_str += "<th>과목이름</th>";
							print_str += "<th>교수명</th>";
							print_str += "<th>수강시간</th>";
							print_str += "<th>과목학점</th>";
							print_str += "<th>메모사항(동일번호 전부 등록)</th>";
							print_str += "<th>제거(동일번호 전부 취소)</th>";
							print_str += "</tr>";
							print_str += "</thead>";
							
							print_str += "<tbody>";
							//배열 출력(.each를 이용)//
							$.each(user_array, function(index,value) {
								//총 학점을 구하기 위한 계산//
								if((index+1) % 4 ==0){
									total_grade += value.c_grade;
								}
								
								print_str += "<tr>";
				            	print_str += "<td>"+(index+1)+"</td>";
				            	print_str += "<td>"+value.c_number+"</td>";
				            	print_str += "<td>"+value.c_name+"</td>";
				            	print_str += "<td>"+value.pro_name+"</td>";
				            	print_str += "<td>"+value.c_date_time+"</td>";
				            	print_str += "<td>"+value.c_grade+"</td>";
				            	print_str += "<td><button value='"+value.c_memo+"' class='btn btn-primary' onclick='memoview(this.value)'>보기</button> &nbsp&nbsp";
				            	print_str += "<button value='"+value.c_number+"' class='btn btn-success' onclick='memowriteModalsshow(this.value)'>작성</button></td>";
				            	//onclick속성을 이용해서 직접 함수를 호출하고 값으로 현재 button태그에 value값을(pid) 이용한다.//
				            	print_str += "<td><button value='"+value.c_number+"' class='btn btn-danger' onclick='deletecourse(this.value)'>과목취소</button></td>";
				            	print_str += "</tr>";
				            });	
							print_str += "</tbody>";
						}
					 	
					 	else if(row_count == 0){
							print_str = "<table class='table table-hover'>";
							print_str += "<tbody>";
							print_str += "<tr>";
							print_str += "<td><img src='/resources/images/emptypage_image.png' width='400' height='150'></td>";
							print_str += "<td><p>테이블에 데이터가 없습니다</p</td>";
							print_str += "</tr>";
							print_str += "</tbody>";
						}
		                
		                print_str += "</table>";
		                
		                print_str += "<div>";
		                print_str += "<p>* 총 학점: "+total_grade+"</p>";
		                print_str += "</div>";
		                
		                $('#contentview').append(print_str);
					},
					error: function(retVal, status, er){
						alert("error: "+retVal+" status: "+status+" er:"+er);
					}
				});
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
				
				var html_str = "<div id='contentview'>";
				html_str += "<h3>Home View</h3>";
				html_str += "<p>현재는 홈 뷰 (각 메뉴에 따라 뷰가 변경)</p>";
				html_str += "</div>";
				
				$('#contentview').empty();
				$('#contentview').append(html_str);
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
}
</script>
</head>
<body>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">수강신청</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#" id="btn_home">Home</a></li>
        <li><a href="#" id="btn__enrolllist_click">수강신청</a></li>
        <li><a href="#" id="btn__myenrolllist_click">내 수강정보 확인</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#" id="btn_logout"><span class="glyphicon glyphicon-log-in"></span>&nbsp로그아웃</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-2 sidenav">
      	<h2>나의 정보</h2>
		<div class="card">
  			<img src="resources/images/uploading/${imagefile}" class="img-circle" alt="Cinque Terre" style="width:100%">
  			<h4 id="title"><b>서창욱(${sessionId})</b></h4> 
  			<input type="hidden" id="sessionid" value='${sessionId}'>
  			<div>
    			<p id="#info_age">나이 : ${age}</p> 
    			
    			<p id="#info_dept">학과 : ${major}</p>
    			<p id="#info_grade">학년 : ${year}</p>
    			<p id="#info_birth">생일 : ${birth}</p>
    			<p id="#info_gender">성별 : ${gender}</p>
    			<p id="#info_address">주소 : ${address}</p>
    			<p id="#info_email">이메일 : ${email}</p>
    			<p id="#info_phonenumber">전화번호 : ${phonenumber}</p>
    			<p id="#info_stunumber">학번 : ${stunumber}</p>
    			<input type='hidden' id='stunum' value='${stunumber}'>
    		</div>
    		<div>
    			<button type="button" class="btn btn-info" id="btn_myinfo_update">내 정보 수정</button>
    		</div>
  			<div class="container">
  			</div>
		</div>
    </div>
    <div class="col-sm-8 text-left"> 
      <h1>롯데대학교 수강신청 프로그램</h1>
      <p>개발자 : 백희원, 서창욱, 윤태한, 박선영</p>
      <hr>
      <div id="contentview">
      	<h3>Home View</h3>
      	<p>현재는 홈 뷰 (각 메뉴에 따라 뷰가 변경)</p>
      </div>
    </div>
    <div class="col-sm-2 sidenav" id="sidesubjectname">
      <div class="well">
        <p id="info_sub1">과목소개 - 1</p>
      </div>
      <div class="well">
        <p id="info_sub2">과목소개 - 2</p>
      </div>
    </div>
  </div>
</div>

<footer class="container-fluid text-center">
  <p>LOTTE DATA COMMUNICATION Java Programming B class</p>
</footer>

  <!-- Modal -->
  <div class="modal fade" id="deletecou" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <input type='hidden' id='dnumber' name='dnumber' value=''>
          <h2 class="modal-title">과목 취소</h2>
          <h5>(동일번호의 과목이 모두 취소됩니다.)</h5>
        </div>
        <div class="modal-body">
          	<form>
          		<label for="usr">* 정말로 과목을 취소하시겠습니까?</label>  		
			</form>
        </div>
        <div class="modal-footer">
        	<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        	<button type="button" class="btn btn-default" data-dismiss="modal" id="memowritebtn" onclick="modalview_deletecourse()">과목취소</button>
        </div>
      </div>
    </div>
  </div>
  
  <!-- Modal -->
  <div class="modal fade" id="memowrite" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <input type='hidden' id='memocnumber' name='memocnumber' value=''>
          <h2 class="modal-title">메모 입력</h2>
          <h5>메모할 사항을 입력하세요</h5>
        </div>
        <div class="modal-body">
          	<form>
          		<label for="usr">* 메모를 입력하시오.</label>
				<div class="form-group-name" size="10">
					<input type="text" class="form-control" id="memoinput">
			</form>
        </div>
        <div class="modal-footer">
        	<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        	<button type="button" class="btn btn-default" data-dismiss="modal" id="memowritebtn" onclick="modalview_memowrite()">메모등록</button>
        </div>
      </div>
    </div>
  </div>
  
</body>
</html>