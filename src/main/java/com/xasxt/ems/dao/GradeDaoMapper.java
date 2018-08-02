package com.xasxt.ems.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.xasxt.ems.bean.Grade;

@Repository
public interface GradeDaoMapper {

	int getGradeCount();

	List<Grade> findGradeWithPage(Map<String, Object> map);

	int addGradeInfo(Grade grade);

	int removeGradeInfo(int gradeId);

	Grade getGradeInfoById(int gradeId);

	int editGradeInfo(Grade grade);

	List<Grade> getAllGrade();
	
}
