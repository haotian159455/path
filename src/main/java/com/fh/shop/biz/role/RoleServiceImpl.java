package com.fh.shop.biz.role;

import com.fh.shop.commen.Page;
import com.fh.shop.mapper.role.RoleMapper;
import com.fh.shop.po.role.Role;
import com.fh.shop.po.role.RoleMenu;
import com.fh.shop.po.role.StuInfo;
import com.fh.shop.vo.role.RoleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
   private RoleMapper roleMapper;

    @Override
    public List selectRoleUser(Page page) {
        return roleMapper.selectRoleUser(page);
    }

    @Override
    public Long selectCount() {
        return roleMapper.selectCount();
    }

    @Override
    public List selectRoleList() {

        return roleMapper.selectRoleList();
    }

    @Override
    public void addRole(Role role,List<Long> list) {
        roleMapper.addRole(role);
        if (list.get(0)!=-1){
        addRoleMenu(role, list);
        }
    }

    @Override
    public void deleteRole(int id) {
        roleMapper.deleteRole(id);
        roleMapper.deleteRoleMenu((long)id);
    }

    @Override
    public RoleVo selectRoleById(int id) {
        Role role = roleMapper.selectRoleById(id);
        List<Long> list= roleMapper.selectRoleMenuById(id);
        RoleVo roleVo=new RoleVo();
        roleVo.setMenuId(list);
        roleVo.setId((long)id);
        roleVo.setRoleName(role.getRoleName());
        return roleVo;
    }

    @Override
    public void updateRole(Role role,List<Long> list) {
        roleMapper.updateRole(role);
        roleMapper.deleteRoleMenu(role.getId());
        if (list.get(0)!=-1){
        addRoleMenu(role, list);
        }
    }

    private void addRoleMenu(Role role, List<Long> list) {
        for (Long id : list) {
            RoleMenu roleMenu = new RoleMenu();
            roleMenu.setMenuId(id);
            roleMenu.setRoleId(role.getId());
            roleMapper.addRoleMenu(roleMenu);
        }
    }

    @Override
    public void addStu(StuInfo stu) {
        roleMapper.addStu(stu);
    }

    @Override
    public Long selectStu() {
        return roleMapper.selectStu();
    }

    @Override
    public List<StuInfo> selectStuList(Page page) {
        return roleMapper.selectStuList(page);
    }

    @Override
    public void deleteStu(int id) {
        roleMapper.deleteStu(id);
    }
}
