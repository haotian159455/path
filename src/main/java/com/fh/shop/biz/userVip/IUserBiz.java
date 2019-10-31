package com.fh.shop.biz.userVip;

import com.fh.shop.param.userVip.SearchUserVip;
import com.fh.shop.vo.userVip.UserVipVo;

import java.util.List;

public interface IUserBiz {

    List<UserVipVo> querySelect(SearchUserVip searchUserVip);

    Long count(SearchUserVip searchUserVip);

}
