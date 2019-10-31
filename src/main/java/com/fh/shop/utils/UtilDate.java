package com.fh.shop.utils;

import com.fh.shop.vo.user.UserVo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class UtilDate {
    public static final String Y_M_D="yyyy/MM/dd";
    public static final String FULL_YEAR="yyyy/MM/dd HH:mm:ss";
    public static String  date2String(Date data,String dateType){
        if (data==null){
            return "";
        }
        SimpleDateFormat sim=new SimpleDateFormat(dateType);
       String result=sim.format(data);
        return result;
    }
}
