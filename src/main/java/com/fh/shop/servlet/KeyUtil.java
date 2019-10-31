package com.fh.shop.servlet;

public class KeyUtil {


    public static String buildCodeKey(String data){
        return "code:"+data;
    }
    public static String menu1(String data){
        return "menu1:"+data;
    }
    public static String menu(String data){
        return "menu:"+data;
    }
    public static String allMenu(String data){
        return "allMenu:"+data;
    }
    public static String menuIn(String data){
        return "menuIn:"+data;
    }
   public static String user(String data){
        return "user:"+data;
    }
   /*  public static String menu(String data){
        return "menu1:"+data;
    }
    public static String menu(String data){
        return "menu1:"+data;
    }*/


}
