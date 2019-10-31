package com.fh.shop.controller.role;


import com.fh.shop.aspect.LogMessage;
import com.fh.shop.biz.role.RoleService;
import com.fh.shop.commen.Datetables;
import com.fh.shop.commen.Page;
import com.fh.shop.commen.ServerResponse;
import com.fh.shop.po.role.Role;
import com.fh.shop.po.role.StuInfo;
import com.fh.shop.vo.role.RoleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("role")
public class  RoleController {
    @Autowired
    private RoleService roleService;


    @RequestMapping("toRoleList")
    public String toRoleList(){
        return "/role/roleList";
    }


    @RequestMapping("selectRoleUser")
    @ResponseBody
    public Datetables selectRoleUser(Page page){
        Long  count= roleService.selectCount();
        List<Role> list=roleService.selectRoleUser(page);
        return new Datetables(page .getDraw(),count,count,list);
    }

    @RequestMapping("selectRoleList")
    @ResponseBody
    public ServerResponse selectRoleList(){
        try {
            List list=roleService.selectRoleList();
            return ServerResponse.success(list);
        } catch (Exception e) {
            e.printStackTrace();
            return ServerResponse.error();
        }
    }

    @RequestMapping("addRole")
    @LogMessage("这是角色权限关联增加方法!!")
    @ResponseBody
    public ServerResponse addRole(Role role, @RequestParam("roleId[]")List<Long> list){
        try {
            roleService.addRole(role,list);
            return ServerResponse.success();
        } catch (Exception e) {
            e.printStackTrace();
            return  ServerResponse.error();
        }
    }

    @RequestMapping("deleteRole")
    @LogMessage("这是角色权限关联删除方法!!")
    @ResponseBody
    public ServerResponse deleteRole(int id){
        try {
            roleService.deleteRole(id);
            return ServerResponse.success();
        } catch (Exception e) {
            e.printStackTrace();
            return  ServerResponse.error();
        }
    }

    @RequestMapping("selectRoleById")
    @LogMessage("这是角色权限关联回显方法!!")
    @ResponseBody
    public ServerResponse selectRoleById(int id){
        try {
           RoleVo r=roleService.selectRoleById(id);
            return ServerResponse.success(r);
        } catch (Exception e) {
            e.printStackTrace();
            return  ServerResponse.error();
        }
    }

    @RequestMapping("updateRole")
    @LogMessage("这是角色权限关联修改方法!!")
    @ResponseBody
    public ServerResponse updateRole(Role role,@RequestParam("v_roleId[]")List<Long> list){
        try {
            roleService.updateRole(role,list);
            return ServerResponse.success();
        } catch (Exception e) {
            e.printStackTrace();
            return  ServerResponse.error();
        }
    }
    @RequestMapping("addStu")
    @ResponseBody
    public ServerResponse addStu(StuInfo stu){
        try {
            roleService.addStu(stu);
            return ServerResponse.success();
        } catch (Exception e) {
            e.printStackTrace();
            return  ServerResponse.error();
        }
    }

    @RequestMapping("selectStu")
    @ResponseBody
    public Datetables selectStu(Page page){
        Long  count= roleService.selectStu();
        List<StuInfo> list=roleService.selectStuList(page);
        return new Datetables(page .getDraw(),count,count,list);
    }

    @RequestMapping("deleteStu")
    @ResponseBody
    public ServerResponse deleteStu(int id){
        try {
            roleService.deleteStu(id);
            return  ServerResponse.success();
        } catch (Exception e) {
            e.printStackTrace();
            return  ServerResponse.error();
        }
    }
}

