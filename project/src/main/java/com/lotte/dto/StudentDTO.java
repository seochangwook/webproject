package com.lotte.dto;

import java.io.File;

public class StudentDTO {
	private String stuId;
	private String stuName;
	private String stuPassword;
	private String stuBirth;
	private String stuGender;
	private String stuNumber;
	private String stuAddress;
	private String deptNo;
	private int stuGrade;
	private String stuEmail;
	private String stuPhoneNumber;
	private String stuPhoto;
	
	public StudentDTO(){}
	public StudentDTO(String stuId, String stuName, String stuPassword, String stuBirth, String stuGender,
			String stuNumber, String stuAddress, String deptNo, String stuGrade, String stuEmail, String stuPhoneNumber,
			String stuPhoto) {
		this.stuId = stuId;
		this.stuName = stuName;
		this.stuPassword = stuPassword;
		this.stuBirth = stuBirth;
		this.stuGender = stuGender;
		this.stuNumber = stuNumber;
		this.stuAddress = stuAddress;
		this.deptNo = deptNo;
		this.stuGrade = Integer.parseInt(stuGrade);
		this.stuEmail = stuEmail;
		this.stuPhoneNumber = stuPhoneNumber;
		this.stuPhoto = stuPhoto;		
	}	
	
	public String getStuId() {
		return stuId;
	}
	public void setStuId(String stuId) {
		this.stuId = stuId;
	}
	public String getStuName() {
		return stuName;
	}
	public void setStuName(String stuName) {
		this.stuName = stuName;
	}
	public String getStuPassword() {
		return stuPassword;
	}
	public void setStuPassword(String stuPassword) {
		this.stuPassword = stuPassword;
	}
	public String getStuBirth() {
		return stuBirth;
	}
	public void setStuBirth(String stuBirth) {
		this.stuBirth = stuBirth;
	}
	public String getStuGender() {
		return stuGender;
	}
	public void setStuGender(String stuGender) {
		this.stuGender = stuGender;
	}
	public String getStuNumber() {
		return stuNumber;
	}
	public void setStuNumber(String stuNumber) {
		this.stuNumber = stuNumber;
	}
	public String getStuAddress() {
		return stuAddress;
	}
	public void setStuAddress(String stuAddress) {
		this.stuAddress = stuAddress;
	}
	public String getDeptNo() {
		return deptNo;
	}
	public void setDeptNo(String deptNo) {
		this.deptNo = deptNo;
	}
	public int getStuGrade() {
		return stuGrade;
	}
	public void setStuGrade(int stuGrade) {
		this.stuGrade = stuGrade;
	}
	public String getStuEmail() {
		return stuEmail;
	}
	public void setStuEmail(String stuEmail) {
		this.stuEmail = stuEmail;
	}
	public String getStuPhoneNumber() {
		return stuPhoneNumber;
	}
	public void setStuPhoneNumber(String stuPhoneNumber) {
		this.stuPhoneNumber = stuPhoneNumber;
	}
	public String getStuPhoto() {
		return stuPhoto;
	}
	public void setStuPhoto(String stuPhoto) {
		this.stuPhoto = stuPhoto;
	}
	@Override
	public String toString() {
		return "StudentDTO [stuId=" + stuId + ", stuName=" + stuName + ", stuPassword=" + stuPassword + ", stuBirth="
				+ stuBirth + ", stuGender=" + stuGender + ", stuNumber=" + stuNumber + ", stuAddress=" + stuAddress
				+ ", deptNo=" + deptNo + ", stuGrade=" + stuGrade + ", stuEmail=" + stuEmail + ", stuPhoneNumber="
				+ stuPhoneNumber + ", stuPhoto=" + stuPhoto + "]";
	} 
	
}
