package com.codes.platform.system.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.codes.persistence.hibernate.domain.support.DefaultSupportEntity;

/**
 * 搜索条件
 * 
 * @author ZhangGuangYong
 *
 *         2015年11月5日 下午5:07:42
 */

@Entity
@Table(name = "tb_system_SearchCondition")
public class SearchCondition extends DefaultSupportEntity {
	/** 属性条件 */
	@Column
	private String properties;

	/** 排序条件 */
	@Column
	private String orders;

	/** 分页条件 */
	@Column
	private String pages;

	/** 对应的实体名称 */
	@Column
	private String entityName;

	public String getProperties() {
		return properties;
	}

	public String getOrders() {
		return orders;
	}

	public String getPages() {
		return pages;
	}

	public String getEntityName() {
		return entityName;
	}

	public void setProperties(String properties) {
		this.properties = properties;
	}

	public void setOrders(String orders) {
		this.orders = orders;
	}

	public void setPages(String pages) {
		this.pages = pages;
	}

	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}

}
