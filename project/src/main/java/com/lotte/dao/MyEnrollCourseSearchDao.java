package com.lotte.dao;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Repository;

import com.lotte.dto.MyEnrollCourseDTO;
import com.lotte.dto.MyEnrollSearchDTO;

@Repository
public class MyEnrollCourseSearchDao {
	private static String res = "/mybatis-config.xml";
	private static String namespace = "sql";

	static SqlSessionFactory factory = null;
	static InputStream is = null;
	static SqlSession session = null;	
	
	public static List<MyEnrollCourseDTO> getmyenrolllist(MyEnrollSearchDTO myEnrollSearchdto) {
		List<MyEnrollCourseDTO> list = new ArrayList<MyEnrollCourseDTO>();
		StringBuffer buffer = new StringBuffer();
		
		try {
			//DB Session 愿�由�//
			is = Resources.getResourceAsStream(res);
			factory = new SqlSessionFactoryBuilder().build(is);
			session = factory.openSession();
		
			HashMap<String,Object> parammap = new HashMap<String, Object>();
			
			parammap.put("stuNumber", Integer.parseInt(myEnrollSearchdto.getStuNumber()));
			
			list = session.selectList(namespace+".myenrolllist", parammap); //留ㅺ컻蹂��닔濡� HashMap�쓣 �궗�슜//

			for(int i=0; i<list.size(); i++){
				buffer.append("course name: " + list.get(i).getC_name()+" / date time: "+ list.get(i).getC_date_time());
				
				System.out.println(buffer);
				
				buffer.setLength(0); //버퍼 초기화//
			}
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
		
		return list;
	}
	
}
