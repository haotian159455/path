package com.fh.shop.biz.area;

import com.fh.shop.mapper.area.IAreaMapper;
import com.fh.shop.po.area.Area;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AreaServiceImpl implements IAreaService {

    @Resource
    private IAreaMapper areaMapper;


    @Override
    public Map selectAreaList() {
        Map result=new HashMap();
        try {
            List   list = areaMapper.selectAreaList();
            result.put("code","200");
            result.put("msg","ok");
            result.put("data",list);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code","-1");
            result.put("msg","error");
        }
        return result;
    }

    @Override
    public Map addArea(Area area) {
        Map result=new HashMap();
        try {
            areaMapper.addArea(area);
            result.put("code","200");
            result.put("msg","ok");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code","-1");
            result.put("msg","error");
        }
        return result;
    }

    @Override
    public Map updateArea(Area area) {
        Map result=new HashMap();
        try {
            areaMapper.updateArea(area);
            result.put("code","200");
            result.put("msg","ok");

        } catch (Exception e) {
            e.printStackTrace();
            result.put("code","-1");
            result.put("msg","error");
        }
        return result;
    }

    @Override
    public Map deleteArea(List<Integer> idList) {
        Map result=new HashMap();
        try {
            areaMapper.deleteArea(idList);
            result.put("code","200");
            result.put("msg","ok");

        } catch (Exception e) {
            e.printStackTrace();
            result.put("code","-1");
            result.put("msg","error");
        }
        return result;
    }

    @Override
    public List<Area> queryArea(Long id) {
        return areaMapper.queryArea(id);
    }


}
