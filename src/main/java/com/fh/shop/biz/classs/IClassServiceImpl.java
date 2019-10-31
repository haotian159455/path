package com.fh.shop.biz.classs;

import com.alibaba.fastjson.JSONObject;
import com.auth0.jwt.internal.org.apache.commons.lang3.StringUtils;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.fh.shop.mapper.classs.IClassMapper;
import com.fh.shop.po.classs.ClassPo;
import com.fh.shop.utils.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


@Service(value="ClassService")
public class IClassServiceImpl implements IClassService{
    @Autowired
    private IClassMapper classMapper;

    //查询所有
    @Override
    public List<ClassPo> findAllClass() {

        List<ClassPo> classPos = classMapper.selectList(null);
        return classPos;
    }

    @Override
    public void deleteClass(List<Long> list) {
        classMapper.deleteBatchIds(list);
    }

    @Override
    public Long addClass(ClassPo classPo) {
        Long insert = Long.valueOf(classMapper.insert(classPo));
        return insert;
    }

    @Override
    public ClassPo findClassById(Long id) {
        ClassPo classPo = classMapper.selectById(id);
        return classPo;
    }

    @Override
    public void updateClass(ClassPo classPo) {
        UpdateWrapper<ClassPo> w = new UpdateWrapper();
        w.eq("id",classPo.getId());
        classMapper.update(classPo,w);
    }

    @Override
    public List<ClassPo> queryClass(Long id) {
        //先查询redis中有没有这个key
        String classQueryJson = RedisUtil.get("classQueryJson");
        if(StringUtils.isNotEmpty(classQueryJson)){
            List<ClassPo> classPoList = JSONObject.parseArray(classQueryJson, ClassPo.class);
            List<ClassPo> childList = findChildList(id, classPoList);
            return childList;
        }
        List<ClassPo> classPoList = classMapper.selectList(null);
        classQueryJson = JSONObject.toJSONString(classPoList);
        RedisUtil.set("classQueryJson",classQueryJson);
        List<ClassPo> childList = findChildList(id, classPoList);
        return childList;
    }
    private List<ClassPo> findChildList(Long id, List<ClassPo> allClassPoList){
        List<ClassPo> classPoList = new ArrayList<>();
        for (ClassPo allClass : allClassPoList) {
            if(allClass.getPid() == id){
                classPoList.add(allClass);
            }
        }
        return classPoList;
    }
}