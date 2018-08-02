package com.xasxt.ems.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.xasxt.ems.bean.ChangeClass;
import com.xasxt.ems.bean.Role;
import com.xasxt.ems.bean.User;
import com.xasxt.ems.service.ChangeClassService;

/**
 * 功能：学生可以提交转班的信息，班主任可以对学生的转班信息就行审核回复
 * 创建时间：2018年7月16日下午10:14:56
 * 创建人：John Doe
 */
@RestController
public class ChangeClassController {

	@Autowired
	private ChangeClassService changeClassService;
	
	@RequestMapping("findChangeClassWithPage")
	public Map<String,Object> findChangeClassWithPage(int page,int rows){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("page", (page-1)*rows);
		map.put("rows", rows);
		User user = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
		List<Role> roleList = user.getRoleList();
		for(Role role : roleList){
			if(role.getrName().equals("3")){//学生
				map.put("uId", user.getuId());
			}else if(role.getrName().equals("4")){//班主任
				map.put("tId", user.getuId());
			}
		}
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("rows", changeClassService.findChangeClassWithPage(map));
		result.put("total", changeClassService.getChangeClassCount());
		return result;
	}
	
	@RequestMapping("addChangeClassInfo")
	public boolean addChangeClassInfo(ChangeClass changeClass){
		User user = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
		changeClass.setuId(user.getuId());
		if(changeClassService.addChangeClassInfo(changeClass)==0)
			return false;
		return true;
	}
	
	@RequestMapping("removeChangeClassInfo")
	public boolean removeChangeClassInfo(@RequestParam("ccIds[]")int ccIds[]){
		boolean flag = false;
		for(int ccId : ccIds){
			if(changeClassService.removeChangeClassInfo(ccId)!=0){
				flag = true;
			}
		}
		return flag;
	}
	
	@RequestMapping("getChangeClassInfoById")
	public ChangeClass getChangeClassInfoById(int ccId){
		return changeClassService.getChangeClassInfoById(ccId);
	}
	
	@RequestMapping("editChangeClassInfo")
	public boolean editChangeClassInfo(ChangeClass changeClass){
		//若审批内容不为空，则可以判定为教师审批
		if( changeClass.getAppContext()!=null && !changeClass.getAppContext().trim().equals("")){
			changeClass.setAppTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			changeClass.setState("0");
			changeClass.setAppState("已审核");
		}else{
			User user = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
			changeClass.setuId(user.getuId());
		}
		if(changeClassService.editChangeClassInfo(changeClass)==0)
			return false;
		return true;
	}
	
	@RequestMapping("commitChangeClass")
	public boolean commitChangeClass(int ccId){
		String commitTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("commitTime", commitTime);
		map.put("ccId", ccId);
		if(changeClassService.commitChangeClass(map)==0)
			return false;
		return true;
	}
	
}
