package com.fh.shop.mapper.classs;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.po.classs.ClassPo;

import java.util.List;

public interface IClassMapper extends BaseMapper<ClassPo> {
    List<ClassPo> queryClass(Long id);
}
