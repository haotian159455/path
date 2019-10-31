package com.fh.shop.biz.brand;

import com.alibaba.fastjson.JSONObject;
import com.auth0.jwt.internal.org.apache.commons.lang3.StringUtils;
import com.fh.shop.mapper.brand.IBrandMapper;
import com.fh.shop.oss.OSSUtil;
import com.fh.shop.po.brand.Brand;
import com.fh.shop.utils.RedisPool;
import com.fh.shop.utils.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import redis.clients.jedis.Jedis;

import java.util.List;

@Service("brandService")
public class BrandServiceImpl implements IBrandService {
    @Autowired
    private IBrandMapper brandMapper;

    @Override
    public Long findBrandCount() {
        Long count = brandMapper.findBrandCount();
        return count;
    }

    @Override
    public List<Brand> findPageBrandList(Brand brand) {
        //先判断缓存中是否存在
        String brandListJson = RedisUtil.get("brandList");
        if(StringUtils.isEmpty(brandListJson)){
           //从数据库取出数据
            List<Brand> pageBrandList = brandMapper.findPageBrandList(brand);
            //将java对象转换为json格式的字符串
             brandListJson = JSONObject.toJSONString(pageBrandList);
            //放入缓存中
            RedisUtil.set("brandList",brandListJson);
            //返回
            return pageBrandList;
        }else{
            //将json格式的字符串转换为java对象
            List<Brand> brands = JSONObject.parseArray(brandListJson, Brand.class);
            return brands;
        }
    }

    @Override
    public void addBrand(Brand brand) {
        RedisUtil.del("brandList");
        brandMapper.addBrand(brand);
    }

    @Override
    public void deleteBrand(int id) {
        RedisUtil.del("brandList");
        brandMapper.deleteBrand(id);
    }

    @Override
    public Brand findUpdateBrand(int id) {
        Brand updateBrand = brandMapper.findUpdateBrand(id);
        return updateBrand;
    }

    @Override
    public void status(int id) {
        RedisUtil.del("brandList");
        int status = 0;
        Brand updateStatus = brandMapper.findUpdateBrand(id);
        if(updateStatus.getStatus() ==1){
            status = 0;
        }else{
            status = 1;
        }
        brandMapper.statusBrand(id,status);
    }

    @Override
    public void sort(Long id, int sortId) {
        RedisUtil.del("brandList");
        Brand brand = new Brand();
        brand.setId(id);
        brand.setSortId(sortId);
        brandMapper.sort(brand);

    }

    @Override
    public void updateBrand(Brand brand) {
        RedisUtil.del("brandList");
        brandMapper.updateBrand(brand);
    }

    @Override
    public Brand queryUpdate(Long id) {
        return brandMapper.queryUpdate(id);
    }


}
