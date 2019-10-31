package com.fh.shop.mapper.UserVip;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.param.userVip.SearchUserVip;
import com.fh.shop.po.userVip.UserVip;

import java.util.List;

public interface UserVipMapper extends BaseMapper<UserVip> {

    Long queryCount(SearchUserVip searchUserVip);

    List<UserVip> findUserVipList(SearchUserVip searchUserVip);

}
