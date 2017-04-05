package com.lotte.service;

import com.lotte.dao.DeleteCourseDao;
import com.lotte.dto.DeleteCourseDTO;

public class DeleteCourseService {

	public static boolean deletecourseservice(DeleteCourseDTO deletecoursedto) {
		boolean isCheck = false;
		
		isCheck = DeleteCourseDao.deletecourse(deletecoursedto);
		
		return isCheck;
	}

}
