package com.fh.shop.biz.menu;

import com.fh.shop.mapper.menu.IMenuMapper;
import com.fh.shop.po.menu.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MenuServiceImpl implements IMenuService {
    @Autowired
    private IMenuMapper menuMapper;


    @Override
    public Map selectMenuList() {
        Map result=new HashMap();
        try {
            List   list = menuMapper.selectMenuList();
            result.put("code","200");
            result.put("msg","ok");
            result.put("data",list);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code","-1");
            result.put("msg","error");
        }
        return result;
    }

    @Override
    public Map addArea(Menu menu) {
        Map result=new HashMap();
        try {
            menuMapper.addArea(menu);
            result.put("code","200");
            result.put("msg","ok");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code","-1");
            result.put("msg","error");
        }
        return result;
    }

    @Override
    public Map updateArea(Menu menu) {
        Map result=new HashMap();
        try {
            menuMapper.updateArea(menu);
            result.put("code","200");
            result.put("msg","ok");

        } catch (Exception e) {
            e.printStackTrace();
            result.put("code","-1");
            result.put("msg","error");
        }
        return result;
    }

    @Override
    public Map deleteArea(List<Integer> idList) {
        Map result=new HashMap();
        try {
            menuMapper.deleteArea(idList);
            result.put("code","200");
            result.put("msg","ok");

        } catch (Exception e) {
            e.printStackTrace();
            result.put("code","-1");
            result.put("msg","error");
        }
        return result;
    }

    @Override
    public Menu selectMenuById(int id) {
        return menuMapper.selectMenuById(id);
    }

    @Override
    public List<Menu> selectMenuId(Long id) {
        return menuMapper.selectMenuId(id);
    }

    @Override
    public List<Menu> selectMenuList2() {
        List<Menu>   list = menuMapper.selectMenuList();
        return list;
    }

    @Override
    public List<Menu> selectMenuList3(Long id) {
        return menuMapper.selectMenuList3(id);
    }


}
