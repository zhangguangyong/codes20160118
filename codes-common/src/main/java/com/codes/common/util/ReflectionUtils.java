package com.codes.common.util;

import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 反射工具类
 * @author zhangguangyong
 * 2015年6月2日 下午1:44:24
 */
public class ReflectionUtils {
	
	/**
	 * 公共字段获取
	 * @param clazz
	 * @return
	 */
	public static List<Field> getFields(Class<?> clazz){
		return getFields(clazz, true);
	}
	
	private static List<Field> getFields(Class<?> clazz, boolean deep){
		List<Field> ret = new ArrayList<Field>();
		getFields(clazz, deep, ret);
		return ret;
	}
	
	private static void getFields(Class<?> clazz, boolean deep, List<Field> list){
		do {
			list.addAll(Arrays.asList(clazz.getFields()));
			clazz = clazz.getSuperclass();
		} while (deep && clazz != Object.class);
	}
	
	/**
	 * 所有字段获取
	 * @param clazz
	 * @return
	 */
	public static List<Field> getDeclaredFields(Class<?> clazz){
		return getDeclaredFields(clazz, true);
	}

	public static Field getDeclaredField(Class<?> clazz, String fieldName){
		List<Field> fields = getDeclaredFields(clazz);
		if( null != fields && ! fields.isEmpty() ){
			for (Field field : fields) {
				if(field.getName().equals(fieldName)){
					return field;
				}
			}
		}
		return null;
	}
	
	
	private static List<Field> getDeclaredFields(Class<?> clazz, boolean deep){
		List<Field> ret = new ArrayList<Field>();
		getDeclaredFields(clazz, deep, ret);
		return ret;
	}
	
	private static void getDeclaredFields(Class<?> clazz, boolean deep, List<Field> list){
		do {
			list.addAll(Arrays.asList(clazz.getDeclaredFields()));
			clazz = clazz.getSuperclass();
		} while (deep && clazz != Object.class);
	}
	
	/**
	 * 共有方法获取
	 * @param clazz
	 * @return
	 */
	public static List<Field> getMethods(Class<?> clazz){
		return getMethods(clazz, true);
	}
	
	private static List<Field> getMethods(Class<?> clazz, boolean deep){
		List<Field> ret = new ArrayList<Field>();
		getMethods(clazz, deep, ret);
		return ret;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	private static void getMethods(Class<?> clazz, boolean deep, List list){
		do {
			list.addAll(Arrays.asList(clazz.getMethods()));
			clazz = clazz.getSuperclass();
		} while (deep && clazz != Object.class);
	}
	
	/**
	 * 所有方法获取
	 * @param clazz
	 * @return
	 */
	public static List<Field> getDeclaredMethods(Class<?> clazz){
		return getDeclaredMethods(clazz, true);
	}
	
	private static List<Field> getDeclaredMethods(Class<?> clazz, boolean deep){
		List<Field> ret = new ArrayList<Field>();
		getDeclaredMethods(clazz, deep, ret);
		return ret;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private static void getDeclaredMethods(Class<?> clazz, boolean deep, List list){
		do {
			list.addAll(Arrays.asList(clazz.getDeclaredMethods()));
			clazz = clazz.getSuperclass();
		} while (deep && clazz != Object.class);
	}
	
	/**
	 * 获取一个类的所有泛型
	 * @param clazz
	 * @return
	 */
	public static Type[] getGenerics(Class<?> clazz){
		Type[] actualType = null;
		Type genType = clazz.getGenericSuperclass();
		if (genType instanceof ParameterizedType) {
			ParameterizedType paramType = (ParameterizedType) genType;
			actualType = paramType.getActualTypeArguments();
		}
		return actualType;
	}
	
	/**
	 * 获取一个类指定位置的泛型
	 * @param clazz
	 * @param index
	 * @return
	 */
	public static Class<?> getGeneric(Class<?> clazz, int index){
		return (Class<?>) getGenerics(clazz)[index];
	}
	
	/**
	 * 获取一个类第一个位置的泛型
	 * @param clazz
	 * @return
	 */
	public static Class<?> getGeneric(Class<?> clazz){
		return getGeneric(clazz, 0);
	}
	
	/**
	 * 是否有指定的字段
	 * @param clazz
	 * @param fieldName
	 * @return
	 */
	public static boolean hasDeclaredField(Class<?> clazz, String fieldName){
		return ObjectUtils.isNotNull( getDeclaredField(clazz, fieldName) );
	}
	
	public static Class<?> getDeclaredFieldType(Class<?> clazz, String fieldName){
		return getDeclaredField(clazz, fieldName).getType();
	}
	
	public static boolean isAssignable(Class<?> supType, Class<?> subType){
		return supType.isAssignableFrom(subType);
	}
	
}
