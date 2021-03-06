package com.lotte.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.lotte.dto.IdExistDTO;
import com.lotte.dto.CourseListDTO;
import com.lotte.dto.CourseListRequestDTO;
import com.lotte.dto.DeleteCourseDTO;
import com.lotte.dto.EnrollCourseDTO;
import com.lotte.dto.IdSearchDTO;
import com.lotte.dto.LoginDTO;
import com.lotte.dto.MemoUpdateDTO;
import com.lotte.dto.MyEnrollCourseDTO;
import com.lotte.dto.MyEnrollSearchDTO;
import com.lotte.dto.PasswordSearchDTO;
import com.lotte.dto.StudentDTO;
import com.lotte.log.Log;
import com.lotte.service.EnrollService;
import com.lotte.service.CourseListGetService;
import com.lotte.service.DeleteCourseService;
import com.lotte.service.EnrollCourseService;
import com.lotte.service.IdSearchService;
import com.lotte.service.LoginService;
import com.lotte.service.MemoUpdateService;
import com.lotte.service.MyEnrollCourseSearchService;
import com.lotte.service.PasswordSearchService;

@Controller
@SessionAttributes("sessionId") // id라는 키로 저장된 attribute는 세션객체에 저장 됨
public class AjaxController {
	Log log = null;

	@RequestMapping(value = "/loginajax", method = RequestMethod.POST, produces = { "application/json" })
	public @ResponseBody Map<String, Object> login(@RequestBody final LoginDTO loginInfo, Model view) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		boolean loginSucces = false;

		System.out.println("login ajax call (data: " + loginInfo.getUserId() + "/" + loginInfo.getUserPassword() + ")");

		// 해당 로그인 관련 서비스 호출//
		if (LoginService.checkLogin(loginInfo)) {
			// 세션 적용//
			view.addAttribute("sessionId", loginInfo.getUserId());
			loginSucces = true;
		}

		System.out.println();

		// 로그작업//
		log = new Log();
		log.saveLog(loginInfo.getUserId() + " login");

