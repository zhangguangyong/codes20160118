package com.codes.web.spring.beans;

/**
 * Created by Administrator on 2015/7/30 0030.
 */
public class NotLazyBean {

    private LazyBean lazyBean;

    public NotLazyBean(){
        System.out.println("NotLazyBean");
    }

    public LazyBean getLazyBean() {
        return lazyBean;
    }

    public void setLazyBean(LazyBean lazyBean) {
        this.lazyBean = lazyBean;
    }
}
