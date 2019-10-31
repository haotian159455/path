package com.fh.shop.interceptor;

import com.alibaba.fastjson.JSONObject;
import com.auth0.jwt.internal.org.apache.commons.lang3.StringUtils;
import com.fh.shop.po.menu.Menu;
import com.fh.shop.servlet.DistributedSession;
import com.fh.shop.servlet.KeyUtil;
import com.fh.shop.utils.RedisUtil;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MenuInterceptor2 extends HandlerInterceptorAdapter {
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String sessionId = DistributedSession.getSessionId(request, response);
        String all = RedisUtil.get(KeyUtil.menu1(sessionId));
        String menu1 = RedisUtil.get(KeyUtil.menu1(sessionId));
        List<Menu> allMenu = JSONObject.parseArray(all, Menu.class);
        List<Menu> menuList = JSONObject.parseArray(menu1, Menu.class);

        Boolean a = false;
        for (com.fh.shop.po.menu.Menu menu : allMenu) {
            if (StringUtils.isNotEmpty(menu.getMenuUrl()) && request.getRequestURI().contains(menu.getMenuUrl())) {
                a = true;
                break;
            }
        }
        if (!a) {
            return true;
        }

        for (com.fh.shop.po.menu.Menu menu : menuList) {
            if (StringUtils.isNotEmpty(menu.getMenuUrl()) && request.getRequestURI().contains(menu.getMenuUrl())) {
                return true;
            }
        }
        if (StringUtils.isNotEmpty(request.getHeader("X-Requested-With")) && request.getHeader("X-Requested-With").equals("XMLHttpRequest")) {
            Map result = new HashMap();
            result.put("code", -10000);
            result.put("msg", "没有该权限");
            //将map转化为json字符串
            String s = JSONObject.toJSONString(result);
            outJson(s, response);
        } else {
            response.sendRedirect("/error.jsp");
        }
        return false;
    }

    //将json字符串相应给前台
    private void outJson(String strJson, HttpServletResponse response) {
        PrintWriter writer = null;
        try {
            //解决字符串乱码
            response.setContentType("application/json;charset=utf-8");
            writer = response.getWriter();
            writer.write(strJson);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                writer.close();
            }
        }

    }
}
