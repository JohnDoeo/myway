package com.xasxt.ems.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.xasxt.ems.bean.Question;
import com.xasxt.ems.bean.User;

@Repository
public interface QuestionDaoMapper {

	List<User> findAllTeacherReply();

	List<Question> findQuestionWithPage(Map<String, Object> map);

	int getQuestionCount();

	int addQuestionInfo(Question question);

	int removeQuestionInfo(int qId);

	Question getQuestionInfoById(int qId);

	int editQuestionInfo(Question question);

	int commitQuestion(Map<String,Object> map);

	List<Question> getQuestionList();
	
}
