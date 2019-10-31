package com.fh.shop.mapper.menu;

import com.fh.shop.po.menu.Menu;

import java.util.List;

public interface IMenuMapper {
    List selectMenuList();

    void addArea(Menu menu);

    void updateArea(Menu menu);

    void deleteArea(List<Integer> idList);

    Menu selectMenuById(int id);

    List<Menu> selectMenuId(Long id);

    List<Menu> selectMenuList3(Long id);
}
