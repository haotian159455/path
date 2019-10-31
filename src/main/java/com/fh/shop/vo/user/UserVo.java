package com.fh.shop.vo.user;


import java.io.Serializable;
import java.util.Date;

public class UserVo implements Serializable {
    private Long id;
    private String userName;
    private String realName;
    private Integer sex;
    private int age;
    private String phone;
    private String email;
    private int salary;
    private String  comeTime;
    private String  roleIds;
    private String imgPath;
    private String password;
    private int isUp;
    private String aName;

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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

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

    public String getComeTime() {
        return comeTime;
    }

    public void setComeTime(String comeTime) {
        this.comeTime = comeTime;
    }
}
