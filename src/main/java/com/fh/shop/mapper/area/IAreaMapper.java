package com.fh.shop.mapper.area;

import com.fh.shop.po.area.Area;

import java.util.List;

public interface IAreaMapper {
    List selectAreaList();

    void addArea(Area area);

    void updateArea(Area area);

    void deleteArea(List<Integer> idList);

    List<Area> queryArea(Long id);
}
