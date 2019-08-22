package com.luckin.dao;

import com.luckin.dao.entity.ProductType;

import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/08/08 17.26
 */
public interface ProductTypeDao {
    /**
     * 插入商品类型纪录
     * @param productType
     * @return
     */
    Integer insert(ProductType productType);

    /**
     * 更新商品类型纪录
     * @param productType
     * @return
     */
    Integer update(ProductType productType);

    /**
     * 通过ID查看商品类型纪录
     * @param id
     * @return
     */
    ProductType findProductTypeByID(int id);

    /**
     * 通过level查看商品类型纪录
     * @param level
     * @return
     */
    List<ProductType> findProductTypeByLevel(int level);
}
