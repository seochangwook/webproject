package com.lotte.dto;

import java.io.Serializable;

public class MyEnrollCourseDTO implements Serializable{
	private int c_number;
	private String c_name;
	private String pro_name;
	private String c_date_time;
	private int c_grade;
	private String c_memo;
	
	public int getC_number() {
		return c_number;
	}
	public void setC_number(int c_number) {
		this.c_number = c_number;
	}
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}
	public String getC_date_time() {
		return c_date_time;
	}
	public void setC_date_time(String c_date_time) {
		this.c_date_time = c_date_time;
	}
	public int getC_grade() {
		return c_grade;
	}
	public void setC_grade(int c_grade) {
		this.c_grade = c_grade;
	}
	public String getC_memo() {
		return c_memo;
	}
	public void setC_memo(String c_memo) {
		this.c_memo = c_memo;
	}
	public String getPro_name() {
		return pro_name;
	}
	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}
}
