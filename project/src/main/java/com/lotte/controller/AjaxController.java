package com.lotte.controller;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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

import com.lotte.dto.IdSearchDTO;
import com.lotte.dto.LoginDTO;
import com.lotte.dto.PasswordSearchDTO;
import com.lotte.service.IdSearchService;
import com.lotte.service.LoginService;
import com.lotte.service.PasswordSearchService;

@Controller
@SessionAttributes("sessionId") //id라는 키로 저장된 attribute는 세션객체에 저장 됨
public class AjaxController {	
	@RequestMapping(value = "/loginajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> login(@RequestBody final  LoginDTO loginInfo, Model view) { 
		Map<String, Object> retVal = new HashMap<String, Object>();
		boolean loginSucces = false;
		
		System.out.println("login ajax call (data: " + loginInfo.getUserId() + "/" + loginInfo.getUserPassword()+")");
		
		//해당 로그인 관련 서비스 호출//
		if(LoginService.checkLogin(loginInfo)){
			//세션 적용//
			view.addAttribute("sessionId", loginInfo.getUserId());
			loginSucces = true;
		}
		
		System.out.println();		
		
		retVal.put("check", ""+loginSucces);
		return retVal;
	}
	
	@RequestMapping(value = "/logoutajax", method = RequestMethod.POST)
	public @ResponseBody String logout(@RequestBody @RequestParam("sessionid") String sessionid, SessionStatus status) { 
		boolean is_insert_success = false;
		
		System.out.println("session id: "  + sessionid);
		
		//세션종료//
		//SessionStatus는 스프링의 어노테이션으로 지원되는 @SessionAttributes의 세션을 만료시킨다.//
		status.setComplete();
		
		if(status.isComplete() == true){
			System.out.println("Session invalid success...");
			
			is_insert_success = true;
		}
		
		return ""+is_insert_success;
	}
	
	@RequestMapping(value = "/idsearchajax", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchId(@RequestBody final IdSearchDTO idsearchdto) { 
		Map<String, Object> retVal = new HashMap<String, Object>();
		String searchId = "";
		
		System.out.println("id search ajax call (data: "+idsearchdto.getStuName() + "/" + idsearchdto.getStuNumber()+")");
		
		//ID검색 비즈니스 로직 수행//
		searchId = IdSearchService.searchId(idsearchdto);
		
		retVal.put("id", searchId);
		
		return retVal;
	}
	
	@RequestMapping(value = "/passwordsearchajax", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchPassword(@RequestBody final PasswordSearchDTO passwordsearchdto) { 
		Map<String, Object> retVal = new HashMap<String, Object>();
		String searchPassword = "";
		String mesage = "";
		
		Random random = new Random();
		
		int authnumber = random.nextInt(1000);
		
		System.out.println("password search ajax call (data: "+passwordsearchdto.getStuEmail() + "/" + passwordsearchdto.getStuId()+")");
		
		//ID검색 비즈니스 로직 수행//
		searchPassword = PasswordSearchService.searchPassword(passwordsearchdto);
		
		//메일전송//
		String host = "smtp.naver.com";
		final String user = "scw0531";
		final String password = "tjckd246!dnr";

		String to = passwordsearchdto.getStuEmail();

		 // Get the session object
		 Properties props = new Properties();
		 
		 props.put("mail.smtp.host", host);
		 props.put("mail.smtp.auth", "true");

		 //세션 설정//
		 Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			 protected PasswordAuthentication getPasswordAuthentication() {
				 return new PasswordAuthentication(user, password);
			 }
		 });

		 // Compose the message
		 try {
			 //메세지 작성//
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
		
		return retVal;
	}
	
	class MyAuthentication extends Authenticator
    {
        PasswordAuthentication pa; //인증 클래스 선언.//

        public MyAuthentication()
        {
            String id = "scw0531";// 구글 ID
            String pw = "tjckd246!dnr";// 구글 비밀번호(2단계 적용)//

            // ID와 비밀번호를 입력한다.
            pa = new PasswordAuthentication(id, pw);
        }

        // 시스템에서 사용하는 인증정보
        public PasswordAuthentication getPasswordAuthentication()
        {
            return pa; //인증정보를 반환.//
        }
    }
}
