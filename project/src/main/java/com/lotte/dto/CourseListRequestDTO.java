package com.lotte.dto;

import java.io.Serializable;

public class CourseListRequestDTO implements Serializable{
	private String deptno;

	public String getDeptno() {
		return deptno;
	}

	public void setDeptno(String deptno) {
		this.deptno = deptno;
	}
}
