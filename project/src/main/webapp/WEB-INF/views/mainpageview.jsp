<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<link rel="stylesheet" href="resources/css/progressbarcss.css" type="text/css"/>


<script type="text/javascript">
$(document).ready(function(){
   	sessionCheck(); //세션검사//
   $('#contentview').load('${pageContext.request.contextPath}/notice.jsp'); //홈화면
   sidebarrefresh();
});
function memoview(memostr){
   //alert(memostr);
   
   var msg = memostr;
	
	$('#msgbody').empty();
	$('#msgbody').append("<p>"+msg+"</p>");
	$('#msgModal').modal('show');
}
function modalview_deletecourse(){
   //과목취소//
   var cnumber = $('#dnumber').val();
   var stuNumber = $('#stunum').val();
   
   //alert('제거할 과목 번호: ' + cnumber + '/' + stuNumber);
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
function sidebarrefresh(){
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
	      beforeSend:function(){
              $('.wrap-loading').removeClass('display-none');
          },
          complete:function(){
              $('.wrap-loading').addClass('display-none');
          },
	      success: function(retVal){
	         var checkVal = retVal.check;   
	         //테이블을 뿌려준다.//
	         var user_array = [];
	         //배열적용(ajax컨트롤러에서 HashMap으로 저장한 값을 불러온다.)//
	         user_array = retVal.list;
	         var row_count = user_array.length;
	         var printStr = '';
	          
	          $('#subjectlist').empty();
	          var tempName="";
	          var tempMemo="";
	          var tempDate="";
	          var strArray;	          
	          var tempDay="";
	          var tempTime="";
	          var idx=0;
	          
	          if(row_count > 0){
	        	  $.each(user_array, function(index,value) {
	                	 if((index+1) % 4 == 0){
	                		 strArray = value.c_date_time.split("|");
	                		 if(idx == 3){                    			
	                			 tempDate+=strArray[1]+"교시";
	                		 }
	                		printStr += "<div class='well'>";     
	               	  	printStr += "<p id='info_sub1' style='font-size:14px;color:#0366d6'><b>"+value.c_name+"</b></p>";
	               	  	printStr += "<hr><p style='text-align:right;font-size:12px;color:#586069 '>"+value.c_memo+"</p>";
	               	  	printStr += "<hr><p style='text-align:right;font-size:11px;color:#586069'>"+tempDate+"</p>";
	               	  	printStr += "</div>";
	 	          		     idx=0;
	                	 }
	                	 else{
	                		 strArray = value.c_date_time.split("|");
	                		 if(idx == 0){                    			
	          	          		tempDate=strArray[0] + " " + strArray[1] + "교시";
	                		 }
	                		 else if(idx==2){
	     	          			tempDate+="<br>";
	     		          		tempDate+=strArray[0] + " " + strArray[1] + "교시";
	     	          		 }
	                		 else{
	     	          			tempDate+=strArray[1]+"교시";
	     	          		 }
	    	          		 idx++;
	                	 }
	                	 
	          	});       
	          }
	          
	          else if(row_count == 0){
	        	  printStr += "<div class='well'>";     
             	  	printStr += "<p id='info_sub1' style='font-size:14px;color:#586069; margin:0px'><b>수강내역이 없습니다.</b></p>";
             	  	printStr += "</div>";
	          }
	          
	          	          
	          $('#subjectlist').append(printStr);
	      },
	      error: function(retVal, status, er){
	    	  alert("세션이 만료되었습니다.");
	      }
	   });
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
      beforeSend:function(){
          $('.wrap-loading').removeClass('display-none');
      },
      complete:function(){
          $('.wrap-loading').addClass('display-none');
      },
      success: function(retVal){
         var checkVal = retVal.check;   
         //테이블을 뿌려준다.//
         var user_array = [];
         //배열적용(ajax컨트롤러에서 HashMap으로 저장한 값을 불러온다.)//
         user_array = retVal.list;
         var row_count = user_array.length;
          var total_grade = 0;
          var subjectcount = 0;
          
          $('#contentview').empty();
          
          if(row_count >= 1){
        	print_str = "<div style='width:100%; height:700px; overflow:hidden'>"; //스크롤바//
            print_str = "<table class='table table-hover'>";
            print_str += "<thead>";
            print_str += "<tr>";
            print_str += "<th class='enroll-table'>구분</th>";
            print_str += "<th class='enroll-table'>과목번호</th>";
            print_str += "<th class='enroll-table'>과목이름</th>";
            print_str += "<th class='enroll-table'>교수명</th>";
            print_str += "<th class='enroll-table'>수강시간</th>";
            print_str += "<th class='enroll-table'>과목학점</th>";
            print_str += "<th class='enroll-table'>메모사항</th>";
            print_str += "<th class='enroll-table'>제거</th>";
            print_str += "</tr>";
            print_str += "</thead>";
            
            print_str += "<tbody>";
            //배열 출력(.each를 이용)//
            var total_grade=0;
            var tempNumber="";
            var tempName="";
            var tempGrade="";
            var tempMemo="";
            var tempPName="";
            var tempDate="";
            var tempDay="";
            var tempTime="";
            var strArray;
            var idx=0;
            var cnt=1;
            $.each(user_array, function(index,value) {
           	 if((index+1) % 4 == 0){
           		 strArray = value.c_date_time.split("|");
           		 if(idx == 3){                    			
           			 tempDate+=strArray[1]+"교시";
           		 }
                    total_grade += value.c_grade;
                    subjectcount += 1;
                    print_str += "<tr>";
                    print_str += "<td class='tb-enroll-content'>"+(cnt)+"</td>";
                    print_str += "<td class='tb-enroll-content'>"+value.c_number+"</td>";
                    print_str += "<td>"+value.c_name+"</td>";
                    print_str += "<td class='tb-enroll-content'>"+value.pro_name+"</td>";
                    print_str += "<td class='tb-enroll-content'>"+tempDate+"</td>";
                    print_str += "<td class='tb-enroll-content'>"+value.c_grade+"</td>";
                    print_str += "<td class='tb-enroll-content'><button value='"+value.c_memo+"' class='btn btn-primary' onclick='memoview(this.value)'>보기</button> &nbsp&nbsp";
                    print_str += "<button value='"+value.c_number+"' class='btn btn-success' onclick='memowriteModalsshow(this.value)'>작성</button></td>";
                    //onclick속성을 이용해서 직접 함수를 호출하고 값으로 현재 button태그에 value값을(pid) 이용한다.//
                    print_str += "<td class='tb-enroll-content'><button value='"+value.c_number+"' class='btn btn-danger' onclick='deletecourse(this.value)'>과목취소</button></td>";
                    print_str += "</tr>";
                    print_str += "</tbody>";	          			  
          			 cnt++;
          		     idx=0;
           	 }
           	 else{
           		 strArray = value.c_date_time.split("|");
           		 if(idx == 0){                    			
     	          		tempDate=strArray[0] + " " + strArray[1] + "교시";
           		 }
           		 else if(idx==2){
	          			tempDate+="<br>";
		          		tempDate+=strArray[0] + " " + strArray[1] + "교시";
	          		 }
           		 else{
	          			tempDate+=strArray[1]+"교시";
	          		 }
	          		 idx++;
           	 }
           	 
     });
         }
          
          else if(row_count == 0){
            print_str = "<table class='table table-hover'>";
            print_str += "<tbody>";
            print_str += "<tr>";
            //print_str += "<td><img src='resources/images/emptypage_image.png' width='400' height='150'></td>";
            print_str += "<td><p style='text-align: center; font-size: 17px; font-style: bold;'>수강내역이 없습니다.</p</td>";
            print_str += "</tr>";
            print_str += "</tbody>";
         }
            
            print_str += "</table>";
            print_str += "</div>";
            
            print_str += "<div>";
            print_str += "<p>* 총 학점: "+total_grade+"</p>";
            print_str += "</div>";
            print_str += "<div>";
            print_str += "<p>* 총 신청과목 수: "+subjectcount+"</p>";
            print_str += "</div>";
            
            $('#contentview').append(print_str);
            
            sidebarrefresh();
      },
      error: function(retVal, status, er){
         alert("error: "+retVal+" status: "+status+" er:"+er);
      }
   });
}
///////////////////////////////////////창욱수정(선택관련 리플래시)//////////////////////////////////////////////
function refreshselectcourse(deptno){
	var deptno = deptno;
    
    var trans_objeect = 
    {
        'deptno':deptno,
    }
    
    var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
    
    $.ajax({
        url: "http://localhost:8080/project/courselistajax",
        type: 'POST',
        dataType: 'json',
        data: trans_json,
        contentType: 'application/json',
        mimeType: 'application/json',
        beforeSend:function(){
            $('.wrap-loading').removeClass('display-none');
        },
        complete:function(){
            $('.wrap-loading').addClass('display-none');
        },
        success: function(retVal){
           var checkVal = retVal.check;   
           var user_array = [];
           //배열적용(ajax컨트롤러에서 HashMap으로 저장한 값을 불러온다.)//
           user_array = retVal.list;
           var row_count = user_array.length;
  
           $('#contentview').empty(); //화면을 초기화//
           
           var print_str = '';
           
           //select 박스 생성//
           print_str += "<p>검색하고자 하는 학과를 선택하시오.  </p>";
           print_str += "<div>"
           print_str += "<select class='form-control' id='sel1' onchange='changeSelect()'>";
           print_str += "<option value='학과선택'>학과선택</option>";
           print_str += "<option value='1'>컴퓨터공학과</option>";
           print_str += "<option value='2'>경영학과</option>";
           print_str += "<option value='3'>문헌정보학과</option>";
           print_str += "<option value='4'>정보보호학과</option>";
           print_str += "<option value='5'>생명공학과</option>";
           print_str += "<option value='6'>멀티미디어학과</option>";
           print_str += "<option value='7'>간호학과</option>";
           print_str += "<option value='8'>경제학과</option>";
           print_str += "<option value='9'>영어영문학과</option>";
           print_str += "<option value='10'>일어일문학과</option>";
           print_str += "<option value='11'>중어중문학과</option>";
           print_str += "<option value='12'>독어독문학과</option>";
           print_str += "<option value='13'>불어불문학과</option>";
           print_str += "<option value='14'>유아교육학과</option>";
           print_str += "<option value='15'>과학교육과</option>";
           print_str += "<option value='16'>컴퓨터교육과</option>";
           print_str += "<option value='17'>심리학과</option>";
           print_str += "<option value='18'>범죄심리학과</option>";
           print_str += "<option value='19'>정치외교학과</option>";
           print_str += "<option value='20'>행정학과</option>";
           print_str += "</select>";
           print_str += "</div>";
           
           print_str += "<div><hr></div>";
           
           $('#contentview').append(print_str); //증간적용//
           
           if(row_count >= 1){
        	   print_str = "<div style='width:100%; height:700px; overflow:hidden'>"; //스크롤바//
               print_str += "<table class='table table-hover'>";
               print_str += "<thead>";
               print_str += "<tr>";
               print_str += "<th class='enroll-table'>구분</th>";
               print_str += "<th class='enroll-table'>학과이름</th>";
               print_str += "<th class='enroll-table'>교수이름</th>";
               print_str += "<th class='enroll-table'>과목번호</th>";
               print_str += "<th class='enroll-table'>과목이름</th>";
               print_str += "<th class='enroll-table'>수강요일</th>";
               print_str += "<th class='enroll-table'>수강학점</th>";
               print_str += "<th class='enroll-table'>등록</th>";
               print_str += "</tr>";
               print_str += "</thead>";
               
               print_str += "<tbody>";
               //배열 출력(.each를 이용)//var tempNumber="";
               var tempName="";
               var tempDName="";
               var tempGrade="";
               var tempMemo="";
               var tempPName="";
               var tempDate="";
               var tempDay="";
               var tempTime="";
               var strArray;
               var idx=0;
               var cnt=1;
               
               $.each(user_array, function(index,value) {
              	 if((index+1) % 4 == 0){
              		 strArray = value.c_date_time.split("|");
              		 if(idx == 3){                    			
              			 tempDate+=strArray[1]+"교시";
              		 }
              		print_str += "<tr>";
                    print_str += "<td class='tb-enroll-content'>"+(cnt)+"</td>";
                    print_str += "<td class='tb-enroll-content'>"+value.dept_name+"</td>";
                    print_str += "<td class='tb-enroll-content'>"+value.pro_name+"</td>";
                    print_str += "<td class='tb-enroll-content'>"+value.c_number+"</td>";
                    print_str += "<td class='tb-enroll-content'>"+value.c_name+"</td>";
                    print_str += "<td class='tb-enroll-content'>"+tempDate+"</td>";
                    print_str += "<td class='tb-enroll-content'>"+value.c_grade+"</td>";
                    //onclick속성을 이용해서 직접 함수를 호출하고 값으로 현재 button태그에 value값을(pid) 이용한다.//
                    print_str += "<td class='tb-enroll-content'><button value='"+value.c_number+"' class='btn btn-success' onclick='enrollcoursae(this.value)'>신청</button></td>";
                    print_str += "</tr>";  	          			
                    print_str += "</tbody>";          			  
	          			 cnt++;
	          		     idx=0;
              	 }
              	 else{
              		 strArray = value.c_date_time.split("|");
              		 if(idx == 0){                    			
        	          		tempDate=strArray[0] + " " + strArray[1] + "교시";
              		 }
              		 else if(idx==2){
   	          			tempDate+="<br>";
   		          		tempDate+=strArray[0] + " " + strArray[1] + "교시";
   	          		 }
              		 else{
   	          			tempDate+=strArray[1]+"교시";
   	          		 }
  	          		 idx++;
              	 }
              	 
        });  
            }
             
             else if(row_count == 0){
               print_str = "<table class='table table-hover'>";
               print_str += "<tbody>";
               print_str += "<td><img src='./resources/images/emptypage_image.png' height='150' id='empty-image'></td>";
               print_str += "</tr>";
               print_str += "<tr>";
               print_str += "<td><p style='text-align: center; font-size: 17px; font-style: bold;'>해당 학과에 등록된 과목이 없습니다. 해당 학과사무실에 연락해주세요.</p></td>";
               print_str += "</tr>";
               print_str += "</tbody>";
            }
           
           print_str += "</table>";
           print_str += "</div>";
           
          
           $('#contentview').append(print_str);
           
           sidebarrefresh();
        },
        error: function(retVal, status, er){
           alert("error: "+retVal+" status: "+status+" er:"+er);
        }
    });
}
////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////창욱수정(선택관련 함수)//////////////////////////////////////////////////
function changeSelect(){
	var selectBox = document.getElementById("sel1");
    var selectedValue = selectBox.options[selectBox.selectedIndex].value;
	
	//ajax call//
	refreshselectcourse(selectedValue);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////창욱 수정(수강신청 관련 함수)//////////////////////////////////////////////
function enrollcoursae(courseNumber){
	var stuNumber = $('#stunum').val();
	var selectBox = document.getElementById("sel1");
    var selectedValue = selectBox.options[selectBox.selectedIndex].value;
	
	//ajax call//
	var trans_objeect = 
	{
		'courseNum':courseNumber,
		'stuNum':stuNumber
	}
	
	var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
	
	$.ajax({
	      url: "http://localhost:8080/project/enrollcourseajax",
	      type: 'POST',
	      dataType: 'json',
	      data: trans_json,
	      contentType: 'application/json',
	      mimeType: 'application/json',
	      beforeSend:function(){
	          $('.wrap-loading').removeClass('display-none');
	      },
	      complete:function(){
	          $('.wrap-loading').addClass('display-none');
	      },
	      success: function(retVal){
	         if(retVal.check == 'true'){
	            //alert('신청성공');
	            
	            var msg = "신청완료.";
				
				$('#msgbody').empty();
				$('#msgbody').append("<p>"+msg+"</p>");
				$('#msgModal').modal('show');
	            
	            //리플래시//
	            sidebarrefresh();
	         }
	         
	         else{
	            //alert('이미 수강신청된 과목이거나 학점과 수강일을 확인하세요.');
	            
	            var msg = "이미 수강신청된 과목이거나 학점과 수강일을 확인하세요.";
				
				$('#msgbody').empty();
				$('#msgbody').append("<p>"+msg+"</p>");
				$('#msgModal').modal('show');
	            
	            sidebarrefresh();
	         }
	      },
	      error: function(retVal, status, er){
	         alert("error: "+retVal+" status: "+status+" er:"+er);
	      }
	});
}
////////////////////////////////////////////////////////////////////////////////////////////////////////
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
      beforeSend:function(){
          $('.wrap-loading').removeClass('display-none');
      },
      complete:function(){
          $('.wrap-loading').addClass('display-none');
      },
      success: function(retVal){
         if(retVal.check == 'true'){
            //alert('메모등록  및 변경 성공');
            
            var msg = "메모등록  및 변경 완료.";
				
			$('#msgbody').empty();
			$('#msgbody').append("<p>"+msg+"</p>");
			$('#msgModal').modal('show');
            
            //location.reload();
            refreshcall(); //해당 테이블을 다시 호출한다.//
         }
         
         else{
            //alert('메모등록  실패');
            
            var msg = "메모등록  실패.";
				
			$('#msgbody').empty();
			$('#msgbody').append("<p>"+msg+"</p>");
			$('#msgModal').modal('show');
            
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
      beforeSend:function(){
          $('.wrap-loading').removeClass('display-none');
      },
      complete:function(){
          $('.wrap-loading').addClass('display-none');
      },
      success: function(retVal){
         var check = retVal.check;
         
         if(check == 'true'){
            //alert('과목 삭제 성공');
            
            var msg = "과목 수강취소 완료.";
				
			$('#msgbody').empty();
			$('#msgbody').append("<p>"+msg+"</p>");
			$('#msgModal').modal('show');
            
            refreshcall();
         }
         
         else if(check == 'false'){
            //alert('과목 삭제 실패');   
            
            var msg = "과목 수강취소 실패.";
				
			$('#msgbody').empty();
			$('#msgbody').append("<p>"+msg+"</p>");
			$('#msgModal').modal('show');
            
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
      //alert('세션이 만료된 페이지 입니다.');
      
      var msg = "세션이 만료된 페이지 입니다.";
				
		$('#msgbody').empty();
		$('#msgbody').append("<p>"+msg+"</p>");
		$('#msgModal').modal('show');
   
      var url = "http://localhost:8080/project/login";
      $(location).attr("href", url);
	}
     
   $(function(){
         //click의 function을 넣은것은 callback이다.(Javascript는 callback구조)//
         $('#btn__info_click').click(function(){
            //alert('선택');
            
            var html_str = "<p>소개관련 뷰</p>";
            
            $('#contentview').empty();
            $('#contentview').append(html_str);
         });
         //////////////////////////////////////////창욱수정(수강신청 리스트 불러오기)///////////////////////////////////////////////////
         $('#btn__enrolllist_click').click(function(){  
            //ajax call - 기본 출력되는 학과는 컴퓨터공학과로 설정 후 이 후 select 박스로 선택 후 적용//
            var deptno = "1";
            
            var trans_objeect = 
            {
                'deptno':deptno,
            }
            
            var trans_json = JSON.stringify(trans_objeect); //json으로 반환//
            
            $.ajax({
                url: "http://localhost:8080/project/courselistajax",
                type: 'POST',
                dataType: 'json',
                data: trans_json,
                contentType: 'application/json',
                mimeType: 'application/json',
                beforeSend:function(){
                    $('.wrap-loading').removeClass('display-none');
                },
                complete:function(){
                    $('.wrap-loading').addClass('display-none');
                },
                success: function(retVal){
                   var checkVal = retVal.check;   
                   var user_array = [];
                   //배열적용(ajax컨트롤러에서 HashMap으로 저장한 값을 불러온다.)//
                   user_array = retVal.list;
                   var row_count = user_array.length;
          
                   $('#contentview').empty(); //화면을 초기화//
                   
                   var print_str = '';
                   
                   //select 박스 생성//
                   print_str += "<p>검색하고자 하는 학과를 선택하시오. </p>";
                   print_str += "<div>"
                   print_str += "<select class='form-control' id='sel1' onchange='changeSelect()'>";
                   print_str += "<option value='학과선택'>학과선택</option>";
                   print_str += "<option value='1'>컴퓨터공학과</option>";
                   print_str += "<option value='2'>경영학과</option>";
                   print_str += "<option value='3'>문헌정보학과</option>";
                   print_str += "<option value='4'>정보보호학과</option>";
                   print_str += "<option value='5'>생명공학과</option>";
                   print_str += "<option value='6'>멀티미디어학과</option>";
                   print_str += "<option value='7'>간호학과</option>";
                   print_str += "<option value='8'>경제학과</option>";
                   print_str += "<option value='9'>영어영문학과</option>";
                   print_str += "<option value='10'>일어일문학과</option>";
                   print_str += "<option value='11'>중어중문학과</option>";
                   print_str += "<option value='12'>독어독문학과</option>";
                   print_str += "<option value='13'>불어불문학과</option>";
                   print_str += "<option value='14'>유아교육학과</option>";
                   print_str += "<option value='15'>과학교육과</option>";
                   print_str += "<option value='16'>컴퓨터교육과</option>";
                   print_str += "<option value='17'>심리학과</option>";
                   print_str += "<option value='18'>범죄심리학과</option>";
                   print_str += "<option value='19'>정치외교학과</option>";
                   print_str += "<option value='20'>행정학과</option>";
                   print_str += "</select>";
                   print_str += "</div>";
                   
                   print_str += "<div><hr></div>";
                   
                   $('#contentview').append(print_str); //증간적용//
                   
                   if(row_count >= 1){
                	   print_str = "<div style='width:100%; height:730px; overflow:hidden'>"; //스크롤바//
                       print_str += "<table class='table table-hover'>";
                       print_str += "<thead>";
                       print_str += "<tr>";
                       print_str += "<th class='enroll-table'>구분</th>";
                       print_str += "<th class='enroll-table'>학과이름</th>";
                       print_str += "<th class='enroll-table'>교수이름</th>";
                       print_str += "<th class='enroll-table'>과목번호</th>";
                       print_str += "<th class='enroll-table'>과목이름</th>";
                       print_str += "<th class='enroll-table'>수강요일</th>";
                       print_str += "<th class='enroll-table'>수강학점</th>";
                       print_str += "<th class='enroll-table'>등록</th>";
                       print_str += "</tr>";
                       print_str += "</thead>";
                       
                       print_str += "<tbody>";
                       var tempNumber="";
                       var tempName="";
                       var tempDName="";
                       var tempGrade="";
                       var tempMemo="";
                       var tempPName="";
                       var tempDate="";
                       var tempDay="";
                       var tempTime="";
                       var strArray;
                       var idx=0;
                       var cnt=1;
                       
                       $.each(user_array, function(index,value) {
                      	 if((index+1) % 4 == 0){
                      		 strArray = value.c_date_time.split("|");
                      		 if(idx == 3){                    			
                      			 tempDate+=strArray[1]+"교시";
                      		 }
                      		print_str += "<tr>";
                            print_str += "<td class='tb-enroll-content'>"+(cnt)+"</td>";
                            print_str += "<td class='tb-enroll-content'>"+value.dept_name+"</td>";
                            print_str += "<td class='tb-enroll-content'>"+value.pro_name+"</td>";
                            print_str += "<td class='tb-enroll-content'>"+value.c_number+"</td>";
                            print_str += "<td>"+value.c_name+"</td>";
                            print_str += "<td class='tb-enroll-content'>"+tempDate+"</td>";
                            print_str += "<td class='tb-enroll-content'>"+value.c_grade+"</td>";
                            //onclick속성을 이용해서 직접 함수를 호출하고 값으로 현재 button태그에 value값을(pid) 이용한다.//
                            print_str += "<td id='tb-enroll'><button value='"+value.c_number+"' class='btn btn-success' onclick='enrollcoursae(this.value)'>신청</button></td>";
                            print_str += "</tr>";  	          			
                            print_str += "</tbody>";          			  
       	          			 cnt++;
       	          		     idx=0;
                      	 }
                      	 else{
                      		 strArray = value.c_date_time.split("|");
                      		 if(idx == 0){                    			
                	          		tempDate=strArray[0] + " " + strArray[1] + "교시";
                      		 }
                      		 else if(idx==2){
           	          			tempDate+="<br>";
           		          		tempDate+=strArray[0] + " " + strArray[1] + "교시";
           	          		 }
                      		 else{
           	          			tempDate+=strArray[1]+"교시";
           	          		 }
          	          		 idx++;
                      	 }
                      	 
  	          });                       
                           
                    }
                     
                     else if(row_count == 0){
                       print_str = "<table class='table table-hover'>";
                       print_str += "<tbody>";
                       print_str += "<tr>";
                       print_str += "<td><img src='./resources/images/emptypage_image.png' width='400' height='150' id='empty-image'></td>";
                       print_str += "</tr>";
                       print_str += "<tr>";
                       print_str += "<td><p style='text-align: center; font-size: 17px; font-style: bold;'>해당 학과에 등록된 과목이 없습니다. 해당 학과사무실에 연락해주세요.</p></td>";
                       print_str += "</tr>";
                       print_str += "</tbody>";
                    }
                   
                   print_str += "</table>";
                   print_str += "</div>";
                   
                  
                   $('#contentview').append(print_str);
                },
                error: function(retVal, status, er){
                   alert("error: "+retVal+" status: "+status+" er:"+er);
                }
             });
         });
		 //////////////////////////////////////////////////////////////////////////////////////////////////
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
               beforeSend:function(){
                   $('.wrap-loading').removeClass('display-none');
               },
               complete:function(){
                   $('.wrap-loading').addClass('display-none');
               },
               success: function(retVal){
                  var checkVal = retVal.check;   
                  //테이블을 뿌려준다.//
                  var user_array = [];
                  //배열적용(ajax컨트롤러에서 HashMap으로 저장한 값을 불러온다.)//
                  user_array = retVal.list;
                  var row_count = user_array.length;
                   var total_grade = 0;
                   var subjectcount = 0;
                   
                   $('#contentview').empty();
                   
                   if(row_count >= 1){
                	 print_str = "<div style='width:100%; height:700px; overflow:hidden'>"; //스크롤바//
                     print_str = "<table class='table table-hover'>";
                     print_str += "<thead>";
                     print_str += "<tr>";
                     print_str += "<th class='enroll-table'>구분</th>";
                     print_str += "<th class='enroll-table'>과목번호</th>";
                     print_str += "<th class='enroll-table'>과목이름</th>";
                     print_str += "<th class='enroll-table'>교수명</th>";
                     print_str += "<th class='enroll-table'>수강시간</th>";
                     print_str += "<th class='enroll-table'>과목학점</th>";
                     print_str += "<th class='enroll-table'>메모사항</th>";
                     print_str += "<th class='enroll-table'>제거</th>";
                     print_str += "</tr>";
                     print_str += "</thead>";
                     
                     print_str += "<tbody>";
                     //배열 출력(.each를 이용)//
                     
                     var total_grade=0;
                     var tempNumber="";
                     var tempName="";
                     var tempGrade="";
                     var tempMemo="";
                     var tempPName="";
                     var tempDate="";
                     var tempDay="";
                     var tempTime="";
                     var strArray;
                     var idx=0;
                     var cnt=1;
                     $.each(user_array, function(index,value) {
                    	 if((index+1) % 4 == 0){
                    		 strArray = value.c_date_time.split("|");
                    		 if(idx == 3){                    			
                    			 tempDate+=strArray[1]+"교시";
                    		 }
                             total_grade += value.c_grade;
                             subjectcount += 1;
                             print_str += "<tr>";
                             print_str += "<td class='tb-enroll-content'>"+(cnt)+"</td>";
                             print_str += "<td class='tb-enroll-content'>"+value.c_number+"</td>";
                             print_str += "<td>"+value.c_name+"</td>";
                             print_str += "<td class='tb-enroll-content'>"+value.pro_name+"</td>";
                             print_str += "<td class='tb-enroll-content'>"+tempDate+"</td>";
                             print_str += "<td class='tb-enroll-content'>"+value.c_grade+"</td>";
                             print_str += "<td class='tb-enroll-content'><input type=button name='"+value.c_memo+"' class='btn btn-primary' onclick='memoview(this.name)' value='보기'>&nbsp&nbsp";
                             print_str += "<button value='"+value.c_number+"' class='btn btn-success' onclick='memowriteModalsshow(this.value)'>작성</button></td>";
                             //onclick속성을 이용해서 직접 함수를 호출하고 값으로 현재 button태그에 value값을(pid) 이용한다.//
                             print_str += "<td class='tb-enroll-content'><button value='"+value.c_number+"' class='btn btn-danger' onclick='deletecourse(this.value)'>과목취소</button></td>";
                             print_str += "</tr>";
                             print_str += "</tbody>";	          			  
     	          			 cnt++;
     	          		     idx=0;
                    	 }
                    	 else{
                    		 strArray = value.c_date_time.split("|");
                    		 if(idx == 0){                    			
              	          		tempDate=strArray[0] + " " + strArray[1] + "교시";
                    		 }
                    		 else if(idx==2){
         	          			tempDate+="<br>";
         		          		tempDate+=strArray[0] + " " + strArray[1] + "교시";
         	          		 }
                    		 else{
         	          			tempDate+=strArray[1]+"교시";
         	          		 }
        	          		 idx++;
                    	 }
                    	 
	          });
                    
                     
                    
                  }
                   
                   else if(row_count == 0){
                     print_str = "<table class='table table-hover'>";
                     print_str += "<tbody>";
                     print_str += "<tr>";
                     //print_str += "<td><img src='resources/images/emptypage_image.png' width='400' height='150'></td>";
                     print_str += "<td><p style='text-align: center; font-size: 17px; font-style: bold;'>수강내역이 없습니다.</p</td>";
                     print_str += "</tr>";
                     print_str += "</tbody>";
                  }
                      
                      print_str += "</table>";
                      print_str += "</div>";
                      
                      print_str += "<div>";
                      print_str += "<p>* 총 학점: "+total_grade+"</p>";
                      print_str += "</div>";
                      print_str += "<div>";
                      print_str += "<p>* 총 신청과목 수: "+subjectcount+"</p>";
                      print_str += "</div>";
                      
                      $('#contentview').append(print_str);
                      
                      sidebarrefresh();
               },
               error: function(retVal, status, er){
                  alert("error: "+retVal+" status: "+status+" er:"+er);
               }
            });
         });
         $('#info_sub1').click(function(){
            //alert('선택');
            
            var html_str = "<p>과목소개 1 뷰</p>";
            $('#contentview').empty();
            $('#contentview').append(html_str);
         });
         $('#info_sub2').click(function(){
            //alert('선택');
            
            var html_str = "<p>과목소개 2 뷰</p>";
            $('#contentview').empty();
            $('#contentview').append(html_str);
         });
         $('#btn_myinfo_update').click(function(){
            //alert("선택");
            
            var html_str = "<p>내 정보 수정 뷰</p>";
            $('#contentview').empty();
            $('#contentview').append(html_str);
         });
         $('#btn_home').click(function(){
            $('#contentview').empty();
			$('#contentview').load('${pageContext.request.contextPath}/notice.jsp');
			
			 //새로고침//
           // var html_str = "<div id='contentview'>";
           // html_str += "<h3>Home View</h3>";
           // html_str += "<p>현재는 홈 뷰 (각 메뉴에 따라 뷰가 변경)</p>";
           // html_str += "</div>";
            
          //  $('#contentview').empty();
          //  $('#contentview').append(html_str);
         });
         $('#btn_click').click(function(){
             $('#contentview').empty();
 			$('#contentview').load('${pageContext.request.contextPath}/intro.jsp');
 			
 			 //새로고침//
            // var html_str = "<div id='contentview'>";
            // html_str += "<h3>Home View</h3>";
            // html_str += "<p>현재는 홈 뷰 (각 메뉴에 따라 뷰가 변경)</p>";
            // html_str += "</div>";
             
           //  $('#contentview').empty();
           //  $('#contentview').append(html_str);
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
               beforeSend:function(){
                   $('.wrap-loading').removeClass('display-none');
               },
               complete:function(){
                   $('.wrap-loading').addClass('display-none');
               },
               success: function(retVal){
                  var is_check = retVal;
               
                  if(is_check == 'true'){
                     var url = "http://localhost:8080/project/login";
                     $(location).attr("href", url);
                  }
                  
                  else if(is_check == 'false'){
                     //alert('세션종료 실패');   
                     
                	  var msg = "세션종료 실패.";
      				
          				$('#msgbody').empty();
          				$('#msgbody').append("<p>"+msg+"</p>");
          				$('#msgModal').modal('show');
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

<nav class="navbar navbar-default navbar-static-top" id="nav2">
  <div class="container-fluid">  
    <div class="navbar-header">
      <!-- <a class="navbar-brand" href="#">수강신청</a> -->      
      <ul class="nav navbar-nav" id="nav-cont">
      	<li><img src="resources/images/uploadimg/luniv.png" id= "img-navbar"></li>
      	      
        <li><a href="#" class="nav_btn" id="btn_home">Home</a></li>
  		<li><a href="#" class="nav_btn" id="btn_click">소개</a></li>      
        <li><a href="#" class="nav_btn" id="btn__enrolllist_click">수강신청</a></li>
        <li><a href="#" class="nav_btn" id="btn__myenrolllist_click">내 수강정보 확인</a></li>
      </ul>       
    </div>
    <div class="collapse navbar-collapse navbar-right" id="myNavbar">
    	<ul class="nav navbar-nav navbar-right">
        <li><a href="#" class="nav_btn" id="btn_logout" style="color: #0366d6"><span class="glyphicon glyphicon-log-in"></span>&nbsp로그아웃</a></li>
      </ul>
    </div>
  </div>
</nav>
<hr>
  
<div class="container-fluid text-center" id="main-container">    
  <div class="row content">
     <div class="col-sm-2 sidenav" id="subjectlist"  style="overflow:hidden; height:100%;">
     
    </div>
    <div class="col-sm-8 text-left"> 
      <!-- <h1>롯데대학교 수강신청 프로그램</h1> -->
        <img src="resources/images/uploadimg/enroll.png" id="img-maincont">
      <hr>
      <div id="contentview">
      	
      </div>
    </div>
   <div class="col-sm-2 sidenav">
		<div class="card">
  			<img src="resources/images/uploadimg/${imagefile}" class="" alt="Cinque Terre" style="width:100%">
  			<div>
	  			<h6 id="title"><b>${sessionId}</b><br>
	  			<p id="cardName">${stuName}</p>
	            </h6>
	            <hr>
	  			 <!-- class="img-circle".....ㅎㅎ -->
  			</div>
  			<input type="hidden" id="sessionid" value='${sessionId}'>
  			<div>
    		<p id="#info_dept" class="info_data"><svg class="octicon octicon-globe" viewBox="0 0 14 16" version="1.1" width="14" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7 1C3.14 1 0 4.14 0 8s3.14 7 7 7c.48 0 .94-.05 1.38-.14-.17-.08-.2-.73-.02-1.09.19-.41.81-1.45.2-1.8-.61-.35-.44-.5-.81-.91-.37-.41-.22-.47-.25-.58-.08-.34.36-.89.39-.94.02-.06.02-.27 0-.33 0-.08-.27-.22-.34-.23-.06 0-.11.11-.2.13-.09.02-.5-.25-.59-.33-.09-.08-.14-.23-.27-.34-.13-.13-.14-.03-.33-.11s-.8-.31-1.28-.48c-.48-.19-.52-.47-.52-.66-.02-.2-.3-.47-.42-.67-.14-.2-.16-.47-.2-.41-.04.06.25.78.2.81-.05.02-.16-.2-.3-.38-.14-.19.14-.09-.3-.95s.14-1.3.17-1.75c.03-.45.38.17.19-.13-.19-.3 0-.89-.14-1.11-.13-.22-.88.25-.88.25.02-.22.69-.58 1.16-.92.47-.34.78-.06 1.16.05.39.13.41.09.28-.05-.13-.13.06-.17.36-.13.28.05.38.41.83.36.47-.03.05.09.11.22s-.06.11-.38.3c-.3.2.02.22.55.61s.38-.25.31-.55c-.07-.3.39-.06.39-.06.33.22.27.02.5.08.23.06.91.64.91.64-.83.44-.31.48-.17.59.14.11-.28.3-.28.3-.17-.17-.19.02-.3.08-.11.06-.02.22-.02.22-.56.09-.44.69-.42.83 0 .14-.38.36-.47.58-.09.2.25.64.06.66-.19.03-.34-.66-1.31-.41-.3.08-.94.41-.59 1.08.36.69.92-.19 1.11-.09.19.1-.06.53-.02.55.04.02.53.02.56.61.03.59.77.53.92.55.17 0 .7-.44.77-.45.06-.03.38-.28 1.03.09.66.36.98.31 1.2.47.22.16.08.47.28.58.2.11 1.06-.03 1.28.31.22.34-.88 2.09-1.22 2.28-.34.19-.48.64-.84.92s-.81.64-1.27.91c-.41.23-.47.66-.66.8 3.14-.7 5.48-3.5 5.48-6.84 0-3.86-3.14-7-7-7L7 1zm1.64 6.56c-.09.03-.28.22-.78-.08-.48-.3-.81-.23-.86-.28 0 0-.05-.11.17-.14.44-.05.98.41 1.11.41.13 0 .19-.13.41-.05.22.08.05.13-.05.14zM6.34 1.7c-.05-.03.03-.08.09-.14.03-.03.02-.11.05-.14.11-.11.61-.25.52.03-.11.27-.58.3-.66.25zm1.23.89c-.19-.02-.58-.05-.52-.14.3-.28-.09-.38-.34-.38-.25-.02-.34-.16-.22-.19.12-.03.61.02.7.08.08.06.52.25.55.38.02.13 0 .25-.17.25zm1.47-.05c-.14.09-.83-.41-.95-.52-.56-.48-.89-.31-1-.41-.11-.1-.08-.19.11-.34.19-.15.69.06 1 .09.3.03.66.27.66.55.02.25.33.5.19.63h-.01z"></path></svg>${major}</p>
    		<p id="#info_stunumber" class="info_data"><svg class="octicon octicon-credit-card" viewBox="0 0 16 16" version="1.1" width="14" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M12 9H2V8h10v1zm4-6v9c0 .55-.45 1-1 1H1c-.55 0-1-.45-1-1V3c0-.55.45-1 1-1h14c.55 0 1 .45 1 1zm-1 3H1v6h14V6zm0-3H1v1h14V3zm-9 7H2v1h4v-1z"></path></svg>${stunumber}</p>
             <p id="#info_grade" class="info_data"><svg class="octicon octicon-list-ordered" viewBox="0 0 12 16" version="1.1" width="14" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M12 13c0 .59 0 1-.59 1H4.59C4 14 4 13.59 4 13c0-.59 0-1 .59-1h6.81c.59 0 .59.41.59 1H12zM4.59 4h6.81c.59 0 .59-.41.59-1 0-.59 0-1-.59-1H4.59C4 2 4 2.41 4 3c0 .59 0 1 .59 1zm6.81 3H4.59C4 7 4 7.41 4 8c0 .59 0 1 .59 1h6.81c.59 0 .59-.41.59-1 0-.59 0-1-.59-1zM2 1h-.72c-.3.19-.58.25-1.03.34V2H1v2.14H.16V5H3v-.86H2V1zm.25 8.13c-.17 0-.45.03-.66.06.53-.56 1.14-1.25 1.14-1.89C2.71 6.52 2.17 6 1.37 6c-.59 0-.97.2-1.38.64l.58.58c.19-.19.38-.38.64-.38.28 0 .48.16.48.52 0 .53-.77 1.2-1.7 2.06V10h3l-.09-.88h-.66l.01.01zm-.08 3.78v-.03c.44-.19.64-.47.64-.86 0-.7-.56-1.11-1.44-1.11-.48 0-.89.19-1.28.52l.55.64c.25-.2.44-.31.69-.31.27 0 .42.13.42.36 0 .27-.2.44-.86.44v.75c.83 0 .98.17.98.47 0 .25-.23.38-.58.38-.28 0-.56-.14-.81-.38l-.48.66c.3.36.77.56 1.41.56.83 0 1.53-.41 1.53-1.16 0-.5-.31-.81-.77-.94v.01z"></path></svg>${year} 학년</p>
             <p id="#info_birth" class="info_data"><svg class="octicon octicon-calendar" viewBox="0 0 14 16" version="1.1" width="14" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M13 2h-1v1.5c0 .28-.22.5-.5.5h-2c-.28 0-.5-.22-.5-.5V2H6v1.5c0 .28-.22.5-.5.5h-2c-.28 0-.5-.22-.5-.5V2H2c-.55 0-1 .45-1 1v11c0 .55.45 1 1 1h11c.55 0 1-.45 1-1V3c0-.55-.45-1-1-1zm0 12H2V5h11v9zM5 3H4V1h1v2zm6 0h-1V1h1v2zM6 7H5V6h1v1zm2 0H7V6h1v1zm2 0H9V6h1v1zm2 0h-1V6h1v1zM4 9H3V8h1v1zm2 0H5V8h1v1zm2 0H7V8h1v1zm2 0H9V8h1v1zm2 0h-1V8h1v1zm-8 2H3v-1h1v1zm2 0H5v-1h1v1zm2 0H7v-1h1v1zm2 0H9v-1h1v1zm2 0h-1v-1h1v1zm-8 2H3v-1h1v1zm2 0H5v-1h1v1zm2 0H7v-1h1v1zm2 0H9v-1h1v1z"></path></svg>${birth}</p>             
             <p id="#info_address" class="info_data"><svg aria-hidden="true" class="octicon octicon-location" height="16" version="1.1" viewBox="0 0 12 16" width="14"><path fill-rule="evenodd" d="M6 0C2.69 0 0 2.5 0 5.5 0 10.02 6 16 6 16s6-5.98 6-10.5C12 2.5 9.31 0 6 0zm0 14.55C4.14 12.52 1 8.44 1 5.5 1 3.02 3.25 1 6 1c1.34 0 2.61.48 3.56 1.36.92.86 1.44 1.97 1.44 3.14 0 2.94-3.14 7.02-5 9.05zM8 5.5c0 1.11-.89 2-2 2-1.11 0-2-.89-2-2 0-1.11.89-2 2-2 1.11 0 2 .89 2 2z"/></svg>${address}</p>
             <p></p>             
             <hr>             
             <p id="#info_email" class="info_data">
             <svg aria-hidden="true" class="octicon octicon-mail" height="16" version="1.1" viewBox="0 0 14 16" width="14"><path fill-rule="evenodd" d="M0 4v8c0 .55.45 1 1 1h12c.55 0 1-.45 1-1V4c0-.55-.45-1-1-1H1c-.55 0-1 .45-1 1zm13 0L7 9 1 4h12zM1 5.5l4 3-4 3v-6zM2 12l3.5-3L7 10.5 8.5 9l3.5 3H2zm11-.5l-4-3 4-3v6z"/></svg>${email}
             </p>
             <p id="#info_phonenumber" class="info_data">
             <svg class="octicon octicon-device-mobile" viewBox="0 0 10 16" version="1.1" width="14" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M9 0H1C.45 0 0 .45 0 1v14c0 .55.45 1 1 1h8c.55 0 1-.45 1-1V1c0-.55-.45-1-1-1zM5 15.3c-.72 0-1.3-.58-1.3-1.3 0-.72.58-1.3 1.3-1.3.72 0 1.3.58 1.3 1.3 0 .72-.58 1.3-1.3 1.3zM9 12H1V2h8v10z"/></svg>${phonenumber}
             </p>
             <input type='hidden' id='stunum' value='${stunumber}'>
    		</div>
  			<div class="container">
  			</div>
		</div>
    </div>
  </div>
</div>

<footer class="container-fluid text-center">
  <p>LOTTE DATA COMMUNICATION Java Programming B class</p>
</footer>
 <!-- Modal -->
  <div class="modal fade" id="msgModal" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">LOTTE University</h4>
        </div>
        <div class="modal-body" id="msgbody">
          <p>'${msg}'</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
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
  
<div class="wrap-loading display-none">
    <div><img src="resources/images/ajax-loader.gif" /></div>
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