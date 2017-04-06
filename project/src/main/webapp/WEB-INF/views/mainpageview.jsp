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
   $('#contentview').load('${pageContext.request.contextPath}/view.jsp'); //홈화면
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
	          
	          printStr += "<p>나의 수강과목 정보</p>";
	          
	          $.each(user_array, function(index,value) {
	        	  printStr += "<div class='well'>";     
	        	  printStr += "<p id='info_sub1'>" + value.c_name + " "+ value.c_date_time +"</p>";
	        	  printStr += "</div>";
	          });  
	          
	          $('#subjectlist').append(printStr);
	      },
	      error: function(retVal, status, er){
	         alert("error: "+retVal+" status: "+status+" er:"+er);
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
        	print_str = "<div style='width:100%; height:700px; overflow:auto'>"; //스크롤바//
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
                  subjectcount += 1;
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
        	   print_str = "<div style='width:100%; height:700px; overflow:auto'>"; //스크롤바//
               print_str += "<table class='table table-hover'>";
               print_str += "<thead>";
               print_str += "<tr>";
               print_str += "<th>구분</th>";
               print_str += "<th>학과이름</th>";
               print_str += "<th>교수이름</th>";
               print_str += "<th>과목번호</th>";
               print_str += "<th>과목이름</th>";
               print_str += "<th>수강요일</th>";
               print_str += "<th>수강학점</th>";
               print_str += "<th>등록(동일번호 전부 등록)</th>";
               print_str += "</tr>";
               print_str += "</thead>";
               
               print_str += "<tbody>";
               //배열 출력(.each를 이용)//
               $.each(user_array, function(index,value) {
                  	 print_str += "<tr>";
                     print_str += "<td>"+(index+1)+"</td>";
                     print_str += "<td>"+value.dept_name+"</td>";
                     print_str += "<td>"+value.pro_name+"</td>";
                     print_str += "<td>"+value.c_number+"</td>";
                     print_str += "<td>"+value.c_name+"</td>";
                     print_str += "<td>"+value.c_date_time+"</td>";
                     print_str += "<td>"+value.c_grade+"</td>";
                     //onclick속성을 이용해서 직접 함수를 호출하고 값으로 현재 button태그에 value값을(pid) 이용한다.//
                     print_str += "<td><button value='"+value.c_number+"' class='btn btn-success' onclick='enrollcoursae(this.value)'>신청</button></td>";
                     print_str += "</tr>";
                  });   
               print_str += "</tbody>";
            }
             
             else if(row_count == 0){
               print_str = "<table class='table table-hover'>";
               print_str += "<tbody>";
               print_str += "<tr>";
               print_str += "<td><img src='./resources/images/emptypage_image.png' width='400' height='150'></td>";
               print_str += "<td><p>해당 학과에 등록된 과목이 없습니다. 해당 학과사무실에 연락해주세요.</p</td>";
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
	            alert('신청성공');
	            
	            //리플래시//
	            sidebarrefresh();
	         }
	         
	         else{
	            alert('이미 수강신청된 과목이거나 학점과 수강일을 확인하세요.');
	            
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
      beforeSend:function(){
          $('.wrap-loading').removeClass('display-none');
      },
      complete:function(){
          $('.wrap-loading').addClass('display-none');
      },
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
                	   print_str = "<div style='width:100%; height:730px; overflow:auto'>"; //스크롤바//
                       print_str += "<table class='table table-hover'>";
                       print_str += "<thead>";
                       print_str += "<tr>";
                       print_str += "<th>구분</th>";
                       print_str += "<th>학과이름</th>";
                       print_str += "<th>교수이름</th>";
                       print_str += "<th>과목번호</th>";
                       print_str += "<th>과목이름</th>";
                       print_str += "<th>수강요일</th>";
                       print_str += "<th>수강학점</th>";
                       print_str += "<th>등록(동일번호 전부 등록)</th>";
                       print_str += "</tr>";
                       print_str += "</thead>";
                       
                       print_str += "<tbody>";
                       //배열 출력(.each를 이용)//
                       $.each(user_array, function(index,value) {
                          	 print_str += "<tr>";
                             print_str += "<td>"+(index+1)+"</td>";
                             print_str += "<td>"+value.dept_name+"</td>";
                             print_str += "<td>"+value.pro_name+"</td>";
                             print_str += "<td>"+value.c_number+"</td>";
                             print_str += "<td>"+value.c_name+"</td>";
                             print_str += "<td>"+value.c_date_time+"</td>";
                             print_str += "<td>"+value.c_grade+"</td>";
                             //onclick속성을 이용해서 직접 함수를 호출하고 값으로 현재 button태그에 value값을(pid) 이용한다.//
                             print_str += "<td><button value='"+value.c_number+"' class='btn btn-success' onclick='enrollcoursae(this.value)'>신청</button></td>";
                             print_str += "</tr>";
                          });   
                       print_str += "</tbody>";
                    }
                     
                     else if(row_count == 0){
                       print_str = "<table class='table table-hover'>";
                       print_str += "<tbody>";
                       print_str += "<tr>";
                       print_str += "<td><img src='./resources/images/emptypage_image.png' width='400' height='150'></td>";
                       print_str += "<td><p>해당 학과에 등록된 과목이 없습니다. 해당 학과사무실에 연락해주세요.</p</td>";
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
                	 print_str = "<div style='width:100%; height:700px; overflow:auto'>"; //스크롤바//
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
                           subjectcount += 1;
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
                     print_str += "<td><img src='./resources/images/emptypage_image.png' width='400' height='150'></td>";
                     print_str += "<td><p>테이블에 데이터가 없습니다</p</td>";
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
            $('#contentview').empty();
			$('#contentview').load('${pageContext.request.contextPath}/view.jsp');
			
			sidebarrefresh(); //새로고침//
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
         <li><a href="#" id="btn__enrolllist_click">수강신청</a></li>
        <li><a href="#" id="btn__myenrolllist_click">내 수강정보 확인</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center" id="main-container">    
  <div class="row content">
     <div class="col-sm-2 sidenav" id="subjectlist" style="overflow:scroll; height:100%;">
     <p>나의 수강과목 정보</p>
     <!-- HTML에서 사용하는 배열 forEach -->
		<c:forEach items='${listsubject}' var='subject'>
		<div class="well">
        	<p id="info_sub1"><c:out value='${subject.c_name}'/>&nbsp&nbsp&nbsp<c:out value='${subject.c_date_time}'/></p>
      	</div>
		</c:forEach>
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