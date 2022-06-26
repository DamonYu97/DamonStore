package com.damon.dao.entity;

import java.math.BigDecimal;
import java.math.BigInteger;

/**
 * @author Lilin Yu
 * @Description 条目详情类
 * @since 2019/11/23 1:28
 */

public class ItemDetail {
    /**
     * id
     */
    private BigInteger id;
    /**
     * 会员id
     */
    private BigInteger memberId;
    /**
     * 商品id
     */
    private BigInteger productId;
    /**
     * 条目数量
     */
    private BigInteger quantity;
    /**
     * 主图url
     */
    private String url;
    /**
     * 商品名程
     */
    private String name;
    /**
     * 商品价格
     */
    private BigDecimal price;
    /**
     * 积分
     */
    private BigInteger point;

    public BigInteger getId() {
        return id;
    }

    public void setId(BigInteger id) {
        this.id = id;
    }

    public BigInteger getMemberId() {
        return memberId;
    }

    public void setMemberId(BigInteger memberId) {
        this.memberId = memberId;
    }

    public BigInteger getProductId() {
        return productId;
    }

    public void setProductId(BigInteger productId) {
        this.productId = productId;
    }

    public BigInteger getQuantity() {
        return quantity;
    }

    public void setQuantity(BigInteger quantity) {
        this.quantity = quantity;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigInteger getPoint() {
        return point;
    }

    public void setPoint(BigInteger point) {
        this.point = point;
    }


    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
