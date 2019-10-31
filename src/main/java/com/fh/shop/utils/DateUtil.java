package com.fh.shop.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

    public static final String Y_M_D="yyyy-MM-dd";
    public static final String FOR_YEAR="yyyy-MM-dd HH:mm:ss";

    public static String date2str(Date data,String pattern){
        if (data==null){
            return "";
        }
        SimpleDateFormat sdf= new SimpleDateFormat(pattern);
        String strDate = sdf.format(data);
        return strDate;
    }
    public static Date str2data(String str,String pattern){
        if (str==""){
            return null;
        }else{
            SimpleDateFormat sdf= new SimpleDateFormat(pattern);
            Date date= null;
            try {
                date = sdf.parse(str);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            return date;
        }
    }
    public static String dateUtil(Date date, String pattern){
        if(date == null){
            return "";
        }
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        String format = sdf.format(date);
        return format;
    }



}
