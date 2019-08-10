package com.luckin.service;

import com.luckin.dao.entity.Product;
import com.luckin.dao.entity.ProductImage;

import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/08/08 16.21
 */
public interface ProductService {
    /**
     * 新增商品
     * @param product
     * @return
     */
    Integer create(Product product);

    /**
     * 通过商品ID查询商品商品信息
     * @param id
     * @return
     */
    Product findProductByID(BigInteger id);

    /**
     * 查询所有商品
     * @return
     */
    List<Product> findAllProduct();

    /**
     * 更新商品
     * @param product
     * @return
     */
    Integer update(Product product);

    /**
     * 下架商品
     * @param id
     * @return
     */
    Integer updateStatusToInvalid(BigInteger id);

    /**
     * 通过商品ID查看商品图片
     * @param id
     * @return
     */
    List<ProductImage> findImageByID(BigInteger id);

    /**
     * 通过商品ID查看商品主图片
     * @param id
     * @return
     */
    ProductImage findMainImageByID(BigInteger id);
}
