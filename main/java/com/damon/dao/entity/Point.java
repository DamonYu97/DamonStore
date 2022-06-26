package com.damon.dao.entity;

import java.math.BigInteger;

/**
 * @author Lilin Yu
 * @Description 积分纪录类
 * @since 2019/11/11 20:17
 */

public class Point {
    /**
     * id
     */
    private BigInteger id;
    /**
     * 会员id
     */
    private BigInteger memberId;
    /**
     * 积分类型
     */
    private int type;
    /**
     * 积分数
     */
    private BigInteger point;
    /**
     * 订单id
     */
    private BigInteger orderId;
    /**
     * 积分纪录创建时间
     */
    private String createTime;
    /**
     * 积分纪录状态
     */
    private int status;

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

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public BigInteger getPoint() {
        return point;
    }

    public void setPoint(BigInteger point) {
        this.point = point;
    }

    public BigInteger getOrderId() {
        return orderId;
    }

    public void setOrderId(BigInteger orderId) {
        this.orderId = orderId;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
