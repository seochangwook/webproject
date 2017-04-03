package com.lotte.dto;

import java.io.Serializable;

public class IdSearchDTO implements Serializable{
	private String stuNumber;
	private String stuName;
	
	public String getStuNumber() {
		return stuNumber;
	}
	public void setStuNumber(String stuNumber) {
		this.stuNumber = stuNumber;
	}
	public String getStuName() {
		return stuName;
	}
	public void setStuName(String stuName) {
		this.stuName = stuName;
	}
}
