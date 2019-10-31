package com.fh.shop.biz.role;

import com.fh.shop.commen.Page;
import com.fh.shop.po.role.Role;
import com.fh.shop.po.role.StuInfo;
import com.fh.shop.vo.role.RoleVo;

import java.util.List;

public interface RoleService {
    List selectRoleUser(Page page);

    Long selectCount();

    List selectRoleList();

    void addRole(Role role,List<Long> list);

    void deleteRole(int id);

    RoleVo selectRoleById(int id);

    void updateRole(Role role,List<Long> list);

    void addStu(StuInfo stu);

    Long selectStu();

    List<StuInfo> selectStuList(Page page);

    void deleteStu(int id);
}
