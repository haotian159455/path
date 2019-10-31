package com.fh.shop.interceptor;

import com.fh.shop.po.user.User;
import com.fh.shop.servlet.DistributedSession;
import com.fh.shop.servlet.KeyUtil;
import com.fh.shop.utils.RedisUtil;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class qqqq extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String sessionId = DistributedSession.getSessionId(request, response);
        String user = RedisUtil.get(KeyUtil.user(sessionId));
        if (user!=null){
            return true;
        }else{
            response.sendRedirect("/login.jsp");
            return false;
        }
    }
}
