package com.lotte.dao;

import java.io.InputStream;
import java.util.HashMap;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Repository;

import com.lotte.dto.LoginDTO;

@Repository
public class LoginDao {
	private String res = "/mybatis-config.xml";
	private String namespace = "procedure";

	SqlSessionFactory factory = null;
	InputStream is = null;
	SqlSession session = null;	
	
	public boolean checkLogin(LoginDTO loginDTO) {
		System.out.println("LoginDao");
		boolean isSuccess = false;
		try {		
		
			is = Resources.getResourceAsStream(res);
			System.out.println("2");
			factory = new SqlSessionFactoryBuilder().build(is);
			System.out.println("3");
			session = factory.openSession();
			System.out.println("4");
			
			HashMap<String,Object> parammap = new HashMap<String, Object>();
			
			parammap.put("in_pro_type", 1);
			parammap.put("in_stu_id", loginDTO.getUserId());
			parammap.put("in_stu_name","");
			parammap.put("in_stu_password", loginDTO.getUserPassword());
			parammap.put("in_stu_birth", "");
			parammap.put("in_stu_number", 0);
			parammap.put("in_stu_address", "");
			parammap.put("in_stu_deptno", 0);
			parammap.put("in_stu_grade", 0);
			parammap.put("in_stu_email", "");
			parammap.put("in_stu_phonenumber", "");
			parammap.put("in_stu_photo", "");
		
			System.out.println("selectStart");
			session.selectList(namespace+".p_userauth", parammap);
			System.out.println("selectEnd");
			//result print//
			System.out.println("result: " + parammap.get("out_result").toString());
			if(parammap.get("out_result").toString().equals("true")){
				isSuccess = true;
			}
			
			else if(parammap.get("out_result").toString().equals("false")){
				isSuccess = false;
			}
		}
		
		catch(Exception ioe){
			ioe.printStackTrace();			
			isSuccess = false;
		}
		
		finally{
			session.commit();
			session.close();
		}
		
		return isSuccess;
	}

}
