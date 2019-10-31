package com.fh.shop.controller.goods;

import com.fh.shop.biz.goods.GoodsService;
import com.fh.shop.commen.Datetables;
import com.fh.shop.commen.ServerResponse;
import com.fh.shop.param.goods.GoodsParam;
import com.fh.shop.po.goods.Goods;
import com.fh.shop.vo.goods.GoodsVo;
import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("goods")
public class GoodsController {

    @Resource
    private GoodsService goodsService;

    @RequestMapping("toList")
    public String toList(){
        return  "goods/list";
    }

    @RequestMapping("list")
    @ResponseBody
    public Datetables list(GoodsParam goodsParam){
        //查询总条数
        Long count = goodsService.queryCount(goodsParam);
        //查询分页信息
        List<GoodsVo> goodsVos = goodsService.queryList(goodsParam);
        return new Datetables(goodsParam.getDraw(),count,count,goodsVos);
    }

    @RequestMapping("add")
    @ResponseBody
    public ServerResponse add(Goods goods){
        goodsService.add(goods);
        return ServerResponse.success();
    }

    @RequestMapping("deleteGoods")
    @ResponseBody
    public ServerResponse deleteGoods(Long id){
        goodsService.deleteGoods(id);
        return  ServerResponse.success();
    }
}
