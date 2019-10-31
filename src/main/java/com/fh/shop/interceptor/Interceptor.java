package com.fh.shop.interceptor;



import com.fh.shop.servlet.DistributedSession;
import com.fh.shop.servlet.KeyUtil;
import com.fh.shop.utils.RedisUtil;
import com.fh.shop.utils.SystemConstant;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class Interceptor extends HandlerInterceptorAdapter {

	public boolean preHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2) throws Exception {
		String sessionId = DistributedSession.getSessionId(arg0, arg1);
		String s1 = RedisUtil.get(KeyUtil.user(sessionId));
		if (s1!=null) {
				RedisUtil.expire(KeyUtil.user(sessionId),SystemConstant.USER_SHIJIAN);
				RedisUtil.expire(KeyUtil.menuIn(sessionId),SystemConstant.USER_SHIJIAN);
				RedisUtil.expire(KeyUtil.menu(sessionId),SystemConstant.USER_SHIJIAN);
				RedisUtil.expire(KeyUtil.allMenu(sessionId),SystemConstant.USER_SHIJIAN);
				RedisUtil.expire(KeyUtil.menu1(sessionId),SystemConstant.USER_SHIJIAN);
				return true;
			}else{
				System.out.println("-------------");
				arg1.sendRedirect("/");
				return false;
			}

	}
}
