package com.fh.shop.aspect;

import org.aspectj.lang.ProceedingJoinPoint;

//切面就是一个普通的java类
//想让普通的java类起到切面的作用,就需要进行相关的配置

public class InfoAspect {

    //横切逻辑非核心代码
    public Object doInfo(ProceedingJoinPoint joinPoint){
        //方法执行
        Object result = null;
        //实际要执行的方法
        try {
            result = joinPoint.proceed();
            //方法执行成功！
            System.out.println("方法执行成功！");
        } catch (Throwable throwable) {
            throwable.printStackTrace();
        }
        return result;
    }

}
