package com.xasxt.ems.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xasxt.ems.bean.SuspensionSchool;
import com.xasxt.ems.dao.SuspensionSchoolDaoMapper;

@Service
@Transactional
public class SuspensionSchoolService {
	
	@Autowired
	private SuspensionSchoolDaoMapper suspensionSchoolDaoMapper;

	public List<SuspensionSchool> findSuspensionSchoolWithPage(Map<String, Object> map) {
		return suspensionSchoolDaoMapper.findSuspensionSchoolWithPage(map);
	}

	public int getSuspensionSchoolCount() {
		return suspensionSchoolDaoMapper.getSuspensionSchoolCount();
	}

	public int addSuspensionSchoolInfo(SuspensionSchool suspensionSchool) {
		return suspensionSchoolDaoMapper.addSuspensionSchoolInfo(suspensionSchool);
	}

	public int removeSuspensionSchoolInfo(int ssId) {
		return suspensionSchoolDaoMapper.removeSuspensionSchoolInfo(ssId);
	}

	public SuspensionSchool getSuspensionSchoolInfoById(int ssId) {
		return suspensionSchoolDaoMapper.getSuspensionSchoolInfoById(ssId);
	}

	public int editSuspensionSchoolClassInfo(SuspensionSchool suspensionSchool) {
		return suspensionSchoolDaoMapper.editSuspensionSchoolClassInfo(suspensionSchool);
	}

	public int commitSuspensionSchool(Map<String,Object> map) {
		return suspensionSchoolDaoMapper.commitSuspensionSchool(map);
	}

}
