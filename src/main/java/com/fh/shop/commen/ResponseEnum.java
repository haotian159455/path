package com.fh.shop.commen;

public enum ResponseEnum {
    ERROR(-1, "error"),
    USERNAME_USERPWD_IS_EMPTY(1000, "用户名或密码或验证码为空"),
    USERNAME_IS_EXIST(1003, "用户名已存在"),
    USERNAME_IS_ERROR(1001, "用户名错误"),
    USERPWD_IS_ERROR(1002, "密码错误"),
    USERPWD_IS_LOCK(1003, "账户被锁定"),
    USER_PASSWORD(1004,"两次密码不正确，请重新输入！"),
    USER_PWD(1005,"原密码不正确，请重新输入！"),
    IMGCOUDE_NO(1006,"验证码错误！"),
    SUCCESS(200, "ok");

    private int code;

    private String msg;

    private ResponseEnum(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}
