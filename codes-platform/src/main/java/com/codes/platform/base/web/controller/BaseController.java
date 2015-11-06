/**
 * Copyright (c) 2005-2012 https://github.com/zhangkaitao
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.codes.platform.base.web.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import com.codes.common.util.Jsons;


/**
 * 基础控制器
 * @author ZhangGuangYong
 *
 * 2015年11月5日 下午4:13:35
 */
public abstract class BaseController {
	
	public void writeJson(HttpServletResponse response, Object value){
		response.setContentType("application/x-json;charset=utf-8");
		writeText(response, Jsons.format(value));
	}

	public void writeText(HttpServletResponse response, String text){
		PrintWriter w = null;
		try {
			w = response.getWriter();
			w.write( text );
			w.flush();
			w.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
