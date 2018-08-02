package com.xasxt.ems.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xasxt.ems.bean.ChangeClass;
import com.xasxt.ems.dao.ChangeClassDaoMapper;

@Service
@Transactional
public class ChangeClassService {

	@Autowired
	private ChangeClassDaoMapper changeClassDaoMapper;

	public List<ChangeClass> findChangeClassWithPage(Map<String, Object> map) {
		return changeClassDaoMapper.findChangeClassWithPage(map);
	}

	public int getChangeClassCount() {
		return changeClassDaoMapper.getChangeClassCount();
	}

	public int addChangeClassInfo(ChangeClass changeClass) {
		return changeClassDaoMapper.addChangeClassInfo(changeClass);
	}

	public int removeChangeClassInfo(int ccId) {
		return changeClassDaoMapper.removeChangeClassInfo(ccId);
	}

	public ChangeClass getChangeClassInfoById(int ccId) {
		return changeClassDaoMapper.getChangeClassInfoById(ccId);
	}

	public int editChangeClassInfo(ChangeClass changeClass) {
		return changeClassDaoMapper.editChangeClassInfo(changeClass);
	}

	public int commitChangeClass(Map<String,Object> map) {
		return changeClassDaoMapper.commitChangeClass(map);
	}
}
