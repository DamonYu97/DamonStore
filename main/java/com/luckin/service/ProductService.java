package com.luckin.service;

import com.luckin.dao.entity.Product;
import com.luckin.dao.entity.ProductImage;
import com.luckin.dao.entity.ProductType;

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
    Product findProductById(BigInteger id);

    /**
     * 查询所有商品
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
     * 更新商品
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

    /**
     * 通过ID查看商品类型纪录
     * @param id
     * @return
     */
    ProductType findProductTypeById(int id);

    /**
     * 通过level查看商品类型纪录
     * @param level
     * @return
     */
    List<ProductType> findProductTypeByLevel(int level);
}
