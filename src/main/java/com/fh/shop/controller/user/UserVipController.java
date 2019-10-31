package com.fh.shop.controller.user;

import com.fh.shop.biz.userVip.IUserBiz;
import com.fh.shop.commen.Datetables;
import com.fh.shop.param.userVip.SearchUserVip;
import com.fh.shop.vo.userVip.UserVipVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("userVip")
public class UserVipController {

    @Resource
    private IUserBiz userBiz;

    @RequestMapping("queryVipList")
    @ResponseBody
    public Datetables querySelect(SearchUserVip searchUserVip){
        Long count = userBiz.count(searchUserVip);
        List<UserVipVo> userVipVos = userBiz.querySelect(searchUserVip);
        Datetables datetables = new Datetables(searchUserVip.getDraw(), count, count, userVipVos);
        return datetables;
    }


    @RequestMapping("toUserVip")
    public String toUserVip(){
        return  "user/userVip";
    }




}
