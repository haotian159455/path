package com.fh.shop.biz.user;

import com.auth0.jwt.internal.org.apache.commons.lang3.StringUtils;
import com.fh.shop.commen.ServerResponse;
import com.fh.shop.mapper.user.IUserMapper;
import com.fh.shop.param.menu.MenuParam;
import com.fh.shop.param.user.UserParam;
import com.fh.shop.po.menu.Menu;
import com.fh.shop.po.user.User;
import com.fh.shop.po.user.UserRole;
import com.fh.shop.utils.Md5Util;
import com.fh.shop.utils.UtilDate;
import com.fh.shop.vo.user.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Service
public class IUserServiceImpl implements IUserService {

    @Autowired
    private IUserMapper userMapper;

    @Override
    public void addUser(User user) {
        user.setDqTime(new Date());
        user.setPassword(Md5Util.md5(user.getPassword()));
        userMapper.addUser(user);
        Long userId = user.getId();
        if (userId != null) {
            stringToAdd(user, userId);
        }
    }

    private void stringToAdd(User user, Long userId) {
        String roleIds = user.getRoleIds();
        String[] roleId = roleIds.split(",");
        for (int i = 0; i < roleIds.length(); i++) {
            UserRole userRole = new UserRole();
            userRole.setUserId(userId);
            userRole.setRoleId(Long.parseLong(roleId[i].replace(" ","")));
            userMapper.addUserRole(userRole);
        }
    }

    @Override
    public List<UserVo> selectUser(UserParam userParam) {
        List<UserVo> listVo =new ArrayList<>();
        userParam.setRoleId((userParam.getRoleIds().length()+1)/2);
        List<User> list=userMapper.selectUser(userParam);
        for (User u : list) {
            UserVo userVo = getUserVo(u);
           List b=userMapper.selectUserRole(u.getId());
           String a= StringUtils.join(b);
           a=a.substring(1,a.length()-1);
                userVo.setRoleIds(a);
                listVo.add(userVo);
        }
        return listVo;
    }

    @Override
    public void deleteUser(Integer id) {
        userMapper.deleteUser(id);
        userMapper.deleteUserRole(id);
    }

    @Override
    public UserVo selectUserById(Integer id) {
        User u = userMapper.selectUserById(id);
        UserVo userVo = getUserVo(u);
            List b=userMapper.selectUserRoleId(u.getId());
            String a= StringUtils.join(b);
            a=a.substring(1,a.length()-1).replace(" ","");
            userVo.setRoleIds(a);
        return userVo;
    }

    private UserVo getUserVo(User u) {
        UserVo  userVo=new UserVo();
        userVo.setId(u.getId());
        userVo.setAge(u.getAge());
        userVo.setSex(u.getSex());
        userVo.setPassword(u.getPassword());
        userVo.setEmail(u.getEmail());
        userVo.setPhone(u.getPhone());
        userVo.setRealName(u.getRealName());
        userVo.setUserName(u.getUserName());
        userVo.setSalary(u.getSalary());
        userVo.setComeTime(UtilDate.date2String(u.getComeTime(),UtilDate.Y_M_D));
        userVo.setComeTime(UtilDate.date2String(u.getComeTime(),UtilDate.Y_M_D));
        userVo.setImgPath(u.getImgPath());
        userVo.setaName(u.getaName());
        return userVo;
    }

    @Override
    public void updateUser(User user) {
        if (user.getPassword().length()!=32){
            user.setPassword(Md5Util.md5(user.getPassword()));
        }
        userMapper.updateUser(user);
        userMapper.deleteUserRole(Integer.parseInt(String.valueOf(user.getId())));
        if (user.getRoleIds() != null) {
            String roleIds = user.getRoleIds();
            String[] roleId = roleIds.split(",");
            for (int i = 0; i < roleIds.length(); i++) {
                UserRole userRole = new UserRole();
                userRole.setUserId(user.getId());
                userRole.setRoleId(Long.parseLong(roleId[i]));
                userMapper.addUserRole(userRole);
            }
        }
    }

    @Override
    public Long selectCount(UserParam userParam) {
        userParam.setRoleId((userParam.getRoleIds().length()+1)/2);
        Long count = userMapper.selectCount(userParam);
        return count;
    }

    @Override
    public void deleteBatch(List<Integer> list) {
        userMapper.deleteBatch(list);
    }

    @Override
    public User selectUserByName(User user) {
       User user1= userMapper.selectUserByName(user.getUserName());
        return user1;
    }

    @Override
    public void updateLoginUser(User user1) {
        userMapper.updateLoginUser(user1);
    }

    @Override
    public void updateErrorCount(User user1) {
        userMapper.updateErrorCount(user1);
    }

    @Override
    public List<User> selectList(UserParam userParam) {
        return userMapper.selectList(userParam);
    }

    @Override
    public List<MenuParam> selectMenu(Long id) {
        List<MenuParam> menuParam= userMapper.selectMenu(id);
        for (MenuParam param : menuParam) {
            List<MenuParam> a= userMapper.selectMenu2(param.getId(),id);
                     param.setAnNiu(a);
        }
        return menuParam;
    }

    @Override
    public List<Menu> selectMenuIn(Long id) {
        return userMapper.selectMenuIn(id);
    }

    @Override
    public User confirmUserName(String name) {
        return userMapper.confirmUserName(name);
    }


}
