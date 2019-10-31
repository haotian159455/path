package com.fh.shop.mapper.product;

import com.fh.shop.param.product.ParamSearchShop;
import com.fh.shop.po.product.Shop;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IShopMapper {
    Long findShopCount(ParamSearchShop paramSearchShop);

    List<Shop> findPageShopList(ParamSearchShop paramSearchShop);

    void addShop(Shop shop);

    void deleteShop(int id);

    Shop findUpdateShop(int id);

    void updateShop(Shop shop);

    void isUpShop(@Param("id") int id, @Param("isUp") int isUp);

    List selectBrandList(Long id);

    List<Shop> findShopList(ParamSearchShop productSearchParam);
}
