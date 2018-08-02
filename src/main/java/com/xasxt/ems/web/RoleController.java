package com.xasxt.ems.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.xasxt.ems.service.RoleService;

@RestController
public class RoleController {

	@Autowired
	private RoleService roleService;
}
