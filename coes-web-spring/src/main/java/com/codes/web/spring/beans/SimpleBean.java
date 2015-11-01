package com.codes.web.spring.beans;

import java.util.Date;

/**
 * Created by Administrator on 2015/7/30 0030.
 */
public class SimpleBean {



    private int age;
    private String name;
    private Date birthday;

    public SimpleBean() {
        System.out.println("----SimpleBean---");
    }

    public SimpleBean(int age) {
        this();
        this.age = age;
    }

    public SimpleBean(int age, String name) {
        this.age = age;
        this.name = name;
    }

    public SimpleBean(int age, String name, Date birthday) {
        this.age = age;
        this.name = name;
        this.birthday = birthday;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }
}
