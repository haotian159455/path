package com.fh.shop.po.product;

import java.io.Serializable;

public class ProductBrand implements Serializable {

    private Long id;
    private Long productid;
    private Long brandid;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getProductid() {
        return productid;
    }

    public void setProductid(Long productid) {
        this.productid = productid;
    }

    public Long getBrandid() {
        return brandid;
    }

    public void setBrandid(Long brandid) {
        this.brandid = brandid;
    }
}
