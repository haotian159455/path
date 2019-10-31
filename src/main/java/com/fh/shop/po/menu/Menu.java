package com.fh.shop.po.menu;

import java.io.Serializable;

public class Menu implements Serializable {
    private Long id;
    private Long pId;
    private String areaName;
    private Long menuType;
    private String menuUrl;

    public Long getMenuType() {
        return menuType;
    }

    public void setMenuType(Long menuType) {
        this.menuType = menuType;
    }

    public String getMenuUrl() {
        return menuUrl;
    }

    public void setMenuUrl(String menuUrl) {
        this.menuUrl = menuUrl;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getpId() {
        return pId;
    }

    public void setpId(Long pId) {
        this.pId = pId;
    }

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }
}
