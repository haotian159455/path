package com.fh.shop.biz.goods;

import com.fh.shop.mapper.goods.IGoodsMapper;
import com.fh.shop.param.goods.GoodsParam;
import com.fh.shop.po.goods.Goods;
import com.fh.shop.utils.DateUtil;
import com.fh.shop.vo.goods.GoodsVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class GoodsServiceImpl implements GoodsService{
    @Resource
    private IGoodsMapper goodsMapper;


    @Override
    public Long queryCount(GoodsParam goodsParam) {
        Long count = goodsMapper.queryCount(goodsParam);
        return count;
    }

    @Override
    public List<GoodsVo> queryList(GoodsParam goodsParam) {
        List<Goods> goodsList = goodsMapper.queryList(goodsParam);
        List<GoodsVo> goodsVoList = new ArrayList<>();
        VoPo(goodsList, goodsVoList);
        return goodsVoList;
    }

    @Override
    public void add(Goods goods) {
        goodsMapper.insert(goods);
    }

    @Override
    public void deleteGoods(Long id) {
        goodsMapper.deleteById(id);
    }

    //查询vo转po
    private void VoPo(List<Goods> goodsList, List<GoodsVo> goodsVoList) {
        for (Goods goodsVo : goodsList) {
            GoodsVo vo = new GoodsVo();
            vo.setId(goodsVo.getId());
            vo.setGoodsName(goodsVo.getGoodsName());
            vo.setPrice(goodsVo.getPrice());
            vo.setCreateDate(DateUtil.date2str(goodsVo.getCreateDate(),DateUtil.Y_M_D));
            goodsVoList.add(vo);
        }
    }
}
