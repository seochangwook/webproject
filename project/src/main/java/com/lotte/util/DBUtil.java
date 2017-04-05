package com.lotte.util;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class DBUtil {
	private static String res = "/mybatis-config.xml";

	static SqlSessionFactory factory = null;
	static InputStream is = null;
	static SqlSession session = null;
	
	static{
		try {
			is = Resources.getResourceAsStream(res);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		factory = new SqlSessionFactoryBuilder().build(is);
		session = factory.openSession();
	}
	public static SqlSession getSqlSession(){
		return session;
	}

}
