package com.xasxt.ems.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.xasxt.ems.bean.Log;

@Repository
public interface LogDaoMapper {

	List<Log> findLogWithPage(Map<String, Object> map);
	
	int getLogCount();

	int addLogInfo(Log log);

	int updateLogInfo(Log log);

	List<Log> getLogList();
	
}
