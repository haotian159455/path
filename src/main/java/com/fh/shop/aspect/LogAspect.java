package com.fh.shop.aspect;

import com.alibaba.fastjson.JSONObject;
import com.auth0.jwt.internal.org.apache.commons.lang3.StringUtils;
import com.fh.shop.biz.log.ILogService;
import com.fh.shop.commen.SystemConstant;
import com.fh.shop.commen.WebContext;
import com.fh.shop.po.log.Log;
import com.fh.shop.po.user.User;
import com.fh.shop.servlet.DistributedSession;
import com.fh.shop.servlet.KeyUtil;
import com.fh.shop.utils.RedisUtil;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;

public class LogAspect {

    private static final Logger LOGGER = LoggerFactory.getLogger(LogAspect.class);

    @Resource
    private ILogService logService;
    @Resource
    private HttpServletResponse response;

    public Object doLog(ProceedingJoinPoint point){
        // 获取类名
        String className = point.getTarget().getClass().getCanonicalName();
        // 获取方法名
        String methodName = point.getSignature().getName();
        // 获取用户名
        HttpServletRequest request = WebContext.getRequest();
        HttpServletResponse response = WebContext.getResponse();
        String sessionId = DistributedSession.getSessionId(request,response);
        String s = RedisUtil.get(KeyUtil.user(sessionId));
        User userInfo = JSONObject.parseObject(s, User.class);
        String userName = userInfo.getUserName();
        String realName = userInfo.getRealName();
        // 获取详细执行记录
        Map<String, String[]> parameterMap = request.getParameterMap();
        Iterator<Map.Entry<String, String[]>> iterator = parameterMap.entrySet().iterator();
        StringBuffer detail = new StringBuffer();
        // 循环map
        while (iterator.hasNext()){
            Map.Entry<String, String[]> en = iterator.next();
            String key = en.getKey();
            String[] value = en.getValue();
            detail.append(";").append(key).append("=").append(StringUtils.join(value,","));
        }
        // 获取自定义注解的内容
        MethodSignature st = (MethodSignature) point.getSignature();
        //获取方法
        Method method = st.getMethod();
        String msg = "";
        //判断方法上是否有LogMessage类中的自定义注解
        if (method.isAnnotationPresent(LogMessage.class)){
            LogMessage annotation = method.getAnnotation(LogMessage.class);
            msg = annotation.value();
        }
        // 执行真实的方法
        Object result = null;
        try {
            result = point.proceed();
            LOGGER.info(userName+"执行了"+className+"的"+methodName+"方法成功！！");
            //插入表格中
            Log log = new Log();
            log.setCurrDate(new Date());
            log.setErrorMsg("");
            log.setInfo("执行了"+className+"的"+methodName+"方法成功！！");
            log.setUserName(userName);
            log.setRealName(realName);
            log.setStatus(SystemConstant.LOG_STATUS_SUCCESS);
            log.setDatail(detail.toString());
            log.setContent(msg);
            logService.add(log);
        } catch (Throwable throwable) {
            //打印异常信息到控制台
            //throwable.printStackTrace();
            //记录异常信息到日志
            LOGGER.error(userName+"执行了"+className+"的"+methodName+"方法失败！！"+throwable.getMessage());
            //插入表格中
            Log log = new Log();
            log.setCurrDate(new Date());
            log.setErrorMsg(throwable.getMessage());
            log.setInfo("执行了"+className+"的"+methodName+"方法失败！！");
            log.setUserName(userName);
            log.setRealName(realName);
            log.setStatus(SystemConstant.LOG_STATUS_ERROR);
            log.setDatail(detail.toString());
            log.setContent(msg);
            logService.add(log);
            //抛出异常，只有这样统一异常处理才能捕获到对应的异常信息，并将其转换为serverResponse进行客户端响应
            throw  new RuntimeException(throwable);
        }
        return result;
    }

}
