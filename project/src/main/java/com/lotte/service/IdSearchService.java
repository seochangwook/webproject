package com.lotte.service;

import com.lotte.dao.IdSearchDao;
import com.lotte.dao.LoginDao;
import com.lotte.dto.IdSearchDTO;

public class IdSearchService {
	private static IdSearchDao idsearchdao;
	
	public static String searchId(IdSearchDTO idsearchdto) {
		idsearchdao = new IdSearchDao();
		
		String searchId = idsearchdao.searchId(idsearchdto);
		
		return searchId;
	}
	
}
