package com.fh.shop.param.user;

import com.fh.shop.commen.Page;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class UserParam extends Page {
    private Integer id;
    private String userName;
    private String realName;
    private Integer minAge;
    private Integer maxAge;
    private Integer minSalary;
    private Integer maxSalary;
    @DateTimeFormat(pattern="yyyy/MM/dd")
    private Date minComeTime;
    @DateTimeFormat(pattern="yyyy/MM/dd")
    private Date maxComeTime;
    private String roleIds;
    private Integer roleId;
    private Long a1;
    private Long a2;
    private Long a3;


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

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getRoleIds() {
        return roleIds;
    }

    public void setRoleIds(String roleIds) {
        this.roleIds = roleIds;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

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

    public Integer getMinAge() {
        return minAge;
    }

    public void setMinAge(Integer minAge) {
        this.minAge = minAge;
    }

    public Integer getMaxAge() {
        return maxAge;
    }

    public void setMaxAge(Integer maxAge) {
        this.maxAge = maxAge;
    }

    public Integer getMinSalary() {
        return minSalary;
    }

    public void setMinSalary(Integer minSalary) {
        this.minSalary = minSalary;
    }

    public Integer getMaxSalary() {
        return maxSalary;
    }

    public void setMaxSalary(Integer maxSalary) {
        this.maxSalary = maxSalary;
    }

    public Date getMinComeTime() {
        return minComeTime;
    }

    public void setMinComeTime(Date minComeTime) {
        this.minComeTime = minComeTime;
    }

    public Date getMaxComeTime() {
        return maxComeTime;
    }

    public void setMaxComeTime(Date maxComeTime) {
        this.maxComeTime = maxComeTime;
    }
}
