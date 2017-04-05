package com.lotte.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.lotte.dto.MyEnrollCourseDTO;
import com.lotte.dto.StudentDTO;
import com.lotte.dto.StudentInfoDTO;
import com.lotte.service.MyEnrollCourseSearchService;
import com.lotte.service.StudentInfoService;

@Controller
public class MainController {
	@RequestMapping(value = "/mainpage", method = RequestMethod.POST)
	public ModelAndView mainpage(@RequestParam("stuId")String stuId) throws IOException {
		ModelAndView view = new ModelAndView();
		
		//사용자 정보 불러오기//
		StudentInfoDTO stuinfo = null;
		
		stuinfo = StudentInfoService.getstuInfoService(stuId);
		
		//나의 수강정보 리스트 불러오기//
		List<MyEnrollCourseDTO> myenrollist = null;
		myenrollist = MyEnrollCourseSearchService.searchmyenrollcourse(stuinfo.getStu_number());
		
		for(int i=0; i<myenrollist.size(); i++){
			System.out.println("m" + myenrollist.get(i).getC_name());
		}
		
		//리스트 매핑//
		view.addObject("listsubject", myenrollist); //html에 리스트에 매핑//
		
		view.addObject("userid", stuId);
		view.addObject("major", stuinfo.getDept_name());
		view.addObject("year", stuinfo.getStu_grade());
		view.addObject("birth", stuinfo.getStu_birth());
		view.addObject("gender", stuinfo.getStu_gender());
		view.addObject("address", stuinfo.getStu_address());
		view.addObject("email", stuinfo.getStu_email());
		view.addObject("phonenumber", stuinfo.getStu_phonenumber());
		view.addObject("imagefile", stuinfo.getStu_photo());
		view.addObject("stunumber", stuinfo.getStu_number());
		
		view.setViewName("/mainpageview");
		
		return view;
	}
}
