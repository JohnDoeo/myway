package com.xasxt.ems.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.xasxt.ems.bean.Log;
import com.xasxt.ems.service.LogService;

@RestController
public class LogController {

	@Autowired
	private LogService logService;
	
	@RequestMapping("findLogWithPage")
	public Map<String,Object> findLogWithPage(int page,int rows){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("page", (page-1)*rows);
		map.put("rows", rows);
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("rows", logService.findLogWithPage(map));
		result.put("total", logService.getLogCount());
		return result;
	}
	
	@RequestMapping("logMapCount")
	public Map<String,Object> logMapCount(String flag){
		Map<String,Object> result = new HashMap<String,Object>();
		List<Log> list = logService.getLogList();
		if(flag.equals("zhu")){
			List<String> countList = new ArrayList<String>();
			List<String> nameList = new ArrayList<String>();
			for(Log log : list){
				countList.add(log.getLoginCount());
				nameList.add(log.getuName());
			}
			result.put("countList", countList);
			result.put("nameList", nameList);
		}else if(flag.equals("bing")){
			List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
			List<String> nameList = new ArrayList<String>();
			for(Log log : list){
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("name", log.getuName());
				map.put("value", log.getLoginCount());
				nameList.add(log.getuName());
				resultList.add(map);
			}
			result.put("resultList", resultList);
			result.put("nameList", nameList);
		}
		return result;
	}
}
