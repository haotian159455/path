package com.fh.shop.mapper.user;

import com.fh.shop.param.menu.MenuParam;
import com.fh.shop.param.user.UserParam;
import com.fh.shop.po.menu.Menu;
import com.fh.shop.po.user.User;
import com.fh.shop.po.user.UserRole;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IUserMapper {

  void addUser(User user);

  List<User> selectUser(UserParam userParam);

  void deleteUser(Integer id);

  User selectUserById(Integer id);

  void updateUser(User user);

  Long selectCount(UserParam userParam);

    void addUserRole(UserRole userRole);

  void deleteUserRole(Integer id);

  List selectUserRole(Long id);

  List selectUserRoleId(Long id);

    void deleteBatch(List<Integer> list);

    User selectUserByName(String userName);

    void updateLoginUser(User user1);

    void updateErrorCount(User user1);

    List<User> selectList(UserParam userParam);

    List<MenuParam> selectMenu(Long id);

  List<MenuParam> selectMenu2(@Param("pid") Long pid,@Param("id")Long id);

  List<Menu> selectMenuIn(Long id);

    User confirmUserName(String name);


}
