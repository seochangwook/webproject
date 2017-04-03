package com.lotte.service;

import com.lotte.dao.PasswordSearchDao;
import com.lotte.dto.PasswordSearchDTO;

public class PasswordSearchService {
	private static PasswordSearchDao passwordsearchdao;
	public static String searchPassword(PasswordSearchDTO passwordsearchdto) {
		passwordsearchdao = new PasswordSearchDao();
		
		String password = passwordsearchdao.searchPw(passwordsearchdto);
		
		return password;
	}
	
}
