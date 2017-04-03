package com.lotte.dao;

import java.io.InputStream;
import java.util.HashMap;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.lotte.dto.PasswordSearchDTO;

public class PasswordSearchDao {
	private String res = "/mybatis-config.xml";
	private String namespace = "procedurestu";

	SqlSessionFactory factory = null;
	InputStream is = null;
	SqlSession session = null;	

	public String searchPw(PasswordSearchDTO passwordsearchdto) {
		String searchpassword = "";
		
		try {		
			
			is = Resources.getResourceAsStream(res);
			factory = new SqlSessionFactoryBuilder().build(is);
			session = factory.openSession();
			
			HashMap<String,Object> parammap = new HashMap<String, Object>();
			
			parammap.put("in_pro_type", 6);
			parammap.put("in_stu_id", passwordsearchdto.getStuId());
			parammap.put("in_stu_name","");
			parammap.put("in_stu_password", "");
			parammap.put("in_stu_birth", "");
			parammap.put("in_stu_number", 0);
			parammap.put("in_stu_address", "");
			parammap.put("in_stu_deptno", 0);
			parammap.put("in_stu_grade", 0);
			parammap.put("in_stu_email", "");
			parammap.put("in_stu_phonenumber", "");
			parammap.put("in_stu_photo", "");
		
			session.selectList(namespace+".p_userauth", parammap);
			//result print//
			System.out.println("result: " + parammap.get("out_result").toString());
			
			if(parammap.get("out_result").toString().equals("-1")){
				searchpassword = "";
			}
			
			else{
				searchpassword = parammap.get("out_result").toString();
			}
		}
		
		catch(Exception ioe){
			ioe.printStackTrace();			
		}
		
		finally{
			session.commit();
			session.close();
		}
		return searchpassword;
	}

}
