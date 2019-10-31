package com.fh.shop.po.user;

import com.fh.shop.commen.Page;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class User  implements Serializable {
    private Long id;
    private String userName;
    private String realName;
    private String password;
    private Integer sex;
    private int age;
    private String phone;
    private String email;
    private int salary;
    @DateTimeFormat(pattern="yyyy/MM/dd")
    private Date comeTime;
    private Date dqTime;
    private Date scTime;
    private Long loginCount;
    private Long errorCount;
    private Long isLock;
    private Date lockTime;
    private int isUp;
    private long a1;
    private long a2;
    private long a3;
    private String aName;

    public long getA1() {
        return a1;
    }

    public void setA1(long a1) {
        this.a1 = a1;
    }

    public long getA2() {
        return a2;
    }

    public void setA2(long a2) {
        this.a2 = a2;
    }

    public long getA3() {
        return a3;
    }

    public void setA3(long a3) {
        this.a3 = a3;
    }

    public String getaName() {
        return aName;
    }

    public void setaName(String aName) {
        this.aName = aName;
    }

    public int getIsUp() {
        return isUp;
    }

    public void setIsUp(int isUp) {
        this.isUp = isUp;
    }

    public Date getLockTime() {
        return lockTime;
    }

    public void setLockTime(Date lockTime) {
        this.lockTime = lockTime;
    }

    public Long getErrorCount() {
        return errorCount;
    }

    public void setErrorCount(Long errorCount) {
        this.errorCount = errorCount;
    }

    public Long getIsLock() {
        return isLock;
    }

    public void setIsLock(Long isLock) {
        this.isLock = isLock;
    }

    public Long getLoginCount() {
        return loginCount;
    }

    public void setLoginCount(Long loginCount) {
        this.loginCount = loginCount;
    }

    public Date getDqTime() {
        return dqTime;
    }

    public void setDqTime(Date dqTime) {
        this.dqTime = dqTime;
    }

    public Date getScTime() {
        return scTime;
    }

    public void setScTime(Date scTime) {
        this.scTime = scTime;
    }



    private String roleIds;
 private String imgPath;

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public String getRoleIds() {
        return roleIds;
    }

    public void setRoleIds(String roleIds) {
        this.roleIds = roleIds;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getSalary() {
        return salary;
    }

    public void setSalary(int salary) {
        this.salary = salary;
    }

    public Date getComeTime() {
        return comeTime;
    }

    public void setComeTime(Date comeTime) {
        this.comeTime = comeTime;
    }
}
