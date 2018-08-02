package com.xasxt.ems.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.xasxt.ems.bean.Leave;
import com.xasxt.ems.bean.User;

@Repository
public interface LeaveDaoMapper {

	List<Leave> findLeaveWithPage(Map<String, Object> map);

	int getLeaveCount();

	List<User> findAllTeacher();

	int addLeaveInfo(Leave leave);

	Leave getLeaveInfoById(int lId);

	int removeLeaveInfo(int lId);

	int commitLeave(Map<String,Object> map);

	int editLeaveInfo(Leave leave);
	
}
