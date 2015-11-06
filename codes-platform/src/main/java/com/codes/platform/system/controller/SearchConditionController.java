package com.codes.platform.system.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.codes.platform.base.web.controller.EntityController;
import com.codes.platform.system.domain.SearchCondition;

/**
 * 搜索条件-控制层
 * 
 * @author ZhangGuangYong
 *
 *         2015年11月5日 下午5:15:46
 */
@Controller
@RequestMapping("system/SearchCondition")
public class SearchConditionController extends
		EntityController<SearchCondition, Integer> {

	
	
}
