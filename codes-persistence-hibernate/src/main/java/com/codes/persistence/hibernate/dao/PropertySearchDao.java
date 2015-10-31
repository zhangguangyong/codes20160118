package com.codes.persistence.hibernate.dao;

import java.util.List;

import com.codes.persistence.hibernate.criteria.Condition;
import com.codes.persistence.hibernate.domain.Page;
import com.codes.persistence.hibernate.domain.Pageable;
import com.codes.persistence.hibernate.domain.Sort;

/**
 * 实体属性搜索DAO，底层是Hibernate的Criteria查询
 * @author ZhangGuangYong
 *
 * 2015年10月31日 下午4:19:06
 */
public interface PropertySearchDao {
	List<?> search(Condition cond, Class<?> persistentClass);

	List<?> search(Condition cond, Class<?> persistentClass, Sort sort);
	
	Page<?> search(Condition cond, Class<?> persistentClass, Pageable pageable);
	
}
