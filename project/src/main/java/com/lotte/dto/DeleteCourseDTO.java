package com.lotte.dto;

import java.io.Serializable;

public class DeleteCourseDTO implements Serializable{
	private String stuNumber;
	private String deleteCourseNumber;
	
	public String getStuNumber() {
		return stuNumber;
	}
	public void setStuNumber(String stuNumber) {
		this.stuNumber = stuNumber;
	}
	public String getDeleteCourseNumber() {
		return deleteCourseNumber;
	}
	public void setDeleteCourseNumber(String deleteCourseNumber) {
		this.deleteCourseNumber = deleteCourseNumber;
	}
}
