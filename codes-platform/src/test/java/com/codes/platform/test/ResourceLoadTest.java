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
	
}
