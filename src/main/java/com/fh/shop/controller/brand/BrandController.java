package com.fh.shop.controller.brand;

import com.auth0.jwt.internal.org.apache.commons.lang3.StringUtils;
import com.fh.shop.aspect.LogMessage;
import com.fh.shop.biz.brand.IBrandService;
import com.fh.shop.commen.Datetables;
import com.fh.shop.commen.ServerResponse;
import com.fh.shop.oss.OSSUtil;
import com.fh.shop.po.brand.Brand;
import com.fh.shop.utils.FileInputUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("brand")
public class BrandController {

    @Resource(name = "brandService")
    private IBrandService brandService;

    @RequestMapping("/toList")
    public String toList() {
        return "brand/list";
    }

    @RequestMapping("/findPageBrandList")
    @LogMessage("这是品牌查询方法")
    @ResponseBody
    public Datetables findPageBrandList(Brand brand) {
        Long count = brandService.findBrandCount();
        List<Brand> brandList = brandService.findPageBrandList(brand);
        Datetables datetables = new Datetables(brand.getDraw(), count, count, brandList);
        return datetables;
    }

    @RequestMapping("/addBrand")
    @LogMessage("这是品牌增加方法")
    @ResponseBody
    public ServerResponse addBrand(Brand brand) {
        try {
            brandService.addBrand(brand);
            return ServerResponse.success();
        } catch (Exception e) {
            e.printStackTrace();
            return ServerResponse.error();
        }
    }

    @RequestMapping("/addFileInput")
    @LogMessage("这是品牌图片上传方法")
    @ResponseBody
    public Map addFileInput(@RequestParam("files") CommonsMultipartFile file) {
        Map map = FileInputUtil.fileInput(file);
        return map;
    }

    @RequestMapping("/deleteBrand")
    @LogMessage("这是品牌删除方法")
    @ResponseBody
    public ServerResponse deleteBrand(int id) {
        try {
            Brand brand1 = brandService.queryUpdate(Integer.toUnsignedLong(id));
            String brandImg = brand1.getBrandImg();
            if(StringUtils.isNotEmpty(brandImg)){
                OSSUtil.delFile(brandImg);
            }
            brandService.deleteBrand(id);
            return ServerResponse.success();
        } catch (Exception e) {
            e.printStackTrace();
            return ServerResponse.error();
        }
    }

    @RequestMapping("/findUpdateBrand")
    @LogMessage("这是品牌回显方法")
    @ResponseBody
    public ServerResponse findUpdateBrand(int id) {
        try {
            Brand brand = brandService.findUpdateBrand(id);
            return ServerResponse.success(brand);
        } catch (Exception e) {
            e.printStackTrace();
            return ServerResponse.error();
        }
    }

    @RequestMapping("updateBrand")
    @LogMessage("这是品牌修改方法")
    @ResponseBody
    public ServerResponse updateBrand(Brand brand) {
        Brand brand1 = brandService.queryUpdate(brand.getId());
        String brandImg = brand1.getBrandImg();
        if(StringUtils.isNotEmpty(brandImg)){
            OSSUtil.delFile(brandImg);
        }
        brandService.updateBrand(brand);
        return ServerResponse.success();
    }


    @RequestMapping("sortBrand")
    @ResponseBody
    public ServerResponse sortBrand(Long id, int sortId) {
        brandService.sort(id, sortId);
        return ServerResponse.success();
    }


    @RequestMapping("status")
    @ResponseBody
    public ServerResponse status(int id) {
        brandService.status(id);
        return ServerResponse.success();
    }
}
