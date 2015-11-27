package com.test;


import com.google.common.base.Optional;
import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import com.google.common.collect.*;
import com.google.common.io.Files;
import com.google.common.io.Resources;
import org.apache.commons.lang3.SystemUtils;
import org.junit.Test;

import java.io.File;
import java.io.Serializable;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

/**
 * Created by Administrator on 2015/7/21 0021.
 */
public class JunitTest {

    public void test1(){
        System.out.println("test111");
        System.out.println("test1");
        System.out.println("change1");
        System.out.println("haha");

    }

    @Test
    public void test2(){
        System.out.println("test2");
        File file = SystemUtils.getUserHome();
        Properties haha = System.getProperties();
    }

    @Test
    public void test3(){
        Optional<Integer> possible = Optional.of(5);
    }

    @Test
    public void test4(){
        ImmutableSet<? extends Serializable> set = ImmutableSet.of("red", 3);
        ImmutableList<? extends Serializable> list = set.asList();

    }

    @Test
    public void test5Cache(){

        LoadingCache<String, Object> cache = CacheBuilder.newBuilder()
                .maximumSize(10)
                .expireAfterWrite(5, TimeUnit.SECONDS)
                .build(new CacheLoader<String, Object>() {
                    @Override
                    public Object load(String key) throws Exception {
                        return null;
                    }
                });
        cache.put("a", 1);
    }

    @Test
    public void test6(){
        Range<String> stringRange = Range.closed("a", "z");
        System.out.println(stringRange.contains("1"));
    }

    @Test
    public void test7(){
        String extension = Files.getFileExtension("D:/a.txt");
        System.out.println(extension);
        TreeTraverser<File> traverser = Files.fileTreeTraverser();

        File file = new File("D:/");
        Iterable<File> files = traverser.children(file);
        FluentIterable<File> fluentIterable = traverser.postOrderTraversal(file);


        Iterator<File> iterator = files.iterator();
        while( iterator.hasNext() ){
            System.out.println( iterator.next() );
        }

    }


}
