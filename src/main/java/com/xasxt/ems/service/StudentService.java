package com.xasxt.ems.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xasxt.ems.bean.Grade;
import com.xasxt.ems.bean.Student;
import com.xasxt.ems.dao.StudentDaoMapper;

@Service
@Transactional
public class StudentService {
	
	@Autowired
	private StudentDaoMapper studentDaoMapper;

	public List<Student> findStudentWithPage(Map<String, Object> map) {
		return studentDaoMapper.findStudentWithPage(map);
	}
	
	public int getStudentCount(){
		return studentDaoMapper.getStudentCount();
	}

	public List<Grade> getGradeList() {
		return studentDaoMapper.getGradeList();
	}

	public int addStudentInfo(Student student) {
		return studentDaoMapper.addStudentInfo(student);
	}

	public int getGradeIdByName(String gName) {
		return studentDaoMapper.getGradeIdByName(gName);
	}

	public Student getStudentById(int sId) {
		return studentDaoMapper.getStudentById(sId);
	}

	public int delStudentInfo(int sId) {
		return studentDaoMapper.delStudentInfo(sId);
	}

	public int editStudentInfo(Student student) {
		return studentDaoMapper.editStudentInfo(student);
	}

	public List<Student> getStudentListForState() {
		return studentDaoMapper.getStudentListForState(); 
	}

	

}
