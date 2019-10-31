package com.fh.shop.controller.menu;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fh.shop.biz.menu.MenuServiceImpl;
import com.fh.shop.commen.ServerResponse;
import com.fh.shop.param.menu.MenuParam;
import com.fh.shop.po.menu.Menu;
import com.fh.shop.po.user.User;
import com.fh.shop.servlet.DistributedSession;
import com.fh.shop.servlet.KeyUtil;
import com.fh.shop.utils.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("menu")
public class MenuController {

    @Autowired
    private MenuServiceImpl menuService;

    @RequestMapping("toList")
    public String toList() {
        return "menu/menu";
    }

    @RequestMapping("selectMenuList")
    @ResponseBody
    public Map selectMenuList() {
        Map result = menuService.selectMenuList();
        return result;
    }

    @RequestMapping("addArea")
    @ResponseBody
    public Map addArea(Menu menu) {
        Map result = menuService.addArea(menu);
        return result;
    }

    @RequestMapping("updateArea")
    @ResponseBody
    public Map updateArea(Menu menu) {
        Map result = menuService.updateArea(menu);
        return result;
    }

    @RequestMapping("deleteArea")
    @ResponseBody
    public Map deleteArea(@RequestParam("ids[]") List<Integer> idList) {
        Map result = menuService.deleteArea(idList);
        return result;
    }


    @RequestMapping("selectMenuById")
    @ResponseBody
    public ServerResponse selectMenuById(int id) {
        try {
            Menu menu = menuService.selectMenuById(id);
            return ServerResponse.success(menu);
        } catch (Exception e) {
            e.printStackTrace();
            return ServerResponse.error();
        }
    }

    @RequestMapping("selectMenu")
    @ResponseBody
    public ServerResponse selectMenu(HttpServletRequest req, HttpServletResponse response) {
        try {

            String sessionId = DistributedSession.getSessionId(req, response);
            String userJson = RedisUtil.get(KeyUtil.user(sessionId));
            User user = JSONObject.parseObject(userJson, User.class);
            List<Menu>  menuList=menuService.selectMenuId(user.getId());
            String s = JSONObject.toJSONString(menuList);
            RedisUtil.set(KeyUtil.menu(sessionId),s);
            return ServerResponse.success(menuList);


        } catch (Exception e) {
            e.printStackTrace();
            return ServerResponse.error();
        }
    }


    @RequestMapping("selectMenu2")
    @ResponseBody
    public void selectMenu2(HttpServletRequest req,HttpServletResponse response) {
        try {
            List<Menu>  AllMenu= menuService.selectMenuList2();
            String sessionId = DistributedSession.getSessionId(req, response);
            String s = JSONObject.toJSONString(AllMenu);
            RedisUtil.set(KeyUtil.allMenu(sessionId),s);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}