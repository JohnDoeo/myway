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

import com.xasxt.ems.bean.Leave;
import com.xasxt.ems.bean.Role;
import com.xasxt.ems.bean.User;
import com.xasxt.ems.service.LeaveService;

@RestController
public class LeaveController {

	@Autowired
	private LeaveService leaveService;
	
	@RequestMapping("findLeaveWithPage")
	public Map<String,Object> findLeaveWithPage(int page,int rows){
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
		result.put("rows", leaveService.findLeaveWithPage(map));
		result.put("total", leaveService.getLeaveCount());
		return result;
	}
	
	@RequestMapping("findAllTeacher")
	public List<User> findAllTeacher(){
		return leaveService.findAllTeacher();
	}
	
	@RequestMapping("addLeaveInfo")
	public boolean addLeaveInfo(Leave leave){
		User user = (User)SecurityUtils.getSubject().getSession().getAttribute("user");
		leave.setuId(user.getuId());
		leave.setAppState("未审核");
		if(leaveService.addLeaveInfo(leave)==0)
			return false;
		return true;
	}
	
	@RequestMapping("getLeaveInfoById")
	public Leave getLeaveInfoById(int lId){
		return leaveService.getLeaveInfoById(lId);
	}
	
	@RequestMapping("removeLeaveInfo")
	public boolean removeLeaveInfo(@RequestParam("lIds[]")int lIds[]){
		boolean flag = false;
		for(int lId : lIds){
			if(leaveService.removeLeaveInfo(lId)!=0){
				flag = true;
			}
		}
		return flag;
	}
	
	@RequestMapping("commitLeave")
	public boolean commitLeave(int lId){
		String commitTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("commitTime", commitTime);
		map.put("lId", lId);
		if(leaveService.commitLeave(map)==0)
			return false;
		return true;
	}
	
	@RequestMapping("editLeaveInfo")
	public boolean editLeaveInfo(Leave leave){
		boolean flag = false;
		if( leave.getAppContext()==null || leave.getAppContext().trim().equals("")){//判定为学生修改请假信息
			if(leaveService.editLeaveInfo(leave)!=0){
				flag = true;
			}
		}else{//老师审批后
			leave.setAppState("已审核");
			leave.setcState("0");
			leave.setAppTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			if(leaveService.editLeaveInfo(leave)!=0){
				flag = true;
			}
		}
		return flag;
	}
}
