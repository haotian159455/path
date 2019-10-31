package com.fh.shop.param.log;

import com.fh.shop.commen.Page;

import java.io.Serializable;

public class LogParam extends Page implements Serializable {

    private String userName;

    private String realName;

    private String info;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }
}
