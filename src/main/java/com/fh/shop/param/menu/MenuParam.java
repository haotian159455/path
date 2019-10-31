package com.fh.shop.param.menu;

import java.util.List;

public class MenuParam {
    private Long id;
    private Long pId;
    private String areaName;
    private Long menuType;
    private String menuUrl;
    private List<MenuParam> anNiu;

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

    public List getAnNiu() {
        return anNiu;
    }

    public void setAnNiu(List anNiu) {
        this.anNiu = anNiu;
    }
}
