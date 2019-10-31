package com.fh.shop.biz.menu;

import com.fh.shop.po.menu.Menu;

import java.util.List;
import java.util.Map;

public interface IMenuService {
    Map selectMenuList();
    Map addArea(Menu menu);
    Map updateArea(Menu menu);

    Map deleteArea(List<Integer> idList);

    Menu selectMenuById(int id);

    List<Menu> selectMenuId(Long id);

    List<Menu> selectMenuList2();


    List<Menu> selectMenuList3(Long id);
}
