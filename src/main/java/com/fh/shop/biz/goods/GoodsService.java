package com.fh.shop.biz.goods;

import com.fh.shop.param.goods.GoodsParam;
import com.fh.shop.po.goods.Goods;
import com.fh.shop.vo.goods.GoodsVo;

import java.util.List;

public interface GoodsService {
    Long queryCount(GoodsParam goodsParam);

    List<GoodsVo> queryList(GoodsParam goodsParam);

    void add(Goods goods);

    void deleteGoods(Long id);
}
