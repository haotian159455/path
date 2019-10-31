package com.fh.shop.param.userVip;

import com.fh.shop.commen.Page;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class SearchUserVip extends Page implements Serializable {

    private String name;
    private String realName;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date minBirthday;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date maxBirthday;
    private Long a1;
    private Long a2;
    private Long a3;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public Date getMinBirthday() {
        return minBirthday;
    }

    public void setMinBirthday(Date minBirthday) {
        this.minBirthday = minBirthday;
    }

    public Date getMaxBirthday() {
        return maxBirthday;
    }

    public void setMaxBirthday(Date maxBirthday) {
        this.maxBirthday = maxBirthday;
    }

    public Long getA1() {
        return a1;
    }

    public void setA1(Long a1) {
        this.a1 = a1;
    }

    public Long getA2() {
        return a2;
    }

    public void setA2(Long a2) {
        this.a2 = a2;
    }

    public Long getA3() {
        return a3;
    }

    public void setA3(Long a3) {
        this.a3 = a3;
    }
}
