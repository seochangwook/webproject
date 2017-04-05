package com.lotte.service;

import java.util.List;

import com.lotte.dao.MyEnrollCourseSearchDao;
import com.lotte.dto.MyEnrollCourseDTO;
import com.lotte.dto.MyEnrollSearchDTO;

public class MyEnrollCourseSearchService {

	public static List<MyEnrollCourseDTO> searchmyenrollcourse(MyEnrollSearchDTO myEnrollSearchdto) {
		List<MyEnrollCourseDTO> myenrolllist = MyEnrollCourseSearchDao.getmyenrolllist(myEnrollSearchdto);
		
		return myenrolllist;
	}

	public static List<MyEnrollCourseDTO> searchmyenrollcourse(String stu_number) {
		List<MyEnrollCourseDTO> myenrolllist = MyEnrollCourseSearchDao.getmyenrolllist(stu_number);
		
		return myenrolllist;
	}
	
}
