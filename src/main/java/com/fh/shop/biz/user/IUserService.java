package com.fh.shop.biz.user;

import com.fh.shop.commen.ServerResponse;
import com.fh.shop.param.menu.MenuParam;
import com.fh.shop.param.user.UserParam;
import com.fh.shop.po.menu.Menu;
import com.fh.shop.po.user.User;
import com.fh.shop.vo.user.UserVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface IUserService {
    void addUser(User user);

    List<UserVo> selectUser(UserParam userParam);

    void deleteUser(Integer id);

    UserVo selectUserById(Integer id);

    void updateUser(User user);

    Long selectCount(UserParam userParam);

    void deleteBatch(List<Integer> list);

    User selectUserByName(User user);

    void updateLoginUser(User user1);

    void updateErrorCount(User user1);

    List<User> selectList(UserParam userParam);

    List<MenuParam> selectMenu(Long id);

    List<Menu> selectMenuIn(Long id);

    User confirmUserName(String name);


}
