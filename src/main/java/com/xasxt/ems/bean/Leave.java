package com.xasxt.ems.bean;

import java.io.Serializable;

/**
 * 功能：请假
 * 创建时间：2018年7月11日下午4:35:58
 * 创建人：John Doe
 */
/**功能：
 * 创建时间：2018年7月17日下午12:30:25
 * 创建人：John Doe
 */
public class Leave implements Serializable {

	private int lId;
	private int uId;
	private String uName;
	private int tId;
	private String tName;
	private String cState;
	private String reasion;
	private String days;//请假天数
	private String appContext;//审批内容
	private String appState;//审批状态
	private String remark;
	private String appTime;
	private String commitTime;
	
	public String getCommitTime() {
		return commitTime;
	}
	public void setCommitTime(String commitTime) {
		this.commitTime = commitTime;
	}
	public String getAppTime() {
		return appTime;
	}
	public void setAppTime(String appTime) {
		this.appTime = appTime;
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
	public String getcState() {
		return cState;
	}
	public void setcState(String cState) {
		this.cState = cState;
	}
	public int getlId() {
		return lId;
	}
	public void setlId(int lId) {
		this.lId = lId;
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
