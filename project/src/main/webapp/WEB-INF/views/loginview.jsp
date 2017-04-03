<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>login page</title>
<!-- Bootstrap CDN -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="resources/js/secure/rollups/aes.js"></script>
<link rel="stylesheet" href="resources/css/loginviewcss.css" type="text/css"/>

<script>
		$(function(){
			//click의 function을 넣은것은 callback이다.(Javascript는 callback구조)//
			$('#btn_login').click(function(){
				var input_id = $('#idinput').val();
				var input_password = $('#passwordinput').val();
				
				if(input_id == '' || input_password == ''){
					alert('아이디나 비밀번호를 입력하시오.');
				}
				
				else{
					//비밀번호 암호화//
					var key = CryptoJS.enc.Hex.parse('000102030405060708090a0b0c0d0e0f');
					var iv = CryptoJS.enc.Hex.parse('101112131415161718191a1b1c1d1e1f');
					var encrypted_password = CryptoJS.AES.encrypt(input_password, key, { iv: iv });
					
					//ajax call//
					var trans_objeect = 
			    	{
			        	'userId':input_id,
				        'userPassword':''+encrypted_password
				    }
					
					var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
					
					$.ajax({
						url: "http://localhost:8080/project/loginajax",
						type: 'POST',
						dataType: 'json',
						data: trans_json,
						contentType: 'application/json',
						mimeType: 'application/json',
						success: function(retVal){
							var is_check = retVal.check;
				
							if(is_check == "true"){
								alert(input_id+" 로그인 성공!! 환영합니다.");
								
								$('#btn_group').empty();
								$('#btn_group2').empty();

								//input = text를 읽기모드로 전환//
								$('#idinput').attr("readonly", true);
								$('#passwordinput').attr("readonly", true);
								
								var print_str = "";
								
								print_str += "<div class='alert alert-success'>";
								print_str += "<strong>로그인 성공!!</strong>&nbsp  "+input_id+" 접속을 환영합니다.";
								print_str += "</div>";
								//submit을 만들어준다.//
								print_str += "<form name='TransTest' id='tForm' method='post' action='http://localhost:8080/project/mainpage'>";
								//hidden필드를 이용해서 전달할 값을 설정//
								print_str += "<input type='hidden' name='country' value='"+input_id+"'>";
								print_str += "<button name='subject' class='btn btn-success' type='submit' value='move'>수강신청 페이지 이동</button>";
								
								$('#btn_group').append(print_str); //설정한 내용들을 다시 뷰에 보여줌//
							}
							
							else{
								alert("아이디나 비밀번호가 틀립니다. 다시 확인해주세요.");
								
								var htmltext = $('#myModal').html(); //다시 나타내기 위해서 html코드를 가져온다.
								
								//다시 다이얼로그를 나타낸다.//
								$('#myModal').empty();
								$('#myModal').append(htmltext); 
							}
						},
						error: function(retVal, status, er){
							alert("error: "+data+" status: "+status+" er:"+er);
						}
					});
				}
			});
			$('#btn_search_id').click(function(){
				alert("아이디 찾기");
			});
			$('[data-toggle="tooltip"]').tooltip(); 
		});
		
		function login_user(){
			alert('Succcess Login...');
		}
		
		//Modal Dialog 이벤트//
		function modalview(){
			var id_value = $('#id').val();
			var pwd_value = $('#pwd').val();
			
			//비밀번호 암호화//
			var key = CryptoJS.enc.Hex.parse('000102030405060708090a0b0c0d0e0f');
			var iv = CryptoJS.enc.Hex.parse('101112131415161718191a1b1c1d1e1f');
			var encrypted_password = CryptoJS.AES.encrypt(pwd_value, key, { iv: iv });
			
			var email_value = $('#email').val();
			var sex_value = $('input[type=radio][name=optradio]:checked').val(); //라디오 버튼 선택값 가져오기//
			var like_values = []; //배열로 체크된 값들을 가져올 저장소 생성//
			//체크박스의 선택된 값은 each()을 이용해서 배열 형태로 반환//
			$('input[name=chklist]:checked').each(function(){
				like_values.push($(this).val());
			});
			var address_value = $('#adress').val();
			//select태그로 선택된 값 가져오기//
			var jobtag = document.getElementById("sel1");
			var job_value = jobtag.options[jobtag.selectedIndex].value;
			var introcomment = $('#comment').val();
			
			//alert(id_value+'/'+pwd_value+'/'+email_value+'/'+sex_value+'/'+like_values+'/'+address_value+'/'+job_value+'/'+introcomment);
			
			//ajax call을 통한 서버저장//
			if(id_value == '' || pwd_value == ''){
				alert('아이디 또는 비밀번호를 입력하세요.');
				
				var htmltext = $('#myModal').html(); //다시 나타내기 위해서 html코드를 가져온다.
				
				//다시 다이얼로그를 나타낸다.//
				$('#myModal').empty();
				$('#myModal').append(htmltext); 
			}
			
			else{
				var trans_objeect = 
			    {
			        'userId':id_value,
			        'userPassword':''+encrypted_password,
			        'userEmail':email_value,
			        'userSex':sex_value,
			        'userLikes':like_values,
			        'userAddress':address_value,
			        'userJob':job_value,
			        'userIntro':introcomment
			    }
				
				var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
				
				$.ajax({
					url: "http://localhost:8080/testspring/userinfo_post",
					type: 'POST',
					dataType: 'json',
					data: trans_json,
					contentType: 'application/json',
					mimeType: 'application/json',
					success: function(retVal){
						var is_check = retVal.ischeck;
						
						if(is_check == "true"){
							alert(id_value+" 유저 등록성공!!");
							
							var htmltext = $('#myModal').html(); //다시 나타내기 위해서 html코드를 가져온다.
							
							//다시 다이얼로그를 나타낸다.//
							$('#myModal').empty();
							$('#myModal').append(htmltext); 
						}
						
						else{
							alert("이미 존재하는 아이디입니다.");
							
							var htmltext = $('#myModal').html(); //다시 나타내기 위해서 html코드를 가져온다.
							
							//다시 다이얼로그를 나타낸다.//
							$('#myModal').empty();
							$('#myModal').append(htmltext); 
						}
					},
					error: function(retVal, status, er){
						alert("error: "+data+" status: "+status+" er:"+er);
					}
				});
			}
		}
