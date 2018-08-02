package com.xasxt.ems.bean;

import java.io.Serializable;

/**
 * 功能：转班
 * 创建时间：2018年7月11日下午4:42:23
 * 创建人：John Doe
 */
public class ChangeClass implements Serializable {

	private int ccId;
	private int uId;
	private String uName;
	private int tId;
	private String tName;
	private String reasion;
	private String appTime;
	private String appContext;//审批内容
	private String appState;//审批状态
	private String remark;
	private String commitTime;
	private String state;
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getAppTime() {
		return appTime;
	}
	public void setAppTime(String appTime) {
		this.appTime = appTime;
	}
	public String getCommitTime() {
		return commitTime;
	}
	public void setCommitTime(String commitTime) {
		this.commitTime = commitTime;
	}
	public String getuName() {
		return uName;
	}
	public void setuName(String uName) {
		this.uName = uName;
	}
	public int gettId() {
		return tId;
	}
	public void settId(int tId) {
		this.tId = tId;
	}
	public String gettName() {
		return tName;
	}
	public void settName(String tName) {
		this.tName = tName;
	}
	public int getCcId() {
		return ccId;
	}
	public void setCcId(int ccId) {
		this.ccId = ccId;
	}
	public int getuId() {
		return uId;
	}
	public void setuId(int uId) {
		this.uId = uId;
	}
	public String getReasion() {
		return reasion;
	}
	public void setReasion(String reasion) {
		this.reasion = reasion;
	}
	public String getAppContext() {
		return appContext;
	}
	public void setAppContext(String appContext) {
		this.appContext = appContext;
	}
	public String getAppState() {
		return appState;
	}
	public void setAppState(String appState) {
		this.appState = appState;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
