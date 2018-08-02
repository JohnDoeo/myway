package com.xasxt.ems.bean;

import java.io.Serializable;

public class Student implements Serializable {

	/**功能：
	 * 创建时间：2018年7月12日下午1:32:13
	 * 创建人：John Doe
	 */
	private static final long serialVersionUID = 1L;
	private int sId;
	private int uId;
	private int gradeId;//所在班级
	private String gName;
	private String sNum;//学生编号
	private String sName;
	private String sTel;//联系电话
	private String school;//毕业学校
	private String major;//专业
	private String idCard;//身份证
	private String graduateTime;//毕业时间
	private String eState;//就业状态
	private String sex;
	private String employmentDate;//就业日期
	private String company;
	private String remark;//备注
	private int count;
	private String uName;
	private String sexs;
	
	
	public String getSexs() {
		return sexs;
	}
	public void setSexs(String sexs) {
		this.sexs = sexs;
	}
	public String getuName() {
		return uName;
	}
	public void setuName(String uName) {
		this.uName = uName;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getgName() {
		return gName;
	}
	public void setgName(String gName) {
		this.gName = gName;
	}
	public String getsNum() {
		return sNum;
	}
	public void setsNum(String sNum) {
		this.sNum = sNum;
	}
	public String getsName() {
		return sName;
	}
	public void setsName(String sName) {
		this.sName = sName;
	}
	
	public String getsTel() {
		return sTel;
	}
	public void setsTel(String sTel) {
		this.sTel = sTel;
	}
	public String geteState() {
		return eState;
	}
	public void seteState(String eState) {
		this.eState = eState;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public int getsId() {
		return sId;
	}
	public void setsId(int sId) {
		this.sId = sId;
	}
	public int getuId() {
		return uId;
	}
	public void setuId(int uId) {
		this.uId = uId;
	}
	public int getGradeId() {
		return gradeId;
	}
	public void setGradeId(int gradeId) {
		this.gradeId = gradeId;
	}
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public String getGraduateTime() {
		return graduateTime;
	}
	public void setGraduateTime(String graduateTime) {
		this.graduateTime = graduateTime;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getEmploymentDate() {
		return employmentDate;
	}
	public void setEmploymentDate(String employmentDate) {
		this.employmentDate = employmentDate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
