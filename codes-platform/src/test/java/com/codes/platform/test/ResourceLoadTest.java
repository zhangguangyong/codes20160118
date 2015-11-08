package com.codes.platform.test;

import java.util.List;

import org.junit.Test;

import com.codes.platform.util.ClassFinder;

public class ResourceLoadTest {
	
	@Test
	public void test(){
		String packageName = "com.codes.platform.**.domain";
		List<String> names = ClassFinder.getInstance(packageName).findClassNames();
		System.out.println(names);
		
	}
	
	@Test
	public void test1(){
		// System.out.println( 10000 * Math.pow(1.1, 6) );
		// 17715.610000000008
		// 17715.61000000001
		double num = 1.1;
		for (int i = 0; i < 5; i++) {
			num *= 1.1;
		}
		System.out.println( 10000 * num);
		
	}
	
	
}
