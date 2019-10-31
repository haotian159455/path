package com.fh.shop.mapper.role;

import com.fh.shop.commen.Page;
import com.fh.shop.po.role.Role;
import com.fh.shop.po.role.RoleMenu;
import com.fh.shop.po.role.StuInfo;

import java.util.List;

public interface RoleMapper {
    List selectRoleUser(Page page);

    Long selectCount();

    List selectRoleList();

    void addRole(Role role);

    void deleteRole(int id);

    Role selectRoleById(int id);

    void updateRole(Role role);

    void addStu(StuInfo stu);

    Long selectStu();

    List<StuInfo> selectStuList(Page page);

    void deleteStu(int id);

    void addRoleMenu(RoleMenu roleMenu);

    List<Long> selectRoleMenuById(int id);

    void deleteRoleMenu(Long id);
}
