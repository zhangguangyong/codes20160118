package com.codes.web.spring.beans;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 * Created by Administrator on 2015/7/30 0030.
 */
@SuppressWarnings("serial")
@WebServlet(name = "RequestScopeServlet", urlPatterns = "/request")
public class RequestScopeServlet extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());

        ReqeustBean reqeustBean = context.getBean(ReqeustBean.class);
        ReqeustBean reqeustBean1 = context.getBean(ReqeustBean.class);
        System.out.println(reqeustBean == reqeustBean1);
        System.out.println("RequestScopeServlet");
    }

}
