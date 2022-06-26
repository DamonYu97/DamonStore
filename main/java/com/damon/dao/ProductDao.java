package com.damon.dao;


import com.damon.dao.entity.Product;
import com.damon.dao.entity.ProductImage;

import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/08 15:44
 */
public interface ProductDao {

    /**
     * 插入商品纪录
     * @param product
     * @return
     */
    Integer insert(Product product);

    /**
     * 通过商品ID查询商品纪录
     * @param id
     * @return
     */
    Product findProductById(BigInteger id);

    /**
     * 查询所有商品纪录
     * @return
     */
    List<Product> findAllProduct();

    /**
     * 查询所有有效商品纪录
     * @return
     */
    List<Product> findAllValidProduct();

    /**
     * 通过类型ID查询所有有效商品纪录
     * @param typeId
     * @return
     */
    List<Product> findAllValidProductByTypeId(int typeId);

    /**
     * 更新商品商品纪录
     * @param product
     * @return
     */
    Integer update(Product product);

    /**
     * 通过商品ID查看商品图片
     * @param id
     * @return
     */
    List<ProductImage> findImageById(BigInteger id);

    /**
     * 通过商品ID查看商品主图片
     * @param id
     * @return
     */
    ProductImage findMainImageById(BigInteger id);
}
