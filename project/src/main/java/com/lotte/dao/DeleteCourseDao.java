package com.lotte.dao;

import java.io.InputStream;
import java.util.HashMap;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Repository;

import com.lotte.dto.DeleteCourseDTO;

@Repository
public class DeleteCourseDao {
	private static String res = "/mybatis-config.xml";
	private static String namespace = "procedurecourse";

	static SqlSessionFactory factory = null;
	static InputStream is = null;
	static SqlSession session = null;
	
	public static boolean deletecourse(DeleteCourseDTO deletecoursedto) {
		boolean isSuccess = false;
		
		try {		
			is = Resources.getResourceAsStream(res);
			factory = new SqlSessionFactoryBuilder().build(is);
			session = factory.openSession();
			
			HashMap<String,Object> parammap = new HashMap<String, Object>();
			
			parammap.put("in_pro_type", 2);
			parammap.put("in_stu_number", deletecoursedto.getStuNumber());
			parammap.put("in_c_number", deletecoursedto.getDeleteCourseNumber());
			parammap.put("in_c_memo", "");
			
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
