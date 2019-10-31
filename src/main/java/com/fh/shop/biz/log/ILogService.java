package com.fh.shop.biz.log;

import com.fh.shop.commen.Datetables;
import com.fh.shop.param.log.LogParam;
import com.fh.shop.po.log.Log;
import com.fh.shop.vo.log.LogVo;

import java.util.List;

public interface ILogService {

    Long queryCount(LogParam logParam);

    List<LogVo> findList(LogParam logParam);

    public void add(Log log);

}
