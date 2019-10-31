package com.fh.shop.biz.product;

import com.auth0.jwt.internal.org.apache.commons.lang3.StringUtils;
import com.fh.shop.mapper.product.IShopMapper;
import com.fh.shop.param.product.ParamSearchShop;
import com.fh.shop.po.product.Shop;
import com.fh.shop.utils.DateUtil;
import com.fh.shop.vo.product.ShopVo;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.xml.crypto.Data;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.*;

@Service("shopService")
public class ShopServiceImpl implements IShopService {

    @Resource
    private IShopMapper shopMapper;

    @Override
    public Long findShopCount(ParamSearchShop paramSearchShop) {
        Long shopCount = shopMapper.findShopCount(paramSearchShop);
        return shopCount;
    }

    @Override
    public List<ShopVo> findPageShopList(ParamSearchShop paramSearchShop) {
        List<Shop> pageShopList = shopMapper.findPageShopList(paramSearchShop);
        List<ShopVo> shopVoList = new ArrayList<>();
        selectPoVo(pageShopList, shopVoList);
        return shopVoList;
    }

    private void selectPoVo(List<Shop> pageShopList, List<ShopVo> shopVoList) {
        for (Shop shopList : pageShopList) {
            ShopVo shopVo = getShopVo(shopList);
            List s = shopMapper.selectBrandList(shopList.getId());
            String a = StringUtils.join(s);
            a = a.substring(1,a.length()-1);
            shopVo.setBrandIds(a);
            shopVoList.add(shopVo);
        }
    }

    @Override
    public void addShop(Shop shop) {
        shopMapper.addShop(shop);
    }

    @Override
    public void deleteShop(int id) {
        shopMapper.deleteShop(id);
    }

    @Override
    public ShopVo findUpdateShop(int id) {
        Shop updateShop = shopMapper.findUpdateShop(id);
        ShopVo shopVo = getShopVo(updateShop);
        return shopVo;
    }

    @Override
    public void updateShop(Shop shop) {
        shopMapper.updateShop(shop);
    }

    @Override
    public void isUpShop(int id) {
        int isUp=0;
        Shop updateShop = shopMapper.findUpdateShop(id);
        if (updateShop.getIsUp()==1){
            isUp=0;
        }else{
            isUp=1;
        }
        shopMapper.isUpShop(id,isUp);
    }

    @Override
    public List<Shop> findShopList(ParamSearchShop productSearchParam) {
        return shopMapper.findShopList(productSearchParam);
    }


    private ShopVo getShopVo(Shop shopList) {
        ShopVo shopVo =new ShopVo();
        shopVo.setId(shopList.getId());
        shopVo.setShopName(shopList.getShopName());
        shopVo.setPrice(shopList.getPrice().toString());
        shopVo.setShopImg(shopList.getShopImg());
        shopVo.setIsUp(shopList.getIsUp());
        shopVo.setIsSaleWell(shopList.getIsSaleWell());
        shopVo.setStock(shopList.getStock());
        shopVo.setShopTime(DateUtil.date2str(shopList.getShopTime(),DateUtil.FOR_YEAR));
        shopVo.setClName(shopList.getClName());
        return shopVo;
    }

}
