package com.xasxt.ems.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.xasxt.ems.bean.Grade;
import com.xasxt.ems.bean.Student;

@Repository
public interface StudentDaoMapper {

	List<Student> findStudentWithPage(Map<String, Object> map);
	
	int getStudentCount();

	List<Grade> getGradeList();

	int addStudentInfo(Student student);

	int getGradeIdByName(String gName);

	List<Student> listAll();

	Student getStudentById(int sId);

	int delStudentInfo(int sId);

	int editStudentInfo(Student student);

	List<Student> getStudentListForState();
	
}
