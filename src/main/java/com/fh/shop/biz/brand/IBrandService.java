package com.fh.shop.biz.brand;

import com.fh.shop.po.brand.Brand;

import java.util.List;

public interface IBrandService {
    Long findBrandCount();

    List<Brand> findPageBrandList(Brand brand);

    void addBrand(Brand brand);

    void deleteBrand(int id);

    Brand findUpdateBrand(int id);

    void status(int id);

    void sort(Long id, int sortId);

    void updateBrand(Brand brand);

    Brand queryUpdate(Long id);
}
