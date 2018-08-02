package com.xasxt.ems.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xasxt.ems.bean.Course;
import com.xasxt.ems.bean.User;
import com.xasxt.ems.dao.CourseDaoMapper;

@Service
@Transactional
public class CourseService {

	@Autowired
	private CourseDaoMapper courseDaoMapper;

	public List<Course> findCourseWithPage(Map<String, Object> map) {
		return courseDaoMapper.findCourseWithPage(map);
	}

	public int getCourseCount() {
		return courseDaoMapper.getCourseCount();
	}

	public int addCourseInfo(Course course) {
		return courseDaoMapper.addCourseInfo(course);
	}

	public int removeCourseInfo(int cId) {
		return courseDaoMapper.removeCourseInfo(cId);
	}

	public Course getCourseInfoById(int cId) {
		return courseDaoMapper.getCourseInfoById(cId);
	}

	public int editCourseInfo(Course course) {
		return courseDaoMapper.editCourseInfo(course);
	}

	public List<User> getTeachTeacher() {
		return courseDaoMapper.getTeachTeacher();
	}
}
