package com.fh.shop.controller.log;

import com.fh.shop.biz.log.ILogService;
import com.fh.shop.commen.Datetables;
import com.fh.shop.param.log.LogParam;
import com.fh.shop.vo.log.LogVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("log")
public class LogController {

    @Resource
    private ILogService logService;

    @RequestMapping("list")
    @ResponseBody
    public Datetables list(LogParam logParam){
        Long count = logService.queryCount(logParam);
        List<LogVo> list = logService.findList(logParam);
        Datetables  logList = new Datetables(logParam.getDraw(),count,count,list);
        return logList;
    }

    @RequestMapping("toLog")
    public String toLog(){
        return  "log/list";
    }
}
