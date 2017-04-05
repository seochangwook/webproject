package com.lotte.service;

import com.lotte.dao.EnrollDao;
import com.lotte.dto.StudentDTO;

public class EnrollService {	
	static EnrollDao enrollDao;
	public static boolean checkUserExist(String ID) {
		enrollDao = new EnrollDao();
		return enrollDao.checkUserExist(ID);
	}
	
	
	public static boolean enrollStudent(StudentDTO stuDTO){
		enrollDao = new EnrollDao();		
		return enrollDao.insertStudent(stuDTO);
	}

}
