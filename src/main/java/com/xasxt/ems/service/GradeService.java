package com.xasxt.ems.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xasxt.ems.bean.Grade;
import com.xasxt.ems.dao.GradeDaoMapper;

@Service
@Transactional
public class GradeService {

	@Autowired
	private GradeDaoMapper gradeDaoMapper;

	public int getGradeCount() {
		return gradeDaoMapper.getGradeCount();
	}

	public List<Grade> findGradeWithPage(Map<String, Object> map) {
		return gradeDaoMapper.findGradeWithPage(map);
	}

	public int addGradeInfo(Grade grade) {
		return gradeDaoMapper.addGradeInfo(grade);
	}

	public int removeGradeInfo(int gradeId) {
		return gradeDaoMapper.removeGradeInfo(gradeId);
	}

	public Grade getGradeInfoById(int gradeId) {
		return gradeDaoMapper.getGradeInfoById(gradeId);
	}

	public int editGradeInfo(Grade grade) {
		return gradeDaoMapper.editGradeInfo(grade);
	}

	public List<Grade> getAllGrade() {
		return gradeDaoMapper.getAllGrade();
	}
}
