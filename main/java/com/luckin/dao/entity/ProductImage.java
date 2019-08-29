package com.luckin.dao.entity;

import java.math.BigInteger;

/**
 * @author Lilin Yu
 * @Description 商品图片类
 * @since 2019/08/08 15:24
 */
public class ProductImage {
    /**
     * id
     */
    private BigInteger id;
    /**
     * 商品id
     */
    private BigInteger productId;
    /**
     * 商品图片URL
     */
    private String url;
    /**
     * 商品是否为主图
     */
    private int isMain;

    public BigInteger getId() {
        return id;
    }

    public void setId(BigInteger id) {
        this.id = id;
    }

    public BigInteger getProductId() {
        return productId;
    }

    public void setProductId(BigInteger productId) {
        this.productId = productId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getIsMain() {
        return isMain;
    }

    public void setIsMain(int isMain) {
        this.isMain = isMain;
    }

}
