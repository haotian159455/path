package com.fh.shop.commen;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WebContext {

    private static ThreadLocal<HttpServletRequest> requestThreadLocal = new ThreadLocal<>();
    private static ThreadLocal<HttpServletResponse> responseThreadLocal = new ThreadLocal<>();
    //以当前线程作为key ， 存值
    public static void setRequest(HttpServletRequest request){
        requestThreadLocal.set(request);
    }
    public static void setResponse(HttpServletResponse response){
        responseThreadLocal.set(response);
    }
    //以当前线程作为key ， 取值
    public static  HttpServletRequest getRequest(){
        return requestThreadLocal.get();
    }
    public static HttpServletResponse getResponse(){
        return responseThreadLocal.get();
    }

    public static void remove(){
        requestThreadLocal.remove();
    }

}
