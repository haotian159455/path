package com.fh.shop.biz.userVip;

import com.fh.shop.mapper.UserVip.UserVipMapper;
import com.fh.shop.param.userVip.SearchUserVip;
import com.fh.shop.po.userVip.UserVip;
import com.fh.shop.utils.DateUtil;
import com.fh.shop.vo.userVip.UserVipVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class IUserBizImpl implements IUserBiz {

    @Resource
    private UserVipMapper userVipMapper;

    @Override
    public List<UserVipVo> querySelect(SearchUserVip searchUserVip) {
        List<UserVip> userVips = userVipMapper.findUserVipList(searchUserVip);
        List<UserVipVo> userVipVoList = new ArrayList<>();
        selectPoVo(userVips, userVipVoList);
        return userVipVoList;
    }

    private void selectPoVo(List<UserVip> userVips, List<UserVipVo> userVipVoList) {
        for (UserVip userPo : userVips) {
            UserVipVo userVipVo = new UserVipVo();
            userVipVo.setId(userPo.getId());
            userVipVo.setName(userPo.getName());
            userVipVo.setRealName(userPo.getRealName());
            userVipVo.setEmail(userPo.getEmail());
            userVipVo.setPhone(userPo.getPhone());
            userVipVo.setBirthday(DateUtil.date2str(userPo.getBirthday(),DateUtil.Y_M_D));
            userVipVo.setClName(userPo.getClName());
            userVipVoList.add(userVipVo);
        }
    }

    @Override
    public Long count(SearchUserVip searchUserVip) {
        Long count = userVipMapper.queryCount(searchUserVip);
        return count;
    }

}
