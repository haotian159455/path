package com.fh.shop.param.product;

import com.fh.shop.commen.Page;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class ParamSearchShop extends Page implements Serializable {
    private String shopName;
    private String minPrice;
    private String maxPrice;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date minDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date maxDate;
    private String cl1;
    private String cl2;
    private String cl3;

    public String getCl1() {
        return cl1;
    }

    public void setCl1(String cl1) {
        this.cl1 = cl1;
    }

    public String getCl2() {
        return cl2;
    }

    public void setCl2(String cl2) {
        this.cl2 = cl2;
    }

    public String getCl3() {
        return cl3;
    }

    public void setCl3(String cl3) {
        this.cl3 = cl3;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public String getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(String maxPrice) {
        this.maxPrice = maxPrice;
    }

    public String getMinPrice() {

        return minPrice;
    }

    public void setMinPrice(String minPrice) {
        this.minPrice = minPrice;
    }

    public Date getMinDate() {
        return minDate;
    }

    public void setMinDate(Date minDate) {
        this.minDate = minDate;
    }

    public Date getMaxDate() {
        return maxDate;
    }

    public void setMaxDate(Date maxDate) {
        this.maxDate = maxDate;
    }
}
