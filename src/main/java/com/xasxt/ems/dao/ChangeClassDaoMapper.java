package com.xasxt.ems.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.xasxt.ems.bean.ChangeClass;

@Repository
public interface ChangeClassDaoMapper {

	List<ChangeClass> findChangeClassWithPage(Map<String, Object> map);

	int getChangeClassCount();

	int addChangeClassInfo(ChangeClass changeClass);

	int removeChangeClassInfo(int ccId);

	ChangeClass getChangeClassInfoById(int ccId);

	int editChangeClassInfo(ChangeClass changeClass);

	int commitChangeClass(Map<String,Object> map);
	
}
