package com.xasxt.ems.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.xasxt.ems.bean.Role;
import com.xasxt.ems.bean.User;

@Repository
public interface UserDaoMapper {
	
	User login(Map<String,Object> map);

	int getUserCount();

	List<User> findUserWithPage(Map<String, Object> map);

	int addUserInfo(User user);

	int removeUserInfo(int uId);

	User getUserInfoById(int uId);

	int editUserInfo(User user);

	int delRoleInfoByUserId(int uId);

	List<Role> findAllRoleInfo();

	int addUserOfRoleInfo(Map<String, Object> map);
}
