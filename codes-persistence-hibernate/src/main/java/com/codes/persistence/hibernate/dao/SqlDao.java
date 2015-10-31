package com.codes.persistence.hibernate.dao;

import java.util.List;
import java.util.Map;

import com.codes.persistence.hibernate.domain.Page;
import com.codes.persistence.hibernate.domain.Pageable;

public interface SqlDao extends Dao {
	
	// 对数据库的读取----------------------------------------------------
	List<?> find(String sql);
	
	List<?> find(String sql, Object arg0, Object...rest);
	
	List<?> find(String sql, Object[] args);
	
	List<?> find(String sql, Map<String, Object> namedParameter);
	
	List<?> find(SqlQueryParameterWrap sqlQueryParameterWrap);
	
	// 单行单列->返回Object
	String findForObject(String sql);
	
	<T> T findForObject(String sql, Class<T> requiredType);
	
	<T> T findForObject(String sql, Class<T> requiredType, Object[] args);
	
	<T> T findForObject(String sql, Class<T> requiredType, Object arg0, Object...rest);
	
	<T> T findForObject(String sql, Class<T> requiredType, Map<String, Object> namedParameter);
	
	// 单行多列->返回Map
	Map<String, Object> findForMap(String sql);
	
	Map<String, Object> findForMap(String sql, Object[] args);
	
	Map<String, Object> findForMap(String sql, Object arg0, Object...rest);
	
	Map<String, Object> findForMap(String sql, Map<String, Object> namedParameter);
	
	// 多行单列->返回单值集合
	<T> List<T> findForList(String sql, Class<T> elementType);
	
	<T> List<T> findForList(String sql, Class<T> elementType, Object[] args);
	
	<T> List<T> findForList(String sql, Class<T> elementType, Object arg0, Object...rest);
	
	<T> List<T> findForList(String sql, Class<T> elementType, Map<String, Object> namedParameter);
	
	// 分页
	Page<?> find(String sql, Pageable pageable);
	
	Page<?> find(String sql, Pageable pageable, Object arg0, Object...rest);
	
	Page<?> find(String sql, Pageable pageable, Object[] args);
	
	Page<?> find(String sql, Pageable pageable, Map<String, Object> namedParameter);
	
	Page<?> find(Pageable pageable, SqlQueryParameterWrap sqlQueryParameterWrap);
	
	// 对数据库的写入----------------------------------------------------
	int update(String sql);
	
	int update(String sql, Object[] args);
	
	int update(String sql, Object arg0, Object...rest);
	
	int update(String sql, Map<String, Object> namedParameter);
	
	int update(SqlQueryParameterWrap sqlQueryParameterWrap);
	
	// 对数据库的批量写入
	int[] batchUpdate(String...sqls);
	
	int[] batchUpdate(String sql, List<Object[]> argsList);
	
	
	
	
}
