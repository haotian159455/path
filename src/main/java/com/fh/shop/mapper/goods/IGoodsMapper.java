package com.fh.shop.mapper.goods;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.param.goods.GoodsParam;
import com.fh.shop.po.goods.Goods;

import java.util.List;

public interface IGoodsMapper extends BaseMapper<Goods> {

    Long queryCount(GoodsParam goodsParam);

    List<Goods> queryList(GoodsParam goodsParam);
}
