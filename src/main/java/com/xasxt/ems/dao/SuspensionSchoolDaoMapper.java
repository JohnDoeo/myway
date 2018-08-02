package com.xasxt.ems.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.xasxt.ems.bean.SuspensionSchool;

@Repository
public interface SuspensionSchoolDaoMapper {

	List<SuspensionSchool> findSuspensionSchoolWithPage(Map<String, Object> map);

	int getSuspensionSchoolCount();

	int addSuspensionSchoolInfo(SuspensionSchool suspensionSchool);

	int removeSuspensionSchoolInfo(int ssId);

	SuspensionSchool getSuspensionSchoolInfoById(int ssId);

	int editSuspensionSchoolClassInfo(SuspensionSchool suspensionSchool);

	int commitSuspensionSchool(Map<String,Object> map);
	
}
