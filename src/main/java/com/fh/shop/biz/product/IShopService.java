package com.fh.shop.biz.product;

import com.fh.shop.param.product.ParamSearchShop;
import com.fh.shop.po.brand.Brand;
import com.fh.shop.po.product.Shop;
import com.fh.shop.vo.product.ShopVo;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.util.List;

public interface IShopService {
    Long findShopCount(ParamSearchShop paramSearchShop);

    List<ShopVo> findPageShopList(ParamSearchShop paramSearchShop);

    void addShop(Shop shop);

    void deleteShop(int id);

    ShopVo findUpdateShop(int id);

    void updateShop(Shop shop);

    void isUpShop(int id);

    List<Shop> findShopList(ParamSearchShop productSearchParam);

}