</script>

</head>
<body style="background-image:url('resources/images/lotteWorldTower.png')">
<div class="login-page" >
	<div id = "login-cont">
		<h2 id = "login-title">롯데대학교 수강신청 프로그램</h2>
		<p class= "login-lab">아이디와 비밀번호를 입력하시오.</p>
		<form>
			<div class="form-group">
				<label for="usr" class= "login-lab">* ID:</label>
				<input type="text" class="form-control" id="idinput">
		    </div>
		    <div class="form-group">
		    	<label for="pwd" class= "login-lab">* Password:</label>
		      	<input type="password" data-toggle="tooltip" title="비밀번호 입력" class="form-control" id="passwordinput" placeholder="특수문자/대소문자 표기">
		    </div>
		    <div id="btn_group">
		      	<button type="button" class="btn btn-lg btn-block btn-login" id="btn_login">로그인</button>
		  	  	<button type="button" class="btn btn-lg btn-block btn-login" id="btn_enroll" data-toggle="modal" data-target="#myModal">회원가입</button>
		    </div>
		    <div id="btn_group2">
		    	<button type="button" class="btn btn-login" id="btn_search_id">아이디 찾기</button>
	  			<button type="button" class="btn btn-warning btn-login" id="btn_search_password">비밀번호 찾기</button>
	  		</div>
		</form>
	</div>
</div>

<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">회원가입</h4>
        </div>
        <div class="modal-body">
          	<form>
          		<label for="usr">* 아이디를 입력하시오.</label>
				<div class="form-group-name" size="10">
					<input type="text" class="form-control" id="id">
	    		</div>
	    		<label for="pwd">* 비밀번호를 입력하시오.</label>
	    		<div class="form-group-passowrd">
	      			<input type="password" data-toggle="tooltip" title="비밀번호 입력" class="form-control" id="pwd" placeholder="특수문자/대소문자 표기">
	    		</div>
	    		<br>
	    		<label for="email">* 이메일을 입력하시오.</label>
	    		<div class="input-group">
    				<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
    				<input id="email" type="text" class="form-control" id="email" placeholder="Email">
  				</div>
  				<br>
  				<label for="sex">* 성별을 선택하시오.</label>
  				<div>
  					<div class="radio">
  						<label><input type="radio" name="optradio" value="남">남</label>
					</div>
					<div class="radio">
  						<label><input type="radio" name="optradio" value="여">여</label>
					</div>
  				</div>
  				<label for="like">* 선호하는 것을 선택하시오.</label>
  				<div>
	  				<label class="checkbox-inline">
	      				<input type="checkbox" value="C언어" name="chklist">C언어
	    			</label>
	    			<label class="checkbox-inline">
	      				<input type="checkbox" value="Java Programming" name="chklist">Java Programming
	    			</label>
	    			<label class="checkbox-inline">
	     				 <input type="checkbox" value="JavaScript" name="chklist">JavaScript
	    			</label>
  				</div>
  				<br>
  				<label for="address">* 주소를 입력하시오.</label>
  				<div>
	      			<input type="text" id="adress" placeholder="주소를 입력하시오">
  				</div>
  				<br>
  				<label for="job">* 현재 직업군을 선택하세요.</label>
  				<div>
  					<select class="form-control" id="sel1">
  						<option value="직업선택">직업선택</option>
        				<option value="학생">학생</option>
        				<option value="주부">주부</option>
        				<option value="회사원">회사원</option>
        				<option value="무직"n>무직</option>
      				</select>
  				</div>
  				<br>
  				<label for="intro">* 간단한 자기소개를 입력하세요.</label>
  				<div>
  					<textarea class="form-control" rows="5" id="comment"></textarea>
  				</div>
			</form>
        </div>
        <div class="modal-footer">
        	<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        	<button type="button" class="btn btn-default" data-dismiss="modal" id="enrollbutton" onclick="modalview()">등록</button>
        </div>
      </div>
    </div>
  </div>
</body>
</html>