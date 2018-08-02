package com.xasxt.ems.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.xasxt.ems.bean.Course;
import com.xasxt.ems.bean.User;
import com.xasxt.ems.service.CourseService;

@RestController
public class CourseController {

	@Autowired
	private CourseService courseService;
	
	@RequestMapping("findCourseWithPage")
	public Map<String,Object> findCourseWithPage(int page,int rows){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("page", (page-1)*rows);
		map.put("rows", rows);
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("total", courseService.getCourseCount());
		result.put("rows", courseService.findCourseWithPage(map) );
		return result;
	}
	
	@RequestMapping("addCourseInfo")
	public int addCourseInfo(Course course){
		int flag = 0;
		try {
			flag = courseService.addCourseInfo(course);
		} catch (Exception e) {
			return -1;
		}
		return flag;
	}
	
	@RequestMapping("removeCourseInfo")
	public boolean removeCourseInfo(@RequestParam("cIds[]")int cIds[]){
		boolean flag = false;
		for(int cId : cIds){
			if(courseService.removeCourseInfo(cId)!=0){
				flag = true;
			}
		}
		return flag;
	}
	
	@RequestMapping("getCourseInfoById")
	public Course getCourseInfoById(int cId){
		return courseService.getCourseInfoById(cId);
	}
	
	@RequestMapping("editCourseInfo")
	public boolean editCourseInfo(Course course){
		if(courseService.editCourseInfo(course)==0)
			return false;
		return true;
	}
	
	@RequestMapping("getTeachTeacher")
	public List<User> getTeachTeacher(){
		return courseService.getTeachTeacher();
	}
}
