package com.lotte.dao;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Repository;

import com.lotte.dto.StudentDTO;
import com.lotte.dto.StudentInfoDTO;

@Repository
public class StudentDao {
	private static String res = "/mybatis-config.xml";
	private static String namespace = "sql";

	static SqlSessionFactory factory = null;
	static InputStream is = null;
	static SqlSession session = null;
	
	public static StudentInfoDTO getStuinfo(String stuId) {
		StudentInfoDTO studto = new StudentInfoDTO();
		
		try {
			//DB Session 愿�由�//
			is = Resources.getResourceAsStream(res);
			factory = new SqlSessionFactoryBuilder().build(is);
			session = factory.openSession();
		
			HashMap<String,Object> parammap = new HashMap<String, Object>();
			
			parammap.put("stuNumber", stuId);
			
			studto = session.selectOne(namespace+".stuinfo", parammap); //留ㅺ컻蹂��닔濡� HashMap�쓣 �궗�슜//
			
			//정보를 출력//
			StringBuffer buffer = new StringBuffer();
			
			buffer.append(studto.getStu_name() + "\n");
			buffer.append(studto.getStu_address() + "\n");
			buffer.append(studto.getStu_birth() + "\n");
			buffer.append(studto.getStu_email() + "\n");
			buffer.append(studto.getStu_gender() + "\n");
			buffer.append(studto.getStu_grade() + "\n");
			buffer.append(studto.getStu_number() + "\n");
			buffer.append(studto.getStu_photo() + "\n");
			buffer.append(studto.getDept_name() + "\n");
			buffer.append(studto.getStu_phonenumber() + "\n");
			
			System.out.println(buffer);
		}
		
		catch(IOException ioe){
			ioe.printStackTrace();
		}
		
		catch(Exception e){
			e.printStackTrace();
		}
		
		finally{
			//�옄�썝諛섑솚//
			session.commit();
			session.close();
		}
		
		return studto;
	}
	
	
}
