package com.lotte.service;

import com.lotte.dao.MemoUpdateDao;
import com.lotte.dto.MemoUpdateDTO;

public class MemoUpdateService {

	public static boolean memoupdateservice(MemoUpdateDTO memoupdatedto) {
		boolean isCheck = false;
		
		isCheck = MemoUpdateDao.memoupdate(memoupdatedto);
		
		return isCheck;
	}

}
