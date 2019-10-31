package com.fh.shop.biz.log;

import com.fh.shop.commen.Datetables;
import com.fh.shop.mapper.log.ILogMapper;
import com.fh.shop.param.log.LogParam;
import com.fh.shop.po.log.Log;
import com.fh.shop.utils.DateUtil;
import com.fh.shop.vo.log.LogVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class ILogServiceImpl implements ILogService{

    @Resource
    private ILogMapper logMapper;
    //查询总条数
    @Override
    public Long queryCount(LogParam logParam) {
        Long count = logMapper.queryCount(logParam);
        return count;
    }
    //查询
    @Override
    public List<LogVo> findList(LogParam logParam) {
        List<Log> logList = logMapper.queryFindList(logParam);
        List<LogVo> logVoList = new ArrayList<>();
        poVo(logList, logVoList);
        return logVoList;
    }
    //查询po转vo
    private void poVo(List<Log> logList, List<LogVo> logVoList) {
        for (Log lo : logList) {
            LogVo vo = new LogVo();
            vo.setId(lo.getId());
            vo.setUserName(lo.getUserName());
            vo.setRealName(lo.getRealName());
            vo.setInfo(lo.getInfo());
            vo.setStatus(lo.getStatus());
            vo.setErrorMsg(lo.getErrorMsg());
            vo.setCurrDate(DateUtil.date2str(lo.getCurrDate(),DateUtil.FOR_YEAR));
            vo.setDatail(lo.getDatail());
            vo.setContent(lo.getContent());
            logVoList.add(vo);
        }
    }
    //增加
    @Override
    public void add(Log log){
        logMapper.add(log);
    }


}
