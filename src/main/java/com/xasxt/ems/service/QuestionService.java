package com.xasxt.ems.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xasxt.ems.bean.Question;
import com.xasxt.ems.bean.User;
import com.xasxt.ems.dao.QuestionDaoMapper;

@Service
@Transactional
public class QuestionService {

	@Autowired
	private QuestionDaoMapper questionDaoMapper;

	public List<User> findAllTeacherReply() {
		return questionDaoMapper.findAllTeacherReply();
	}

	public List<Question> findQuestionWithPage(Map<String, Object> map) {
		return questionDaoMapper.findQuestionWithPage(map);
	}

	public int getQuestionCount() {
		return questionDaoMapper.getQuestionCount();
	}

	public int addQuestionInfo(Question question) {
		return questionDaoMapper.addQuestionInfo(question);
	}

	public int removeQuestionInfo(int qId) {
		return questionDaoMapper.removeQuestionInfo(qId);
	}

	public Question getQuestionInfoById(int qId) {
		return questionDaoMapper.getQuestionInfoById(qId);
	}

	public int editQuestionInfo(Question question) {
		return questionDaoMapper.editQuestionInfo(question);
	}

	public int commitQuestion(Map<String,Object> map) {
		return questionDaoMapper.commitQuestion(map);
	}

	public List<Question> getQuestionList() {
		return questionDaoMapper.getQuestionList();
	}
}
