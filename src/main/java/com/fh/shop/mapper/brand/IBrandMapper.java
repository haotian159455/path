package com.fh.shop.mapper.brand;

import com.fh.shop.po.brand.Brand;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IBrandMapper {
    Long findBrandCount();

    List<Brand> findPageBrandList(Brand brand);

    void addBrand(Brand brand);

    void deleteBrand(int id);

    Brand findUpdateBrand(int id);

    void statusBrand(@Param("id") int id,@Param("status") int status);

    void sort(Brand brand);

    void updateBrand(Brand brand);

    Brand queryUpdate(Long id);
}
