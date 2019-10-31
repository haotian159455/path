package com.fh.shop.vo.role;

import java.io.Serializable;
import java.util.List;

public class RoleVo implements Serializable {
    private Long id;
    private String roleName;
    private List<Long> menuId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public List<Long> getMenuId() {
        return menuId;
    }

    public void setMenuId(List<Long> menuId) {
        this.menuId = menuId;
    }
}
