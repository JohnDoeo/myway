package com.xasxt.ems.web;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.xasxt.ems.bean.Log;
import com.xasxt.ems.bean.Role;
import com.xasxt.ems.bean.User;
import com.xasxt.ems.service.LogService;
import com.xasxt.ems.service.UserService;

@RestController
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private LogService logService;
	
	@RequestMapping("login")
	public String login(String uName,String uPass ,HttpServletRequest req){
		Subject subject = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(uName, uPass);
		if(!subject.isAuthenticated()){
			try {
				subject.login(token);
			}catch(UnknownAccountException e){
				System.out.println("用户名不匹配");
				return "-1";
			}catch(IncorrectCredentialsException e){
				System.out.println("密码输入错误");
				return "0";
			}catch(AuthenticationException e){
				System.out.println("认证失败");
				return "-2";
			}finally{//添加登陆日志
				String ip = req.getRemoteAddr();
				String loginTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
				Session session = subject.getSession();
				session.setAttribute("loginTime", loginTime);
				User user = (User)subject.getSession().getAttribute("user");
				if(user!=null){
					int uId = user.getuId();
					Log log = new Log();
					log.setIp(ip);
					log.setLoginTime(loginTime);
					log.setuId(uId);
					if(logService.addLogInfo(log)==0)
						System.out.println("添加日志失败");
					System.out.println("添加日志成功");
				}
			}
		}
		return "1";
	}
	
	@RequestMapping("logout")
	public void logout(HttpServletRequest request,HttpServletResponse response) throws IOException{
		Log log = new Log();
		Subject subject = SecurityUtils.getSubject();
		String loginTime = (String)subject.getSession().getAttribute("loginTime");
		log.setLoginTime(loginTime);
		log.setLogoutTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		if(logService.updateLogInfo(log)==0){
			System.out.println("更新日志失败");
		}else{
			System.out.println("更新日志成功");
		}
		subject.logout();
		response.sendRedirect(request.getContextPath()+"/login.jsp");
	}
	
	@RequestMapping("findUserWithPage")
	public Map<String,Object> findUserWithPage(int page,int rows){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("page", (page-1)*rows);
		map.put("rows", rows);
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("total", userService.getUserCount());
		result.put("rows", userService.findUserWithPage(map));
		return result;
	}
	
	@RequestMapping("addUserInfo")
	public int addUserInfo(User user){
		int flag = 0;
		try {
			flag = userService.addUserInfo(user);
		} catch (Exception e) {
			return -1;
		}
		return flag;
	}
	
	@RequestMapping("removeUserInfo")
	public boolean removeUserInfo(@RequestParam("uIds[]")int uIds[]){
		boolean flag = false;
		for(int uId : uIds){
			if(userService.removeUserInfo(uId)!=0){
				flag = true;
			}
		}
		return flag;
	}
	
	@RequestMapping("getUserInfoById")
	public User getUserInfoById(int uId){
		return userService.getUserInfoById(uId);
	}
	
	@RequestMapping("editUserInfo")
	public int editUserInfo(User user){
		int flag = 0;
		try {
			flag = userService.editUserInfo(user);
		} catch (Exception e) {
			return -1;
		}
		return flag;	
	}
	
	@RequestMapping("getRoleInfoByUserId")
	public List<Role> getRoleInfoByUserId(int uId){
		return userService.getRoleInfoByUserId(uId);
	}
	
	@RequestMapping("delRoleInfoByUserId")
	public boolean delRoleInfoByUserId(int uId){
		if(userService.delRoleInfoByUserId(uId)==0)
			return false;
		return true;
	}
	
	@RequestMapping("findAllRoleInfo")
	public List<Role> findAllRoleInfo(){
		return userService.findAllRoleInfo();
	}
	
	@RequestMapping("addUserOfRoleInfo")
	public boolean addUserOfRoleInfo(int uId,int rIds[]){
		boolean flag = false;
		for(int rId : rIds){
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("uId", uId);
			map.put("rId", rId);
			if(userService.addUserOfRoleInfo(map)!=0){
				flag = true;
			}
		}
		return flag;
	}
}
