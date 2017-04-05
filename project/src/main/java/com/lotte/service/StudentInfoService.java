package com.lotte.service;

import com.lotte.dao.StudentDao;
import com.lotte.dto.StudentDTO;
import com.lotte.dto.StudentInfoDTO;

public class StudentInfoService {

	public static StudentInfoDTO getstuInfoService(String stuId) {
		StudentInfoDTO stuinfo = null;
		
		stuinfo = StudentDao.getStuinfo(stuId);
		
		return stuinfo;
	}
	
}
