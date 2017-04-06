package com.lotte.service;

import com.lotte.dao.EnrollCourseDao;
import com.lotte.dto.EnrollCourseDTO;

public class EnrollCourseService {

	public static boolean enrollcourseservice(EnrollCourseDTO enrollcoursedto) {
		boolean isCheck = EnrollCourseDao.enrollcourse(enrollcoursedto);
		
		return isCheck;
	}
	
}
