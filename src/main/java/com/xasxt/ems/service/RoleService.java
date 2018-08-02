package com.xasxt.ems.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xasxt.ems.dao.RoleDaoMapper;

@Service
@Transactional
public class RoleService {

	@Autowired
	private RoleDaoMapper roleDaoMapper;
	
}
