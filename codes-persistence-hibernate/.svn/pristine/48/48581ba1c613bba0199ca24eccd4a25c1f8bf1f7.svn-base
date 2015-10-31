package com.codes.persistence.hibernate.dao;

import java.util.List;
import java.util.Map;

import com.codes.persistence.hibernate.domain.Page;
import com.codes.persistence.hibernate.domain.Pageable;

/**
 * Hibernate HQL 接口
 * @author ZhangGuangYong
 *
 * 2015年10月31日 下午3:02:13
 */
public interface HqlDao extends Dao {
	
	// 对数据库的读取----------------------------------------------------
	List<?> find(String ql);
	
	List<?> find(String ql, Object arg0, Object...rest);
	
	List<?> find(String ql, Object[] args);
	
	List<?> find(String ql, Map<String, Object> namedParameter);
	
	List<?> find(QueryParameterWrap parameterWrap);
	
	// 分页
	Page<?> findForPage(String ql, Pageable pageable);
	
	Page<?> findForPage(String ql, Pageable pageable, Object arg0, Object...rest);
	
	Page<?> findForPage(String ql, Pageable pageable, Object[] args);
	
	Page<?> findForPage(String ql, Pageable pageable, Map<String, Object> namedParameter);
	
	Page<?> findForPage(QueryParameterWrap parameterWrap);
	
	// 对数据库的写入----------------------------------------------------
	int update(String ql);
	
	int update(String ql, Object[] args);
	
	int update(String ql, Object arg0, Object...rest);
	
	int update(String ql, Map<String, Object> namedParameter);
	
	int update(QueryParameterWrap parameterWrap);
	
}
