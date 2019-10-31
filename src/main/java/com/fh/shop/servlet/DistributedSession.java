package com.fh.shop.servlet;

import com.auth0.jwt.internal.org.apache.commons.lang3.StringUtils;
import com.fh.shop.utils.SystemConstant;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.UUID;

public class DistributedSession {

    public static String getSessionId(HttpServletRequest request, HttpServletResponse response){
        //读取cookie中的UUID
        String fh_id = CookieUtil.readCookie(SystemConstant.COOKIE_NAME,request);
        if (StringUtils.isEmpty(fh_id)) {
            // 需要生成新的id
            fh_id = UUID.randomUUID().toString();
            // 写入到客户端的会话cookie中
            CookieUtil.writeCookie(SystemConstant.COOKIE_NAME,fh_id,SystemConstant.DOMAIN,response);
        }
        return fh_id;
    }

}
