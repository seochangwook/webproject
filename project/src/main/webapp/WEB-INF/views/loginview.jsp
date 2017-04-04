<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>login page</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/loginviewcss.css" type="text/css"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="resources/js/secure/rollups/aes.js"></script>

<script type="text/javascript">
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
								
								print_str += "<div class='alert alert-success' id='alert-login'>";
								print_str += "<strong>로그인 성공!!</strong>&nbsp  "+input_id+" 접속을 환영합니다.";
								print_str += "</div>";
								//submit을 만들어준다.//
								print_str += "<form name='TransTest' id='tForm' method='post' action='http://localhost:8080/project/mainpage'>";
								//hidden필드를 이용해서 전달할 값을 설정//

								print_str += "<input type='hidden' name='country' value='"+input_id+"'>";
								print_str += "<div id='btn_group3'>";
								print_str += "<input type='hidden' name='stuId' value='"+input_id+"'>";
								print_str += "<button name='subject' class='btn btn-success' id='btn-goMain' type='submit' value='move'>수강신청 페이지 이동</button>";
								print_str += "</form>";
								print_str += "<button name='subject2' class='btn btn-login' id='btn_go' value='move'>기타 페이지 이동</button></div>";
	
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
							alert("error: "+retVal+" status: "+status+" er:"+er);
						}
					});
				}
			});
			$('[data-toggle="tooltip"]').tooltip(); 
		});
		
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
					url: "http://localhost:8080/testspring/enrollajax",
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
		
		//Modal Dialog 이벤트//
		function modalview_searchid(){
			var stunumber_value = $('#stunumberinput').val();
			var stuname_value = $('#stunameinput').val();
			
			var trans_objeect = 
		    {
		        'stuNumber':stunumber_value,
		        'stuName':''+stuname_value
		    }
			
			var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
			
			//ajax call//
			$.ajax({
					url: "http://localhost:8080/project/idsearchajax",
					type: 'POST',
					dataType: 'json',
					data: trans_json,
					contentType: 'application/json',
					mimeType: 'application/json',
					success: function(retVal){
						var searchid = retVal.id;
						
						if(searchid == ''){
							alert('검색실패. 등록되지 않은 학생입니다.');
						
							$('#stunumberinput').val('');
							$('#stunameinput').val('');
						}
						
						else{
							alert(stuname_value+'님의 아이디는 [' + searchid + '] 입니다.');
							
							$('#stunumberinput').val('');
							$('#stunameinput').val('');
						}
					},
					error: function(retVal, status, er){
						alert("error: "+data+" status: "+status+" er:"+er);
					}
				});
		}
		
		function mailsend(){
			var email_value = $('#stuemail').val();
			var stuid = $('#stuidinput_p').val();
			
			var trans_objeect = 
		    {
		        'stuId':stuid,
		        'stuEmail':''+email_value
		    }
			
			var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
			
			//ajax call//
			$.ajax({
					url: "http://localhost:8080/project/passwordsearchajax",
					type: 'POST',
					dataType: 'json',
					data: trans_json,
					contentType: 'application/json',
					mimeType: 'application/json',
					success: function(retVal){
						var searchpassword = retVal.password;
						var authnumber = retVal.authnumber;
						
						if(searchpassword == ''){
							alert('실페. 등록되지 않은 학생입니다.');
						
							$('#stuemail').val('');
							$('#stuidinput_p').val('');
							
							$('#stuemail').attr("readonly", false);
							$('#stuidinput_p').attr("readonly", false);
							$('#btn_mailsend').attr("disabled", false);
							$('#searchbuttonp').attr("disabled", true);
						}
						
						else{
							alert('적으신 이메일로 메일이 발송되었습니다.');
							
							var print_str = '';
							print_str += "<input type='hidden' id='passwordstu' name='stupassword' value='"+searchpassword+"'>";
							print_str += "<input type='hidden' id='authnumberemail' name='stuauth' value='"+authnumber+"'>";
							
							$('#myModal_passwordsearch').append(print_str); //다이얼로그에 히든값을 저장//
						}
					},
					error: function(retVal, status, er){
						alert("error: "+retVal+" status: "+status+" er:"+er);
					}
				});
		}
		
		//Modal Dialog 이벤트//
		function modalview_decrypt(){
			var auth = $('#authnumber').val();
			var authnum = $('#authnumberemail').val();
			var enpassword = $('#passwordstu').val();
			
			if(auth == authnum){
				//비밀번호 암호화//
				var key = CryptoJS.enc.Hex.parse('000102030405060708090a0b0c0d0e0f');
				var iv = CryptoJS.enc.Hex.parse('101112131415161718191a1b1c1d1e1f');
				var decrypted_password = CryptoJS.AES.decrypt(enpassword, key, { iv: iv });
				
				alert('**인증성공** -> 비밀번호는 ['+decrypted_password.toString(CryptoJS.enc.Utf8)+'] 입니다.');	
				
				$('#passwordstu').val('');
				$('#authnumberemail').val('');
			}
			
			else{
				alert('인증번호가 틀렸습니다. 다시 전송받으세요.');
				
				$('#passwordstu').val('');
				$('#authnumberemail').val('');
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
		    	<button type="button" class="btn btn-login " id="btn_search_id" data-toggle="modal" data-target="#myModal_idsearch">아이디 찾기</button>
	  			<button type="button" class="btn btn-warning btn-login" id="btn_search_password" data-toggle="modal" data-target="#myModal_passwordsearch">비밀번호 찾기</button>
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
          <h4 class="modal-title" id="join-title"><b>회원가입</b></h4>
        </div>
        <div class="modal-body">
          		<form>
          		<div>
	          		<div id="form-group-name" size="10">
						<label for="name">* 이름: </label>
						<input type="text" class="form-control form-join" id="name">
		    		</div>
		    		<div id="form-group-student-number" size="10">
		    			<label for="num">* 학번: </label>
						<input type="text" class="form-control form-join" id="num">
		    		</div>
	    		</div>
  				<div id="dept">
  				<br>
	    		<label for="job">* 학과: </label>
  					<select class="form-control" id="sel1">
  						<option value="학과선택">학과선택</option>
  						<option value="컴퓨터공학과">컴퓨터공학과</option>
  						<option value="경영학과">경영학과</option>
        				<option value="문헌정보학과">문헌정보학과</option>
        				<option value="정보보호학과">정보보호학과</option>
        				<option value="생명공학과">생명공학과</option>
        				<option value="멀티미디어학과">멀티미디어학과</option>
        				<option value="간호학과">간호학과</option>
        				<option value="경제학과">경제학과</option>
        				<option value="영어영문학과">영어영문학과</option>
        				<option value="일어일문학과">일어일문학과</option>
        				<option value="중어중문학과">중어중문학과</option>
        				<option value="독어독문학과">독어독문학과</option>
        				<option value="불어불문학과">불어불문학과</option>
        				<option value="유아교육학과">유아교육학과</option>
        				<option value="과학교육과">과학교육과</option>
        				<option value="컴퓨터교육과">컴퓨터교육과</option>
        				<option value="심리학과">심리학과</option>
        				<option value="범죄심리학과">범죄심리학과</option>
        				<option value="정치외교학과">정치외교학과</option>
        				<option value="행정학과">행정학과</option>
      				</select>
  				</div>
  				<br>
  				<div>
	  				<label for="usr">* 아이디: </label>
					<div class="form-group-name" size="10">
						<input type="text" class="form-control form-join" id="usrId">
						<button type="button" class="btn btn-default" id="confirm" >중복확인</button>
		    		</div>
	    		</div>
	    		<br>
	    		<div>
		    		<div class="form-group-passowrd" id="pwd">
		    			<label for="pwd">* 비밀번호: </label>
			    		<input type="password" data-toggle="tooltip" title="비밀번호 입력" class="form-control form-join3" placeholder="특수문자/대소문자 표기">
			    	</div>
			    	<div class="form-group-passowrd-confirm" id="pwd-conf">
		    			<label for="pwd-conf" >* 비밀번호 확인: </label>
			    		<input type="password" data-toggle="tooltip" title="비밀번호 입력" class="form-control form-join3"  placeholder="특수문자/대소문자 표기">
		    		</div>
		    		<div id="button-pwd">
		    			<br>
		    			<button type="button" class="btn btn-default" id="btn-password" >비밀번호 확인</button>
		    		</div>
	    		</div>
	    		<br>
	    		<div id="email">
	    		<label for="email">* 이메일: </label>
	    		<div class="input-group">
    				<span class="input-group-addon" ><i class="glyphicon glyphicon-user"></i></span>
    				<input  type="text" class="form-control" placeholder="Email">
  				</div>
  				</div>
  				<br>
  				<label for="sex">* 성별: </label>
  				<div>
  					<div class="radio">
  						<label id="radio"><input type="radio" name="optradio" value="남" >남</label>
  						<label><input type="radio" name="optradio" value="여">여</label>
					</div>
  				</div>
  				<br>
  				<div>
  					<label for="bdate">* 생년월일: </label>
	  				<div class="form-group-bdate">
						<input type="date" class="form-control form-join" name="bday">
						<!-- <input type="submit" class="btn btn-default" class="form-control"> -->
					</div>
				</div>
  				<br>
  				<div>
  					<label for="address">* 주소: </label>
  					<input type="text" class="form-control" id="address" placeholder="주소를 입력하시오">
  				</div>
  				<br>
  				<label for="phone">* 전화번호: </label>
  				<div class="form-group">
                    <div>
	                    <div class="pnum">
	                        <input type="tel" name="phone" class="form-control form-join2" value="" size="3" maxlength="3" required="required" title="">
	                    </div>
	                    <p class="pnum2">- </p>
	                    <div class="pnum">
	                        <input type="tel" name="phone" class="form-control form-join2" value="" size="4" maxlength="4" required="required" title="">
	                    </div>
	                    <p class="pnum2"> - </p>
	                     <div class="pnum">
	                        <input type="tel" name="phone" class="form-control form-join2" value="" size="4" maxlength="4" required="required" title="">
	                     </div>
                     </div>
                </div>
                <br>
                <div id="photo">
               		<label for="photo">* 사진: </label>
		  			<input type="file" class="btn btn-default form-join" id="uploadfile" placeholder = "파일이름은 영문만 가능합니다."/>
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
  
  <!-- Modal -->
  <div class="modal fade" id="myModal_idsearch" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h2 class="modal-title">아이디 찾기</h2>
          <h5>학번과 이름으로 검색합니다.</h5>
        </div>
        <div class="modal-body">
          	<form>
          		<label for="usr">* 학번을 입력하시오.</label>
				<div class="form-group-name" size="10">
					<input type="text" class="form-control" id="stunumberinput">
	    		</div>
	    		<label for="pwd">* 이름을 입력하시오.</label>
	    		<div class="form-group-passowrd">
	      			<input type="text" class="form-control" id="stunameinput">
	    		</div>
			</form>
        </div>
        <div class="modal-footer">
        	<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        	<button type="button" class="btn btn-default" data-dismiss="modal" id="searchbutton" onclick="modalview_searchid()">검색</button>
        </div>
      </div>
    </div>
  </div>
  
  <!-- Modal -->
  <div class="modal fade" id="myModal_passwordsearch" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h2 class="modal-title">비밀번호 찾기</h2>
          <h5>인증번호를 전송받을 메일주소와 아이디를 입력하시오.</h5>
        </div>
        <div class="modal-body">
          	<form>
          		<label for="usr">* 아이디를 입력하시오.</label>
				<div class="form-group-name" size="10">
					<input type="text" class="form-control" id="stuidinput_p">
	    		</div>
	    		<label for="email">* 전송할 이메일을 입력하시오.</label>
	    		<div class="input-group">
    				<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
    				<input type="text" class="form-control" id="stuemail" placeholder="Email">
  				</div>
  				<br>
  				<div class="mail-button">
    				<button type="button" class="btn btn-lg btn-block btn-login" id="btn_mailsend" onclick="mailsend()">인증번호 보내기</button>
  				</div>
  				<br><hr><br>
	    		<label for="pwd">* 메일로 전송받은 인증번호를 입력하시오.</label>
	    		<div class="form-group-passowrd">
	      			<input type="text" class="form-control" id="authnumber">
	    		</div>
			</form>
        </div>
        <div class="modal-footer">
        	<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        	<button type="button" class="btn btn-default" data-dismiss="modal" id="searchbuttonp" onclick="modalview_decrypt()">검색</button>
        </div>
      </div>
    </div>
  </div>
</body>
</html>