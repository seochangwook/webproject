package com.util.lotte;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;

public class FileUtil {
	public static BufferedReader makeOutputConnection(String file_name){
		FileInputStream fileInputStream = null;
		InputStreamReader inputStreamReader = null;
		BufferedReader bufferedReader = null;
		
		try {
			fileInputStream = new FileInputStream(file_name);
			inputStreamReader = new InputStreamReader(fileInputStream, "UTF-8"); //korean language error fix//
			bufferedReader = new BufferedReader(inputStreamReader);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return bufferedReader;
	}
	
	public static OutputStreamWriter makeInputConnection(String file_name){
		OutputStream os = null;
		DataOutputStream out = null;
		OutputStreamWriter osw = null;
		
		try {
			os = new FileOutputStream(file_name, true);
			out = new DataOutputStream(os);
			osw = new OutputStreamWriter(out);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		return osw;
	}
}
