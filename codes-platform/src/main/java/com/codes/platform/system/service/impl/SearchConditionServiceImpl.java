package com.codes.platform.system.service.impl;

import org.springframework.stereotype.Service;

import com.codes.platform.base.service.impl.EntityServiceImpl;
import com.codes.platform.system.domain.SearchCondition;
import com.codes.platform.system.service.SearchConditionService;

/**
 * 搜索条件-业务接口实现
 * 
 * @author ZhangGuangYong
 *
 *         2015年11月5日 下午5:14:37
 */
@Service
public class SearchConditionServiceImpl extends
		EntityServiceImpl<SearchCondition, Integer> implements
		SearchConditionService {

}
