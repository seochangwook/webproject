package com.lotte.dao;

import java.io.InputStream;
import java.util.HashMap;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Repository;

import com.lotte.dto.MemoUpdateDTO;

@Repository
public class MemoUpdateDao {
	private static String res = "/mybatis-config.xml";
	private static String namespace = "procedurecourse";

	static SqlSessionFactory factory = null;
	static InputStream is = null;
	static SqlSession session = null;	
	
	public static boolean memoupdate(MemoUpdateDTO memoupdatedto) {
		boolean isSuccess = false;
		
		try {		
			is = Resources.getResourceAsStream(res);
			factory = new SqlSessionFactoryBuilder().build(is);
			session = factory.openSession();
			
			HashMap<String,Object> parammap = new HashMap<String, Object>();
			
			parammap.put("in_pro_type", 3);
			parammap.put("in_stu_number", memoupdatedto.getStuNumber());
			parammap.put("in_c_number", memoupdatedto.getMemoCnumber());
			parammap.put("in_c_memo", memoupdatedto.getMemoStr());
			
			session.selectList(namespace+".p_courseauth", parammap);
			//result print//
			
			System.out.println("call result: " + parammap.get("out_result").toString());
			
			if(parammap.get("out_result").toString().equals("1")){
				return true;
			}
			
			else{
				return false;
			}
		}
		
		catch(Exception ioe){
			ioe.printStackTrace();			
		}
		
		finally{
			session.commit();
			session.close();
		}
		
		return isSuccess;
	}

}
