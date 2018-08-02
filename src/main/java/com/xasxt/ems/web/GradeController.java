package com.xasxt.ems.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.xasxt.ems.bean.Grade;
import com.xasxt.ems.service.GradeService;

@RestController
public class GradeController {

	@Autowired
	private GradeService gradeService;
	
	@RequestMapping("findGradeWithPage")
	public Map<String,Object> findGradeWithPage(int page,int rows,String gName,String startTime,String endTime,String classType,String state){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("page", (page-1)*rows);
		map.put("rows", rows);
		map.put("gName", gName);
		map.put("startTime", startTime);
		map.put("endTime", endTime);
		map.put("classType", classType);
		map.put("state", state);
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("total", gradeService.getGradeCount());
		result.put("rows", gradeService.findGradeWithPage(map));
		return result;
	}
	
	@RequestMapping("addGradeInfo")
	public int addGradeInfo(Grade grade){
		int flag = 0;
		try {
			flag = gradeService.addGradeInfo(grade);
		} catch (Exception e) {
			return -1;
		}
		return flag;
	}
	
	@RequestMapping("removeGradeInfo")
	public boolean removeGradeInfo(@RequestParam("gradeIds[]")int gradeIds[]){
		boolean flag = false;
		for(int gradeId : gradeIds){
			if(gradeService.removeGradeInfo(gradeId)!=0){
				flag = true;
			}
		}
		return flag;
	}
	
	@RequestMapping("getGradeInfoById")
	public Grade getGradeInfoById(int gradeId){
		return gradeService.getGradeInfoById(gradeId);
	}
	
	@RequestMapping("editGradeInfo")
	public boolean editGradeInfo(Grade grade){
		if(gradeService.editGradeInfo(grade)==0)
			return false;
		return true;
	}
	
	@RequestMapping("getAllGrade")
	public List<Grade> getAllGrade(){
		return gradeService.getAllGrade();
	}
}
