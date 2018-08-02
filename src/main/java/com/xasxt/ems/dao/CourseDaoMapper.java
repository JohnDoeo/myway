package com.xasxt.ems.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.xasxt.ems.bean.Course;
import com.xasxt.ems.bean.User;

@Repository
public interface CourseDaoMapper {

	List<Course> findCourseWithPage(Map<String, Object> map);

	int getCourseCount();

	int addCourseInfo(Course course);

	int removeCourseInfo(int cId);

	Course getCourseInfoById(int cId);

	int editCourseInfo(Course course);

	List<User> getTeachTeacher();
	
}
