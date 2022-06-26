package com.damon.dao.entity;

import java.math.BigInteger;

/**
 * @author Lilin Yu
 * @Description 购物车条目类
 * @since 2019/11/22 19:32
 */

public class CartItem {
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
     * 购物车单项条目商品数量
     */
    private BigInteger quantity;

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
}
