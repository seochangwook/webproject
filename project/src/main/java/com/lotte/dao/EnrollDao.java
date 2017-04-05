package com.lotte.dao;

import java.io.InputStream;
import java.util.HashMap;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.lotte.dto.StudentDTO;
import com.lotte.util.DBUtil;

public class EnrollDao {
	
	private String namespace = "procedurestu";
	private String res = "/mybatis-config.xml";

	SqlSessionFactory factory = null;
	InputStream is = null;
	SqlSession session = null;	
	public boolean checkUserExist(String ID) {
		boolean userNotExist = false;
		try {
			is = Resources.getResourceAsStream(res);
			factory = new SqlSessionFactoryBuilder().build(is);
			session = factory.openSession();

			HashMap<String, Object> parammap = new HashMap<String, Object>();

			parammap.put("in_pro_type", 3);
			parammap.put("in_stu_id", ID);
			parammap.put("in_stu_name", "");
			parammap.put("in_stu_password","");
			parammap.put("in_stu_birth", "");
			parammap.put("in_stu_number", 0);
			parammap.put("in_stu_address", "");
			parammap.put("in_stu_deptno", 0);
			parammap.put("in_stu_grade", 0);
			parammap.put("in_stu_email", "");
			parammap.put("in_stu_phonenumber", "");
			parammap.put("in_stu_photo", "");

			session.selectList(namespace + ".p_userauth", parammap);
			// result print//
			System.out.println("result: " + parammap.get("out_result").toString());
			if (parammap.get("out_result").toString().equals("0")) {
				userNotExist = true;
			}
			else{
				userNotExist = false;
			}
		}

		catch (Exception ioe) {
			ioe.printStackTrace();
			userNotExist = false;
		}

		finally {
			session.commit();
			session.close();
		}
		
		return userNotExist;
	}	
	
	public boolean insertStudent(StudentDTO stuDTO) {
		boolean isSuccess = false;
		try {	
			is = Resources.getResourceAsStream(res);
			factory = new SqlSessionFactoryBuilder().build(is);
			session = factory.openSession();
			HashMap<String,Object> parammap = new HashMap<String, Object>();
			
			parammap.put("in_pro_type", 2);
			parammap.put("in_stu_id", stuDTO.getStuId());
			parammap.put("in_stu_name",stuDTO.getStuName());
			parammap.put("in_stu_password", stuDTO.getStuPassword());
			parammap.put("in_stu_birth", stuDTO.getStuBirth());
			parammap.put("in_stu_gender", stuDTO.getStuGender());
			parammap.put("in_stu_number", stuDTO.getStuNumber());
			parammap.put("in_stu_address", stuDTO.getStuAddress());
			parammap.put("in_stu_deptno", stuDTO.getDeptNo());
			parammap.put("in_stu_grade", stuDTO.getStuGrade());
			parammap.put("in_stu_email", stuDTO.getStuEmail());
			parammap.put("in_stu_phonenumber", stuDTO.getStuPhoneNumber());
			parammap.put("in_stu_photo", stuDTO.getStuPhoto());
		
			System.out.println("selectStart");
			System.out.println(stuDTO.toString());
			session.selectList(namespace+".p_userauth", parammap);
			System.out.println("selectEnd");
			//result print//
			System.out.println("result: " + parammap.get("out_result").toString());
			if(parammap.get("out_result").toString().equals("1")){
				isSuccess = true;
			}
			
			else if(parammap.get("out_result").toString().equals("-1")){
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
