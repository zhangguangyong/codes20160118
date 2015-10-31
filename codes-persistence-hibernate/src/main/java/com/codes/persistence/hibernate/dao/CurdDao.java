package com.codes.persistence.hibernate.dao;

import java.io.Serializable;

import com.codes.persistence.hibernate.domain.Entity;

/**
 * 增删改查 Data Access Object 
 * @author Administrator
 *
 * 2015年10月27日 下午5:51:44
 */
public interface CurdDao<T extends Entity<ID>, ID extends Serializable> {
	long count();

	void delete(ID id);

	void delete(Iterable<? extends T> entities);

	void delete(T entity);

	void deleteAll();

	boolean exists(ID id);

	Iterable<T> findAll();

	Iterable<T> findAll(Iterable<ID> ids);

	T findOne(ID id);

	Iterable<T> saveOrUpdate(Iterable<T> entities);

	T saveOrUpdate(T entity);
}