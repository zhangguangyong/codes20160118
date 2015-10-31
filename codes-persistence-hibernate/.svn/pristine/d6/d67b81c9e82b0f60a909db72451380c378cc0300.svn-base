package com.codes.persistence.hibernate.dao.impl;

import static com.codes.common.util.$.notEmpty;
import static com.codes.common.util.$.notNull;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Order;

import com.codes.persistence.hibernate.dao.PagingAndSortingDao;
import com.codes.persistence.hibernate.domain.Entity;
import com.codes.persistence.hibernate.domain.Page;
import com.codes.persistence.hibernate.domain.PageImpl;
import com.codes.persistence.hibernate.domain.Pageable;
import com.codes.persistence.hibernate.domain.Sort;

/**
 * 分页和排序的实现
 * @author ZhangGuangYong
 *
 * 2015年10月27日 下午9:58:20
 */
@SuppressWarnings("all")
public class PagingAndSortingDaoImpl<T extends Entity<ID>, ID extends Serializable>
		extends CurdDaoImpl<T, ID> implements PagingAndSortingDao<T, ID> {

	@Override
	public Page<T> findAll(Pageable pageable) {
		long count = count();
		if (count > 0) {
			List content = setPage(createCriteria(), pageable).list();
			return new PageImpl<T>(count, content);
		}
		return null;
	}

	@Override
	public Iterable<T> findAll(Sort sort) {
		return setSort(createCriteria(), sort).list();
	}

	/**
	 * 设置分页参数
	 * @param criteria
	 * @param pageable
	 * @return
	 */
	protected Criteria setPage(Criteria criteria, Pageable pageable) {
		int pageNumber = pageable.getPageNumber() - 1;
		int pageSize = pageable.getPageSize();

		criteria.setFirstResult(pageNumber * pageSize).setMaxResults(pageSize);
		setSort(criteria, pageable.getSort());

		return criteria;
	}

	/**
	 * 设置排序参数
	 * @param criteria
	 * @param sort
	 * @return
	 */
	protected Criteria setSort(Criteria criteria, Sort sort) {
		if (notNull(sort)) {
			List<Order> orders = sort.getOrders();
			if (notEmpty(orders)) {
				for (Order order : orders) {
					criteria.addOrder(order);
				}
			}
		}
		return criteria;
	}
}
