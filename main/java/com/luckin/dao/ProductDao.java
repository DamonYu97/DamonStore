package com.luckin.dao;


import com.luckin.dao.entity.Product;
import com.luckin.dao.entity.ProductImage;

import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/08/08 15:44
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
    Product findProductByID(BigInteger id);

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
     * @param typeID
     * @return
     */
    List<Product> findAllValidProductByTypeID(int typeID);

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
    List<ProductImage> findImageByID(BigInteger id);

    /**
     * 通过商品ID查看商品主图片
     * @param id
     * @return
     */
    ProductImage findMainImageByID(BigInteger id);
}
