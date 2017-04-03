package com.lotte.controller;

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
		
		int authnumber = random.nextInt();
		
		System.out.println("password search ajax call (data: "+passwordsearchdto.getStuEmail() + "/" + passwordsearchdto.getStuId()+")");
		
		//ID검색 비즈니스 로직 수행//
		searchPassword = PasswordSearchService.searchPassword(passwordsearchdto);
		
		//메일전송//
		//메일 전송을 위한 기본 포맷을 정의.//
        Properties p = System.getProperties();

        p.put("mail.smtp.starttls.enable", "true");//메일전송규약은 SMTP프로토콜을 따른다.//
        p.put("mail.smtp.host", "smtp.naver.com");// smtp 서버 주소 -> 구글메일.//
        p.put("mail.smtp.auth", "true");// 인증허용.//
        p.put("mail.smtp.port", "465");// 포트설정.//
        p.put("mail.smtp.ssl.trust", "smtp.naver.com");
        Authenticator auth = new MyAuthentication(); //인증을 위한 절차.//
        
        
        //인증은 구글의 일반 비밀번호가 아닌 2단계의 비밈번호가 필요.//
        //후에 사용자 등록과정에서 구글과 연동됨을 보이고, 사용자로 하여금 구글에 가입하도록 유도.//

        // session 생성 및  MimeMessage생성
        //메일을 구성하기 위한 여러가지 클래스 선언.//
        //MIME은 전자우편 포맷이다.//
        Session session = Session.getDefaultInstance(p, auth);
        MimeMessage msg = new MimeMessage(session);
        
        try
        {
            long now = System.currentTimeMillis(); //현재 시간을 구하기 위해서 사용.유닉스 기반의 Time사용//
            Date date = new Date(now);

            SimpleDateFormat time_format = new SimpleDateFormat("yyyy/MM/d HH:mm:ss");
            String time_now = time_format.format(date);

            //SMTP방식으로 해당 사용자 메일기반으로 보낸다.//
            msg.setSentDate(new Date());

            InternetAddress from = new InternetAddress();

            from = new InternetAddress("scw0531@naver.com"); //도메인 주소로 입력.//
            // 이메일 발신자
            msg.setFrom(from);

            // 이메일 수신자
            InternetAddress to = new InternetAddress(passwordsearchdto.getStuEmail());
            msg.setRecipient(Message.RecipientType.TO, to);

            // 이메일 제목, 인코딩 타입은 UTF-8로 설정.//
            msg.setSubject("롯데대학교 수강신청 시스템", "UTF-8");

            //전송 메시지 설정.//
            mesage = "Date : "+time_now+"\n"+mesage + "[인증번호: " + authnumber + "]";

            // 이메일 내용
            msg.setText(mesage, "UTF-8");

            // 이메일 헤더 - html형식의 헤더를 구성.//
            //내부적으로 html코드로 만들어서 전송.//
            msg.setHeader("content-Type", "text/html");

            // 메일보내기 -> 해당 send()과정은 네트워크 작업이므로 UI스레드와 분리되야 하기에 AsyncTask<>로 수행.//
            javax.mail.Transport.send(msg);
        }

        catch (AddressException addr_e)
        {
            addr_e.printStackTrace();
        }

        catch (MessagingException msg_e)
        {
            msg_e.printStackTrace();
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
