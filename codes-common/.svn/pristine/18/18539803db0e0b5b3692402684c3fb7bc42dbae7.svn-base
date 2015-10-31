package com.codes.common.util;

import java.lang.reflect.Field;
import java.util.List;

public abstract class BeanUtils {

	/**
	 * 复制源的非空属性到目标对应的属性，但是不覆盖目标的非空属性
	 * @param from
	 * @param to
	 */
	public static void copyNonNullPropertiesWithNotCovered(Object from, Object to){
		copyProperties(from, to, false, false);
	}

	/**
	 * 复制源对象不为空的属性
	 * @param from
	 * @param to
	 */
	public static void copyNonNullProperties(Object from, Object to){
		copyProperties(from, to, false, true);
	}

	/**
	 * 复制源(from)对象的属性到目标(to)对象上去
	 * @param from 源对象
	 * @param to 目标对象
	 * @param fromPropertyIsNull	是否复制源对象为Null的属性(true:复制，false:不复制)
	 * @param toNonNullPropertyIsCovered 是否覆盖目标对象不为Null的属性(true:覆盖,false:不覆盖)
	 */
	public static void copyProperties(Object from, Object to, boolean fromPropertyIsNull, boolean toNonNullPropertyIsCovered){
		Assert.notNull(from);
		Assert.notNull(to);
		List<Field> fields = ReflectionUtils.getDeclaredFields(to.getClass());
		if( ObjectUtils.isEmpty(fields) ){
			return;
		}
		
		Object fromValue = null;
		Class<? extends Object> toClass = to.getClass();
		Field toField = null;
		for (Field field : fields) {
			try {
				field.setAccessible(true);
				fromValue = field.get(from);
				toField = ReflectionUtils.getDeclaredField(toClass, field.getName());
				if( null != toField ){
					toField.setAccessible(true);
					Object toValue = toField.get(to);
					//不成立的情况：源对象属性不能为空
					if( !fromPropertyIsNull && null == fromValue ){
						continue;
					}
					if( !toNonNullPropertyIsCovered && null != toValue ){
					 	continue;
					}
					
					//如果允许复制源对象为Null的属性，同时也允许覆盖目标对象不为Null的属性
					// fromPropertyIsNull: true, toNonNullPropertyIsCovered：true
					if( fromPropertyIsNull && toNonNullPropertyIsCovered ){
						toField.set(to, fromValue);
						continue;
					}
					
					// fromPropertyIsNull: false, toNonNullPropertyIsCovered：true
					if( !fromPropertyIsNull && null != fromValue ){
						toField.set(to, fromValue);
						continue;
					}
					
					// fromPropertyIsNull: false, toNonNullPropertyIsCovered：false
					if( null == toValue && null != fromValue ){
						toField.set(to, fromValue);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
