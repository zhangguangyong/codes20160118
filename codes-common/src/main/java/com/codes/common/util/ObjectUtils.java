package com.codes.common.util;

import java.lang.reflect.Array;
import java.util.Collection;
import java.util.Map;

public abstract class ObjectUtils {

	public static boolean isNull(Object value){
		return null == value;
	}
	
	@SuppressWarnings("rawtypes")
	public static boolean isEmpty(Object value){
		if( isNull(value) ){
			return true;
		}
		
		Class<? extends Object> valueClass = value.getClass();
		//数组
		if( valueClass.isArray() ){
			return Array.getLength(value) <= 0;
		}
		
		//集合
		if( Collection.class.isAssignableFrom(valueClass) ){
			return ( (Collection)value ).isEmpty();
		}
		
		//键值对
		if( Map.class.isAssignableFrom(valueClass) ){
			return ( (Map)value ).isEmpty();
		}

		//字符序列
		if( CharSequence.class.isAssignableFrom(valueClass) ){
			return ( (CharSequence)value ).toString().trim().length() <= 0;
		}
		
		return false;
	}
	
	public static boolean isNotNull(Object value){
		return ! isNull(value);
	}

	public static boolean isNotEmpty(Object value){
		return ! isEmpty(value);
	}
	
	//数组、容器、键值对是否为空的判断
	public static boolean isArray(Object value){
		return isNotNull(value) && value.getClass().isArray();
	}

	public static boolean isMap(Object value){
		return isNotNull(value) && Map.class.isAssignableFrom(value.getClass());
	}

	public static boolean isCollection(Object value){
		return isNotNull(value) && Collection.class.isAssignableFrom(value.getClass());
	}

	public static boolean isContainer(Object value){
		return isArray(value) || isCollection(value);
	}
	
	public static boolean isPrimitiveArray(Object value){
		return isArray(value)
				&& value.getClass().getCanonicalName()
						.equals(value.getClass().getSimpleName());
	}
	
	//基本类型数组转换为对应的对象类型数组
	public static Byte[] toObjectArray(byte...vals){
		return (Byte[]) convertToObjectArray(vals);
	}
	
	public static Short[] toObjectArray(short...vals){
		return (Short[]) convertToObjectArray(vals);
	}

	public static Character[] toObjectArray(char...vals){
		return (Character[]) convertToObjectArray(vals);
	}

	public static Integer[] toObjectArray(int...vals){
		return (Integer[]) convertToObjectArray(vals);
	}

	public static Long[] toObjectArray(long...vals){
		return (Long[]) convertToObjectArray(vals);
	}
	
	public static Float[] toObjectArray(float...vals){
		return (Float[]) convertToObjectArray(vals);
	}
	
	public static Double[] toObjectArray(double...vals){
		return (Double[]) convertToObjectArray(vals);
	}
	
	public static Object[] convertToObjectArray(Object array){
		if( ! isArray(array) ){
			throw new IllegalArgumentException("参数必须为数组[], 但是真是值为：" + array);
		}
		if( isPrimitiveArray(array) ){
			int length = Array.getLength(array);
			Object retArray = Array.newInstance( Array.get(array, 0).getClass() , length);
			for (int i = 0; i < length; i++) {
				Array.set(retArray, i, Array.get(array, i));
			}
			return (Object[]) retArray;
		}
		return (Object[]) array;
	}
	
}
