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
		
		view.addObject("userid", stuId);
		view.addObject("major", "컴퓨터공학과");
		view.addObject("year", "4");
		
		view.addObject("imagefile", "seopicture.png");
		
		view.setViewName("/mainpageview");
		
		return view;
	}
}
