package com.lotte.service;

import java.util.List;

import com.lotte.dao.CourseListDao;
import com.lotte.dto.CourseListDTO;
import com.lotte.dto.CourseListRequestDTO;

public class CourseListGetService {

	public static List<CourseListDTO> courselistservice(CourseListRequestDTO courserequestdto) {
		List<CourseListDTO> courselistdto = null;
		
		courselistdto = CourseListDao.getcourselist(courserequestdto);
		
		return courselistdto;
	}
	
}
