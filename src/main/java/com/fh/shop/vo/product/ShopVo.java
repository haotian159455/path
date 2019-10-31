package com.fh.shop.vo.product;


import java.io.Serializable;

public class ShopVo implements Serializable {
    private Long id;
    private String shopName;
    private String price;
    private String shopImg;
    private String shopTime;
    private int IsUp;
    private Long stock;
    private int isSaleWell;
    private String brandIds;
    private String clName;

    public String getClName() {
        return clName;
    }

    public void setClName(String clName) {
        this.clName = clName;
    }

    public String getBrandIds() {
        return brandIds;
    }

    public void setBrandIds(String brandIds) {
        this.brandIds = brandIds;
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

    public int getIsSaleWell() {
        return isSaleWell;
    }

    public void setIsSaleWell(int isSaleWell) {
        this.isSaleWell = isSaleWell;
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

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getShopImg() {
        return shopImg;
    }

    public void setShopImg(String shopImg) {
        this.shopImg = shopImg;
    }

    public String getShopTime() {
        return shopTime;
    }

    public void setShopTime(String shopTime) {
        this.shopTime = shopTime;
    }
}
