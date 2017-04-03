package com.lotte.service;

import com.lotte.dao.LoginDao;
import com.lotte.dto.LoginDTO;

public class LoginService {
	private static LoginDao loginCheckDao;
	public static boolean checkLogin(LoginDTO loginDTO){
		loginCheckDao = new LoginDao();		
		
		return loginCheckDao.checkLogin(loginDTO);
	}
}
