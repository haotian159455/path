package com.fh.shop.po.product;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fh.shop.po.brand.Brand;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class Shop implements Serializable {
    private Long id;
    private String shopName;
    private BigDecimal price;
    private String shopImg;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date shopTime;
    private int IsUp;
    private Long stock;
    private int isSaleWell;
    private long cl1;
    private long cl2;
    private long cl3;
    private String clName;
    @TableField(exist = false)
    private Brand brand;




    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public long getCl1() {
        return cl1;
    }

    public void setCl1(long cl1) {
        this.cl1 = cl1;
    }

    public long getCl2() {
        return cl2;
    }

    public void setCl2(long cl2) {
        this.cl2 = cl2;
    }

    public long getCl3() {
        return cl3;
    }

    public void setCl3(long cl3) {
        this.cl3 = cl3;
    }

    public String getClName() {
        return clName;
    }

    public void setClName(String clName) {
        this.clName = clName;
    }

    public int getIsSaleWell() {
        return isSaleWell;
    }

    public void setIsSaleWell(int isSaleWell) {
        this.isSaleWell = isSaleWell;
    }

    public int getIsUp() {
        return IsUp;
    }

    public void setIsUp(int isUp) {
        IsUp = isUp;
    }

    public Long getStock() {
        return stock;
    }

    public void setStock(Long stock) {
        this.stock = stock;
    }



    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }


    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getShopImg() {
        return shopImg;
    }

    public void setShopImg(String shopImg) {
        this.shopImg = shopImg;
    }

    public Date getShopTime() {
        return shopTime;
    }

    public void setShopTime(Date shopTime) {
        this.shopTime = shopTime;
    }
}
