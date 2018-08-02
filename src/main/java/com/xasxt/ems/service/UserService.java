package com.xasxt.ems.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xasxt.ems.bean.Role;
import com.xasxt.ems.bean.User;
import com.xasxt.ems.dao.UserDaoMapper;

@Service
@Transactional
public class UserService {

	@Autowired
	private UserDaoMapper userDaoMapper;
	
	public User login(Map<String,Object> map){
		return userDaoMapper.login(map);
	}

	public int getUserCount() {
		return userDaoMapper.getUserCount();
	}

	public List<User> findUserWithPage(Map<String, Object> map) {
		return userDaoMapper.findUserWithPage(map);
	}

	public int addUserInfo(User user) {
		return userDaoMapper.addUserInfo(user);
	}

	public int removeUserInfo(int uId) {
		return userDaoMapper.removeUserInfo(uId);
	}

	public User getUserInfoById(int uId) {
		return userDaoMapper.getUserInfoById(uId);
	}

	public int editUserInfo(User user) {
		return userDaoMapper.editUserInfo(user);
	}

	public List<Role> getRoleInfoByUserId(int uId) {
		User user = userDaoMapper.getUserInfoById(uId);
		List<Role> roleList = user.getRoleList();
		return roleList;
	}

	public int delRoleInfoByUserId(int uId) {
		return userDaoMapper.delRoleInfoByUserId(uId);
	}

	public List<Role> findAllRoleInfo() {
		return userDaoMapper.findAllRoleInfo();
	}

	public int addUserOfRoleInfo(Map<String, Object> map) {
		return userDaoMapper.addUserOfRoleInfo(map);
	}
}
