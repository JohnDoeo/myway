package com.xasxt.ems.bean;

import java.io.Serializable;

public class SuspensionSchool implements Serializable {

	private int ssId;
	private int uId;
	private String reasion;
	private String days;//休学天数
	private String appContext;//审核内容
	private String appState;//审核状态
	private String remark;
	private String uName;
	private int tId;
	private String tName;
	private String appTime;
	private String commitTime;
	private String state;
	
	
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
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
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
	public int getSsId() {
		return ssId;
	}
	public void setSsId(int ssId) {
		this.ssId = ssId;
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
	public String getDays() {
		return days;
	}
	public void setDays(String days) {
		this.days = days;
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
