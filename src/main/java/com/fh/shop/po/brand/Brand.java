package com.fh.shop.po.brand;

import com.fh.shop.commen.Page;

import java.io.Serializable;

public class Brand extends Page implements Serializable {

    private Long id;

    private String brandName;

    private String brandImg;

    private Integer status;

    private Integer sortId;

    public Integer getSortId() {
        return sortId;
    }

    public void setSortId(Integer sortId) {
        this.sortId = sortId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getBrandImg() {
        return brandImg;
    }

    public void setBrandImg(String brandImg) {
        this.brandImg = brandImg;
    }
}
