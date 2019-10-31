package com.fh.shop.servlet;


import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieUtil {

    // 写cookie
    public static void  writeCookie(String name, String value, String domain, HttpServletResponse response){
        Cookie cookie = new Cookie(name, value);
        // 带表网站域名
        cookie.setDomain(domain);
        // 带表网站根目录
        cookie.setPath("/");
        // 写cookie到客户端
        response.addCookie(cookie);
    }

    // 读cookie
    public static String readCookie(String name, HttpServletRequest request){
        Cookie[] cookies = request.getCookies();
        if (null == cookies || cookies.length == 0) {
            return "";
        }
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals(name)){
                return cookie.getValue();
            }

        }
        return "";
    }

}
