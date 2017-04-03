package com.lotte.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import com.lotte.dto.LoginDTO;
import com.lotte.service.LoginService;

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
}
