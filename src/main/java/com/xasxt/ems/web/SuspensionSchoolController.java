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

import com.xasxt.ems.bean.Role;
import com.xasxt.ems.bean.SuspensionSchool;
import com.xasxt.ems.bean.User;
import com.xasxt.ems.service.SuspensionSchoolService;

@RestController
public class SuspensionSchoolController {

	@Autowired
	private SuspensionSchoolService suspensionSchoolService;
	
	@RequestMapping("findSuspensionSchoolWithPage")
	public Map<String,Object> findSuspensionSchoolWithPage(int page,int rows){
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
		result.put("rows", suspensionSchoolService.findSuspensionSchoolWithPage(map));
		result.put("total", suspensionSchoolService.getSuspensionSchoolCount());
		return result;
	}
	
	@RequestMapping("addSuspensionSchoolInfo")
	public boolean addSuspensionSchoolInfo(SuspensionSchool suspensionSchool){
		User user = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
		suspensionSchool.setuId(user.getuId());
		if(suspensionSchoolService.addSuspensionSchoolInfo(suspensionSchool)==0)
			return false;
		return true;
	}
	
	@RequestMapping("removeSuspensionSchoolInfo")
	public boolean removeSuspensionSchoolInfo(@RequestParam("ssIds[]")int ssIds[]){
		boolean flag = false;
		for(int ssId : ssIds){
			if(suspensionSchoolService.removeSuspensionSchoolInfo(ssId)!=0){
				flag = true;
			}
		}
		return flag;
	}
	
	@RequestMapping("getSuspensionSchoolInfoById")
	public SuspensionSchool getSuspensionSchoolInfoById(int ssId){
		return suspensionSchoolService.getSuspensionSchoolInfoById(ssId);
	}
	
	@RequestMapping("editSuspensionSchoolInfo")
	public boolean editSuspensionSchoolInfo(SuspensionSchool suspensionSchool){
		//若审批内容不为空，则可以判定为教师审批
		if( suspensionSchool.getAppContext()!=null && !suspensionSchool.getAppContext().trim().equals("")){
			suspensionSchool.setAppTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			suspensionSchool.setState("0");
			suspensionSchool.setAppState("已审核");
		}else{
			User user = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
			suspensionSchool.setuId(user.getuId());
		}
		if(suspensionSchoolService.editSuspensionSchoolClassInfo(suspensionSchool)==0)
			return false;
		return true;
	}
	
	@RequestMapping("commitSuspensionSchool")
	public boolean commitSuspensionSchool(int ssId){
		String commitTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("commitTime", commitTime);
		map.put("ssId", ssId);
		if(suspensionSchoolService.commitSuspensionSchool(map)==0)
			return false;
		return true;
	}
}
