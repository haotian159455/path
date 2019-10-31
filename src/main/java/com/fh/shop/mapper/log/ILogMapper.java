package com.fh.shop.mapper.log;

import com.fh.shop.param.log.LogParam;
import com.fh.shop.po.log.Log;

import java.util.List;

public interface ILogMapper {

    Long queryCount(LogParam logParam);

    List<Log> queryFindList(LogParam logParam);

    void add(Log log);
}
