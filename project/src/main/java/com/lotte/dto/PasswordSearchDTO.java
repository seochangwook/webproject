package com.lotte.dto;

import java.io.Serializable;

public class PasswordSearchDTO implements Serializable{
	private String stuId;
	private String stuEmail;
	
	public String getStuId() {
		return stuId;
	}
	public void setStuId(String stuId) {
		this.stuId = stuId;
	}
	public String getStuEmail() {
		return stuEmail;
	}
	public void setStuEmail(String stuEmail) {
		this.stuEmail = stuEmail;
	}
	
	
}
