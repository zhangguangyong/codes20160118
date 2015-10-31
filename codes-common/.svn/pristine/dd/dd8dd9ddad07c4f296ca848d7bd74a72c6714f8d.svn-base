package com.codes.common.util;

import java.util.List;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

public abstract class Jsons {

	static SerializerFeature[] features = new SerializerFeature[]{
		SerializerFeature.WriteDateUseDateFormat
	};
	
	/**
	 * 把一个对象转换成json字符串
	 * @param value
	 * @return
	 */
	public static String format(Object value){
		return JSON.toJSONString(value, features);
	}

	public static <T> T parse(String text, Class<T> clazz){
		return JSON.parseObject(text, clazz);
	}

	public static <T> List<T> parseArray(String text, Class<T> clazz){
		return JSON.parseArray(text, clazz);
	}
}
