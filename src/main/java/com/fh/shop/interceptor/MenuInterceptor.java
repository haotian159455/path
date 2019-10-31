package com.fh.shop.interceptor;


import com.alibaba.fastjson.JSONObject;
import com.fh.shop.po.menu.Menu;
import com.fh.shop.servlet.DistributedSession;
import com.fh.shop.servlet.KeyUtil;
import com.fh.shop.utils.RedisUtil;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class MenuInterceptor extends HandlerInterceptorAdapter {
    public boolean preHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2) throws Exception {
        String sessionId = DistributedSession.getSessionId(arg0, arg1);
        String menuList = RedisUtil.get(KeyUtil.menuIn(sessionId));
        List<Menu> menus = JSONObject.parseArray(menuList, Menu.class);
        if (menus.size()>0) {
            for (Menu menu : menus) {
                if (menu.getMenuUrl().equals(arg0.getServletPath())) {
                    arg1.sendRedirect("/index/index.do");
                    return false;
                }
            }
        }
        return true;
    }
}
