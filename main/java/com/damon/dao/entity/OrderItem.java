package com.damon.dao.entity;

import java.math.BigDecimal;
import java.math.BigInteger;

/**
 * @author Lilin Yu
 * @Description 商品条目类
 * @since 2019/11/11 16:01
 */

public class OrderItem {
    /**
     * 商品id
     */
    private BigInteger productId;
    /**
     * 订单id
     */
    private BigInteger orderId;
    /**
     * 条目商品单价价格
     */
    private BigDecimal price;
    /**
     * 条目商品数量
     */
    private BigInteger quantity;

    public BigInteger getProductId() {
        return productId;
    }

    public void setProductId(BigInteger productId) {
        this.productId = productId;
    }

    public BigInteger getOrderId() {
        return orderId;
    }

    public void setOrderId(BigInteger orderId) {
        this.orderId = orderId;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigInteger getQuantity() {
        return quantity;
    }

    public void setQuantity(BigInteger quantity) {
        this.quantity = quantity;
    }
}
