package com.xasxt.ems.test;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Test {
	public static void main(String[] args) {
		String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		long time2 = new Date().getTime();
		System.out.println(time);
		System.out.println(time2);
	}
}
