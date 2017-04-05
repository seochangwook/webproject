package com.lotte.dto;

import java.io.Serializable;

public class StudentInfoDTO implements Serializable{
	private String stu_name;
	private String stu_birth;
	private String stu_gender;
	private String stu_number;
	private String stu_address;
	private String stu_grade;
	private String stu_email;
	private String stu_phonenumber;
	private String stu_photo;
	private String dept_name;
	
	public String getStu_name() {
		return stu_name;
	}
	public void setStu_name(String stu_name) {
		this.stu_name = stu_name;
	}
	public String getStu_birth() {
		return stu_birth;
	}
	public void setStu_birth(String stu_birth) {
		this.stu_birth = stu_birth;
	}
	public String getStu_gender() {
		return stu_gender;
	}
	public void setStu_gender(String stu_gender) {
		this.stu_gender = stu_gender;
	}
	public String getStu_number() {
		return stu_number;
	}
	public void setStu_number(String stu_number) {
		this.stu_number = stu_number;
	}
	public String getStu_address() {
		return stu_address;
	}
	public void setStu_address(String stu_address) {
		this.stu_address = stu_address;
	}
	public String getStu_grade() {
		return stu_grade;
	}
	public void setStu_grade(String stu_grade) {
		this.stu_grade = stu_grade;
	}
	public String getStu_email() {
		return stu_email;
	}
	public void setStu_email(String stu_email) {
		this.stu_email = stu_email;
	}
	public String getStu_phonenumber() {
		return stu_phonenumber;
	}
	public void setStu_phonenumber(String stu_phonenumber) {
		this.stu_phonenumber = stu_phonenumber;
	}
	public String getStu_photo() {
		return stu_photo;
	}
	public void setStu_photo(String stu_photo) {
		this.stu_photo = stu_photo;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
}
