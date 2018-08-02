package com.xasxt.ems.bean;

import java.io.Serializable;

public class Role implements Serializable {

	private int rId;
	private String rName;
	private String rDesc;
	public int getrId() {
		return rId;
	}
	public void setrId(int rId) {
		this.rId = rId;
	}
	public String getrName() {
		return rName;
	}
	public void setrName(String rName) {
		this.rName = rName;
	}
	public String getrDesc() {
		return rDesc;
	}
	public void setrDesc(String rDesc) {
		this.rDesc = rDesc;
	}
	
}
