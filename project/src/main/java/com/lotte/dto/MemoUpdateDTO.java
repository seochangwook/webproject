package com.lotte.dto;

import java.io.Serializable;

public class MemoUpdateDTO implements Serializable{
	private String memoCnumber;
	private String stuNumber;
	private String memoStr;
	public String getMemoCnumber() {
		return memoCnumber;
	}
	public void setMemoCnumber(String memoCnumber) {
		this.memoCnumber = memoCnumber;
	}
	public String getStuNumber() {
		return stuNumber;
	}
	public void setStuNumber(String stuNumber) {
		this.stuNumber = stuNumber;
	}
	public String getMemoStr() {
		return memoStr;
	}
	public void setMemoStr(String memoStr) {
		this.memoStr = memoStr;
	}
	
	
}
