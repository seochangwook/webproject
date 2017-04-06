package com.lotte.dto;

import java.io.Serializable;

public class EnrollCourseDTO implements Serializable{
	private String courseNum;
	private String stuNum;

	public String getCourseNum() {
		return courseNum;
	}
	public void setCourseNum(String courseNum) {
		this.courseNum = courseNum;
	}
	public String getStuNum() {
		return stuNum;
	}
	public void setStuNum(String stuNum) {
		this.stuNum = stuNum;
	}
}
