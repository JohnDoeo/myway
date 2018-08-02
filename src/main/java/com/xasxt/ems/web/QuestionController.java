package com.xasxt.ems.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.xasxt.ems.bean.Question;
import com.xasxt.ems.bean.Role;
import com.xasxt.ems.bean.User;
import com.xasxt.ems.service.QuestionService;

@RestController
public class QuestionController {

	@Autowired
	private QuestionService questionService;
	
	/**
	 * 功能：获得所有教师(包括班主任和老师)信息
	 * 创建时间：2018年7月16日下午10:09:45
	 * 创建人：John Doe
	 * @return
	 */
	@RequestMapping("findAllTeacherReply")
	public List<User> findAllTeacherReply(){
		return questionService.findAllTeacherReply();
	}
	
	/**
	 * 功能：根据用户的角色信息和分页信息查询问题列表
	 * 创建时间：2018年7月16日下午10:10:26
	 * 创建人：John Doe
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("findQuestionWithPage")
	public Map<String,Object> findQuestionWithPage(int page,int rows){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("page", (page-1)*rows);
		map.put("rows", rows);
		User user = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
		List<Role> list = user.getRoleList();
		for(Role role : list){
			if(role.getrName().equals("3")){//学生
				map.put("uId", user.getuId());
			}
			if(role.getrName().equals("4") || role.getrName().equals("2")){//教师或者班主任
				map.put("tId", user.getuId());
			}
		}
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("rows", questionService.findQuestionWithPage(map));
		result.put("total", questionService.getQuestionCount());
		return result;
	}
	
	/**
	 * 功能：学生添加问题信息
	 * 创建时间：2018年7月16日下午10:11:10
	 * 创建人：John Doe
	 * @param question
	 * @return
	 */
	@RequestMapping("addQuestionInfo")
	public boolean addQuestionInfo(Question question){
		User user = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
		question.setuId(user.getuId());
		question.setQuestionTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		if(questionService.addQuestionInfo(question)!=0)
			return true;
		return false;
	}
	
	/**
	 * 功能：学生删除问题信息
	 * 创建时间：2018年7月16日下午10:11:26
	 * 创建人：John Doe
	 * @param qIds
	 * @return
	 */
	@RequestMapping("removeQuestionInfo")
	public boolean removeQuestionInfo(@RequestParam("qIds[]")int qIds[]){
		boolean flag = false;
		for(int qId : qIds){
			if(questionService.removeQuestionInfo(qId)!=0){
				flag = true;
			}
		}
		return flag;
	}
	
	/**
	 * 功能：通过问题的id查询问题信息
	 * 创建时间：2018年7月16日下午10:11:42
	 * 创建人：John Doe
	 * @param qId
	 * @return
	 */
	@RequestMapping("getQuestionInfoById")
	public Question getQuestionInfoById(int qId){
		return questionService.getQuestionInfoById(qId);
	}
	
	/**
	 * 功能：修改问题信息；
	 * 				学生修改问题内容
	 * 				教师回复学生问题
	 * 创建时间：2018年7月16日下午10:12:04
	 * 创建人：John Doe
	 * @param question
	 * @return
	 */
	@RequestMapping("editQuestionInfo")
	public boolean editQuestionInfo(Question question){
		if(question.getReply()==null || question.getReply().trim().equals("")){//判定为学生修改问题
			question.setQuestionTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		}else{//老师回复问题
			question.setState("0");
			question.setReplyTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		}
		if(questionService.editQuestionInfo(question)==0)
			return false;
		return true;
	}
	
	/**
	 * 功能：学生提交问题信息
	 * 创建时间：2018年7月16日下午10:13:18
	 * 创建人：John Doe
	 * @param qIds
	 * @return
	 */
	@RequestMapping("commitQuestion")
	public boolean commitQuestion(@RequestParam("qIds[]")int qIds[]){
		boolean flag = false;
		for(int qId : qIds){
			String questionTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("questionTime", questionTime);
			map.put("qId", qId);
			if(questionService.commitQuestion(map)!=0){
				flag = true;
			}
		}
		return flag;
	}
	
	@RequestMapping("questionCount")
	public Map<String,Object> questionCount(String flag){
		Map<String,Object> result = new HashMap<String,Object>();
		List<Question> list = questionService.getQuestionList();
		List<Map<String,Object>> mapList = new ArrayList<Map<String,Object>>();
		List<String> nameList = new ArrayList<String>();
		List<String> countList = new ArrayList<String>();
		for(Question question : list){
			Map<String,Object> map = new HashMap<String,Object>();
			nameList.add(question.getType());
			countList.add(question.getCount());
			map.put("name", question.getType());
			map.put("value", question.getCount());
			mapList.add(map);
		}
		if(flag.equals("zhu")){
			result.put("countList", countList);
			result.put("nameList", nameList);
		}else if(flag.equals("bing")){
			result.put("nameList", nameList);
			result.put("mapList", mapList);
		}
		return result;
	}
}
