package com.fh.shop.utils;

import redis.clients.jedis.Jedis;

public class RedisUtil {

    //String 类型的新增数据方法  set方法
    public static void set(String key,String value){
        Jedis jedis = null;
        try {
            jedis =  RedisPool.getJedis();
            jedis.set(key, value);
        } catch (Exception e) {
            e.printStackTrace();
            new RuntimeException(e.getMessage());
        } finally {
            if(null != jedis){
                jedis.close();
            }
        }
    }

    //String 类型的查询方法   get方法
    public static String get(String key){
        Jedis jedis = null;
        String s = "";
        try {
            jedis = RedisPool.getJedis();
            s = jedis.get(key);
        } catch (Exception e) {
            e.printStackTrace();
            new RuntimeException(e.getMessage());
        }finally {
            if(null != jedis){
                jedis.close();
            }
        }
        return s;
    }

    //String 类型的删除方法  del方法
    public static  void del(String... key){
        Jedis jedis = null;
        try {
            jedis = RedisPool.getJedis();
            jedis.del(key);
        } catch (Exception e) {
            e.printStackTrace();
            new RuntimeException(e.getMessage());
        }finally {
            if(null != jedis){
                jedis.close();
            }
        }
    }

    // String 类型的清除 seconds方法
    public static void sexEx(String key,String value,int seconds){
        Jedis jedis = null;
        try {
            jedis = RedisPool.getJedis();
            jedis.setex(key, seconds, value);
        } catch (Exception e) {
            e.printStackTrace();
            new RuntimeException(e.getMessage());
        }finally {
            if(jedis != null){
                jedis.close();
            }
        }
    }

    // String 类型的 设置到期时间  expire方法
    public static void expire(String key,int seconds){
        Jedis jedis = null;
        try {
            jedis = RedisPool.getJedis();
            jedis.expire(key,seconds);
        } catch (Exception e) {
            e.printStackTrace();
            new RuntimeException(e.getMessage());
        }finally {
            if(jedis != null){
                jedis.close();;
            }
        }
    }





}
