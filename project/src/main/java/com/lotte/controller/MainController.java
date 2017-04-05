package com.lotte.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	@RequestMapping(value = "/mainpage", method = RequestMethod.POST)
	public ModelAndView mainpage(@RequestParam("stuId")String stuId) throws IOException {
		ModelAndView view = new ModelAndView();
		
		System.out.println("hidden id: " + stuId);
		
		//�궗�슜�옄 �젙蹂대�� 媛��졇�삩�떎.//
		view.addObject("userid", stuId);
		view.addObject("major", "컴퓨터공학부");
		view.addObject("year", "4");
		view.addObject("age", 26);
		view.addObject("birth", "92/04/06");
		view.addObject("gender", "남");
		view.addObject("address", "경기도 수원시 장안구");
		view.addObject("email", "scw05313315@gmail.com");
		view.addObject("phonenumber", "01042084757");
		view.addObject("imagefile", "seopicture.png");
		view.addObject("stunumber", "201158102");
		
		view.setViewName("/mainpageview");
		
		return view;
	}
}
