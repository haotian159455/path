package com.fh.shop.biz.classs;


import com.fh.shop.po.classs.ClassPo;

import java.util.List;


public interface IClassService {
//获取所有信息 ztree使用
    List<ClassPo> findAllClass();

    void deleteClass(List<Long> list);

    Long addClass(ClassPo classPo);

    ClassPo findClassById(Long id);

    void updateClass(ClassPo classPo);

    List<ClassPo> queryClass(Long id);
}