		retVal.put("check", "" + loginSucces);
		return retVal;
	}

	@RequestMapping(value = "/logoutajax", method = RequestMethod.POST)
	public @ResponseBody String logout(@RequestBody @RequestParam("sessionid") String sessionid, SessionStatus status) {
		boolean is_insert_success = false;

		System.out.println("session id: " + sessionid);

		// 세션종료//
		// SessionStatus는 스프링의 어노테이션으로 지원되는 @SessionAttributes의 세션을 만료시킨다.//
		status.setComplete();

		if (status.isComplete() == true) {
			System.out.println("Session invalid success...");

			is_insert_success = true;
		}

		// 로그작업//
		log = new Log();
		log.saveLog(sessionid + " logout");

		return "" + is_insert_success;
	}

	@RequestMapping(value = "/idsearchajax", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchId(@RequestBody final IdSearchDTO idsearchdto) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		String searchId = "";

		System.out.println(
				"id search ajax call (data: " + idsearchdto.getStuName() + "/" + idsearchdto.getStuNumber() + ")");

		// ID검색 비즈니스 로직 수행//
		searchId = IdSearchService.searchId(idsearchdto);

		retVal.put("id", searchId);

		// 로그작업//
		log = new Log();
		log.saveLog(idsearchdto.getStuName() + " id search");

		return retVal;
	}

	@RequestMapping(value = "/passwordsearchajax", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchPassword(@RequestBody final PasswordSearchDTO passwordsearchdto) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		String searchPassword = "";
		String mesage = "";

		Random random = new Random();

		int authnumber = random.nextInt(1000);

		System.out.println("password search ajax call (data: " + passwordsearchdto.getStuEmail() + "/"
				+ passwordsearchdto.getStuId() + ")");

		// ID검색 비즈니스 로직 수행//
		searchPassword = PasswordSearchService.searchPassword(passwordsearchdto);

		// 메일전송//
		String host = "smtp.naver.com";
		final String user = "scw0531";
		final String password = "tjckd246!dnr";

		String to = passwordsearchdto.getStuEmail();

		// Get the session object
		Properties props = new Properties();

		props.put("mail.smtp.host", host);
		props.put("mail.smtp.auth", "true");

		// 세션 설정//
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		// Compose the message
		try {
			// 메세지 작성//
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

			// Subject
			message.setSubject("[롯데대학교 수강신청 시스템 인증번호 확인]");

			// Text
			message.setText("비밀번호 찾기 인증번호 입니다. [" + authnumber + "]");

			// send the message
			Transport.send(message);
			System.out.println("message sent successfully...");
		} catch (MessagingException e) {
			e.printStackTrace();
		}

		retVal.put("password", searchPassword);
		retVal.put("authnumber", authnumber);

		// 로그작업//
		log = new Log();
		log.saveLog(user + " password check");

		return retVal;
	}

	@RequestMapping(value = "/enrollajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> enrollStudent(MultipartHttpServletRequest multi) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		String photofilename = "default_people_img.PNG"; // 만약 파일등록을 안할 시 디폴트
															// 이미지 저장되도록 함.//
		// 파일은 오직 1개만 들어온다는 가정//
		System.out.println("------------------<<File Upload>>---------------------");

		// 저장 경로 설정
		String root = multi.getSession().getServletContext().getRealPath("/");
		String path = root + "resources\\images\\uploading\\";

		System.out.println("save file path : " + path);
		File file = new File(".");
		file.getAbsoluteFile();
		String newFileName = file.getAbsoluteFile() + ""; // 업로드 되는 파일명
		System.out.println(newFileName);
		File dir = new File(path);

		if (!dir.isDirectory()) {
			dir.mkdir();
		}

		// 전송된 파일들(getFileNames)을 불러오기 위한 반복자(Formdata 탐색)//
		Iterator<String> files = multi.getFileNames();

		while (files.hasNext()) {
			String uploadFile = files.next();

		                         
		    MultipartFile mFile = multi.getFile(uploadFile);
		    
		    String fileName_original = mFile.getOriginalFilename();
		    //현재 프로젝트(서버)의 resources 경로//
		    String file_save_path = "/Users/macbook/Desktop/LOTTE/teamproject/webproject/project/src/main/webapp/resources/images/uploadimg/";
		             
		    try {
		    	mFile.transferTo(new File(file_save_path+fileName_original));
		    	photofilename = fileName_original;
		    	System.out.println("실제 전송된 파일 이름 : " +fileName_original);
			    System.out.println("파일 이름: " + newFileName);
			    System.out.println("전송된 파일 사이즈: " + mFile.getSize());
				
				System.out.println("------------------------------------------------------");

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// 파일 이외의 text데이터//
		System.out.println("id: " + multi.getParameter("stuId"));
		System.out.println("password: " + multi.getParameter("stuPassword"));
		System.out.println("name: " + multi.getParameter("stuName"));
		System.out.println("birth: " + multi.getParameter("stuBirth"));
		System.out.println("gender: " + multi.getParameter("stuGender"));
		System.out.println("number: " + multi.getParameter("stuNumber"));
		System.out.println("address: " + multi.getParameter("stuAddress"));
		System.out.println("deptno: " + multi.getParameter("deptNo"));
		System.out.println("grade: " + multi.getParameter("stuGrade"));
		System.out.println("email: " + multi.getParameter("stuEmail"));
		System.out.println("phonenumber: " + multi.getParameter("stuPhoneNumber"));
		System.out.println("photofilename: " + photofilename);

		// String stuId, String stuName, String stuPassword, String stuBirth,
		// String stuGender,
		// String stuNumber, String stuAddress, String deptNo, int stuGrade,
		// String stuEmail, String stuPhoneNumber,
		// String stuPhoto
		// 넘어온 데이터를 가지고 DTO구성//
		StudentDTO stuDTO = new StudentDTO(multi.getParameter("stuId"), multi.getParameter("stuName"),
				multi.getParameter("stuPassword"), multi.getParameter("stuBirth"), multi.getParameter("stuGender"),
				multi.getParameter("stuNumber"), multi.getParameter("stuAddress"), multi.getParameter("deptNo"),
				multi.getParameter("stuGrade"), multi.getParameter("stuEmail"), multi.getParameter("stuPhoneNumber"),
				photofilename);
		System.out.println("gender: " + stuDTO.getStuGender());
		retVal.put("enrollSuccess", EnrollService.enrollStudent(stuDTO));
		// 로그작업//
		log = new Log();
		log.saveLog(multi.getParameter("stuId") + " enroll");
		
		return retVal;
	}

	@RequestMapping(value = "/confirmidajax", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> confirmId(@RequestBody final IdExistDTO idExisttDTO) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		System.out.println("confirm id ajax call (data: " + idExisttDTO.getId() + ")");
		retVal.put("userNotExist", EnrollService.checkUserExist(idExisttDTO.getId()));
		// 로그작업//
		log = new Log();
		log.saveLog(idExisttDTO.getId() + " id search");
	 		
	   return retVal;
	}
	
	@RequestMapping(value = "/myenrolllistajax", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> myEnrollList(@RequestBody final MyEnrollSearchDTO myEnrollSearchdto) { 
		Map<String, Object> retVal = new HashMap<String, Object>();
		
		System.out.println(myEnrollSearchdto.getStuNumber()+" enroll list search");
		
		//나의 수강신청 리스트를 불러온다.//
		List<MyEnrollCourseDTO> myenrollist = null;
		
		myenrollist = MyEnrollCourseSearchService.searchmyenrollcourse(myEnrollSearchdto);
		
		System.out.println("list size: " + myenrollist.size());
		
		retVal.put("list", myenrollist);
		retVal.put("check", "ok");
		
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return retVal;
	}
	
	@RequestMapping(value = "/memoupdateajax", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> memoWrite(@RequestBody final MemoUpdateDTO memoupdatedto) { 
		Map<String, Object> retVal = new HashMap<String, Object>();
		boolean isCheck = false;
		
		System.out.println("memo update ajax call success...");
		
		//메모를 등록//
		isCheck = MemoUpdateService.memoupdateservice(memoupdatedto);
		
		retVal.put("check", ""+isCheck);
		
		return retVal;
	}
	
	@RequestMapping(value = "/deletecourseajax", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteCourse(@RequestBody final DeleteCourseDTO deletecoursedto) { 
		Map<String, Object> retVal = new HashMap<String, Object>();
		boolean isCheck = false;
		
		System.out.println("delete course ajax call success...");
		
		//과목제거 서비스 호출//
		isCheck = DeleteCourseService.deletecourseservice(deletecoursedto);
		
		retVal.put("check", ""+isCheck);
		
		return retVal;
	}
	
	@RequestMapping(value = "/courselistajax", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> courseList(@RequestBody final CourseListRequestDTO courserequestdto) { 
		Map<String, Object> retVal = new HashMap<String, Object>();
		boolean isCheck = false;
		
		System.out.println("course list ajax call success...");
		
		//수강신청 리스트를 불러온다.//
		List<CourseListDTO> courselistdto = null;
		
		courselistdto = CourseListGetService.courselistservice(courserequestdto);
		
		if(courselistdto != null){
			isCheck = true;
		}
		
		retVal.put("check", ""+isCheck);
		retVal.put("list", courselistdto);
		
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return retVal;
	}
	
	@RequestMapping(value = "/enrollcourseajax", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> enrollcourse(@RequestBody final EnrollCourseDTO enrollcoursedto) { 
		Map<String, Object> retVal = new HashMap<String, Object>();
		boolean isCheck = false;
		
		System.out.println("enroll course ajax call success...");
		
		//과목제거 서비스 호출//
		isCheck = EnrollCourseService.enrollcourseservice(enrollcoursedto);
		
		retVal.put("check", ""+isCheck);
		
		return retVal;
	}
}
