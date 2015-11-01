package com.codes.web.spring.beans.markinterface;

import org.springframework.beans.factory.InitializingBean;

/**
 * Created by Administrator on 2015/7/31 0031.
 */
public class InitBeanTest implements InitializingBean {

    public InitBeanTest(){
        System.out.println("InitBeanTest");
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        System.out.println(InitBeanTest.class.getName() + ":" + "afterPropertiesSet");
    }
}
