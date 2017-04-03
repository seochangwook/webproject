package com.lotte.controller;

import java.io.File;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.lotte.dto.LoginDTO;

@Controller
public class AjaxController {
	//�쑀��媛��엯�쓣 �쐞�븳 �슂泥�//
	@RequestMapping(value = "/loginajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> login(@RequestBody final  LoginDTO logininfo) { 
		Map<String, Object> retVal = new HashMap<String, Object>();
		boolean is_insert_success = true;
		
		System.out.println("login ajax call (data: " + logininfo.getUserId() + "/" + logininfo.getUserPassword());
		
		//해당 로그인 관련 서비스 호출//
		System.out.println();
		System.out.println("백희원 커밋 테스트");
		retVal.put("check", ""+is_insert_success);
		
		return retVal;
	}
}
