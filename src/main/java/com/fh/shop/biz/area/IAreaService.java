package com.fh.shop.biz.area;

import com.fh.shop.po.area.Area;

import java.util.List;
import java.util.Map;

public interface IAreaService {
    Map selectAreaList();
    Map addArea(Area area);
    Map updateArea(Area area);
    Map deleteArea(List<Integer> idList);
    List<Area> queryArea(Long id);
}
