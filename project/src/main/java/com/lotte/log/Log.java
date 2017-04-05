package com.lotte.log;

import java.io.File;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.Calendar;

import com.util.lotte.FileUtil;

public class Log {
	static File path = new File("src\\main\\resources\\log.txt");
	public static final String SCHEDULE_FILE_LOCATION = path.getAbsolutePath();	
	
	/** Log data setting **/
	public static String getCurrentDate()
	{
		String currentDate = "";
		
		Calendar calendar = Calendar.getInstance(); //current time/date info setting//
		
		//get date/time//
		String year = new Integer(calendar.get(Calendar.YEAR)).toString();
		String month = new Integer(calendar.get(Calendar.MONTH)+1).toString();
		String day = new Integer(calendar.get(Calendar.DATE)).toString();
		String hour = new Integer(calendar.get(Calendar.HOUR)).toString();
		String minute = new Integer(calendar.get(Calendar.MINUTE)).toString();
		
		if(month.trim().length() ==1)
		{
			month = "0"+month;
		}
		
		if(day.trim().length() ==1)
		{
			day = "0"+day;
		}
		
		currentDate = month+"/"+day+"/"+year+" - "+hour+":"+minute;
		
		return currentDate;
	}
	
	public void saveLog(String log_content){
		String logContent = "["+Log.getCurrentDate()+"] " + log_content;
		
		OutputStreamWriter osw = FileUtil.makeInputConnection(SCHEDULE_FILE_LOCATION);
		
		try {
			osw.write(logContent + "\n"+"------------------------------------------------------"+"\n");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		finally{
			try {
				osw.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
