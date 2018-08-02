package com.xasxt.ems.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;

import com.xasxt.ems.bean.Role;
import com.xasxt.ems.bean.User;
import com.xasxt.ems.service.UserService;

public class MyRealm extends AuthorizingRealm {

	@Autowired
	private UserService userService;
	
	/**
	 * 功能：认证方法
	 * 创建时间：2018年7月11日上午10:50:25
	 * 创建人：John Doe
	 * @param token
	 * @return
	 * @throws AuthenticationException
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String uName = (String)token.getPrincipal();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("uName", uName);
		User user = login(map);
		SimpleAuthenticationInfo info = null;
		if(user != null){
			Subject subject = SecurityUtils.getSubject();
			Session session = subject.getSession();
			session.setAttribute("user", user);
			info = new SimpleAuthenticationInfo(user.getuName(), user.getuPass(), super.getName());
		}
		return info;
	}
	
	public User login(Map<String,Object> map){
		return userService.login(map);
	}
	
	/**
	 * 功能：授权方法
	 * 创建时间：2018年7月11日上午10:50:37
	 * 创建人：John Doe
	 * @param principals
	 * @return
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		String uName = (String)principals.getPrimaryPrincipal();
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("uName", uName);
		User user = login(map);
		List<String> roleNames = new ArrayList<String>();
		if(user!=null){
			List<Role> roles = user.getRoleList();
			for(Role role : roles){
				roleNames.add(role.getrName());
			}
			info.addRoles(roleNames);
		}
		return info;
	}
}
