package com.fh.shop.controller.area;

import com.fh.shop.aspect.LogMessage;
import com.fh.shop.biz.area.IAreaService;
import com.fh.shop.commen.ServerResponse;
import com.fh.shop.po.area.Area;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("area")
public class AreaController {

    @Autowired
    private IAreaService areaService;

    @RequestMapping("toList")
    public String  toList(){
        return "area/area";
    }

  @RequestMapping("selectAreaList")
  @LogMessage("这是地区查询方法")
  @ResponseBody
    public Map selectAreaList(){
        Map result=areaService.selectAreaList();
        return result;
    }

    @RequestMapping("addArea")
    @LogMessage("这是地区增加方法")
    @ResponseBody
    public Map addArea(Area area){
        Map result=areaService.addArea(area);
        return result;
    }

    @RequestMapping("updateArea")
    @LogMessage("这是地区修改方法")
    @ResponseBody
    public Map updateArea(Area area){
        Map result=areaService.updateArea(area);
        return result;
    }

    @RequestMapping("deleteArea")
    @LogMessage("这是地区删除方法")
    @ResponseBody
    public Map deleteArea(@RequestParam("ids[]") List<Integer> idList){
        Map result=areaService.deleteArea(idList);
        return result;
    }

    @RequestMapping("queryArea")
    @ResponseBody
    public ServerResponse queryArea(Long id){
        List<Area> areaList = areaService.queryArea(id);
        return  ServerResponse.success(areaList);
    }

}
