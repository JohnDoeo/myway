package com.xasxt.ems.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xasxt.ems.bean.Log;
import com.xasxt.ems.dao.LogDaoMapper;

@Service
@Transactional
public class LogService {

	@Autowired
	private LogDaoMapper logDaoMapper;

	public List<Log> findLogWithPage(Map<String, Object> map) {
		return logDaoMapper.findLogWithPage(map);
	}
	public int getLogCount(){
		return logDaoMapper.getLogCount();
	}
	
	public int addLogInfo(Log log){
		return logDaoMapper.addLogInfo(log);
	}
	public int updateLogInfo(Log log) {
		return logDaoMapper.updateLogInfo(log);
	}
	public List<Log> getLogList() {
		return logDaoMapper.getLogList();
	}
}
