package com.xasxt.ems.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xasxt.ems.bean.Leave;
import com.xasxt.ems.bean.User;
import com.xasxt.ems.dao.LeaveDaoMapper;

@Service
@Transactional
public class LeaveService {

	@Autowired
	private LeaveDaoMapper leaveDaoMapper;

	public List<Leave> findLeaveWithPage(Map<String, Object> map) {
		return leaveDaoMapper.findLeaveWithPage(map);
	}

	public int getLeaveCount() {
		return leaveDaoMapper.getLeaveCount();
	}

	public List<User> findAllTeacher() {
		return leaveDaoMapper.findAllTeacher();
	}

	public int addLeaveInfo(Leave leave) {
		return leaveDaoMapper.addLeaveInfo(leave);
	}

	public Leave getLeaveInfoById(int lId) {
		return leaveDaoMapper.getLeaveInfoById(lId);
	}

	public int removeLeaveInfo(int lId) {
		return leaveDaoMapper.removeLeaveInfo(lId);
	}

	public int commitLeave(Map<String,Object> map) {
		return leaveDaoMapper.commitLeave(map);
	}

	public int editLeaveInfo(Leave leave) {
		return leaveDaoMapper.editLeaveInfo(leave);
	}
	
}
