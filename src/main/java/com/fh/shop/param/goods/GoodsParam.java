package com.fh.shop.param.goods;

import com.fh.shop.commen.Page;
import org.springframework.format.annotation.DateTimeFormat;

import javax.xml.crypto.Data;
import java.util.Date;

public class GoodsParam extends Page {

    private String goodsName;
    private Integer minGoodsPrice;
    private Integer maxGoodsPrice;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Data minGoodsDate;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date maxGoodsDate;

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public Integer getMinGoodsPrice() {
        return minGoodsPrice;
    }

    public void setMinGoodsPrice(Integer minGoodsPrice) {
        this.minGoodsPrice = minGoodsPrice;
    }

    public Integer getMaxGoodsPrice() {
        return maxGoodsPrice;
    }

    public void setMaxGoodsPrice(Integer maxGoodsPrice) {
        this.maxGoodsPrice = maxGoodsPrice;
    }

    public Data getMinGoodsDate() {
        return minGoodsDate;
    }

    public void setMinGoodsDate(Data minGoodsDate) {
        this.minGoodsDate = minGoodsDate;
    }

    public Date getMaxGoodsDate() {
        return maxGoodsDate;
    }

    public void setMaxGoodsDate(Date maxGoodsDate) {
        this.maxGoodsDate = maxGoodsDate;
    }
}
