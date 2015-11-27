package com.test.com.codes.common.util.test;

import org.apache.commons.lang3.SystemUtils;
import org.junit.Test;

import java.io.File;
import java.util.Map;
import java.util.Properties;
import java.util.Set;


/**
 * Created by Administrator on 2015/7/22 0022.
 */
public class LangTest {

    private String name;

    //系统工具类
    @Test
    public void testSystemUtils() {
        File hahayiyang = SystemUtils.getUserHome();
        if( hahayiyang.isFile() ){

        }
        Properties properties = System.getProperties();
        Set<Map.Entry<Object, Object>> entries = properties.entrySet();


    }


}
