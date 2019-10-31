package com.fh.shop.commen;

import java.io.Serializable;

public class ServerResponse implements Serializable {
    private static final long serialVersionUID = 8156187193274650130L;

    private int code;

    private String msg;

    private Object data;

    private ServerResponse(int code, String msg, Object data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public static ServerResponse success() {
        return new ServerResponse(ResponseEnum.SUCCESS.getCode(), ResponseEnum.SUCCESS.getMsg(), null);
    }

    public static ServerResponse success(Object data) {
        return new ServerResponse(ResponseEnum.SUCCESS.getCode(), ResponseEnum.SUCCESS.getMsg(), data);
    }

    public static ServerResponse error() {
        return new ServerResponse(ResponseEnum.ERROR.getCode(), ResponseEnum.ERROR.getMsg(), null);
    }

    public static ServerResponse error(ResponseEnum responseEnum) {
        return new ServerResponse(responseEnum.getCode(), responseEnum.getMsg(), null);
    }



    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }

    public Object getData() {
        return data;
    }
}
