package com.damon.dao.entity;

import java.math.BigDecimal;
import java.math.BigInteger;

/**
 * @author Lilin Yu
 * @Description 订单类
 * @since 2019/11/11 15:44
 */

public class Order {
    /**
     * id
     */
    private BigInteger id;
    /**
     * 会员id
     */
    private BigInteger memberId;
    /**
     * 收货人姓名
     */
    private String receiverName;
    /**
     * 收货人手机号
     */
    private String receiverPhone;
    /**
     * 收货人地址
     */
    private String receiverAddress;
    /**
     * 订单总价格
     */
    private BigDecimal totalPrice;
    /**
     * 订单总消耗积分
     */
    private BigInteger totalPoint;
    /**
     *订单创建时间
     */
    private String createTime;
    /**
     * 订单修改时间
     */
    private String modifyTime;
    /**
     * 订单状态
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

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public BigInteger getTotalPoint() {
        return totalPoint;
    }

    public void setTotalPoint(BigInteger totalPoint) {
        this.totalPoint = totalPoint;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(String modifyTime) {
        this.modifyTime = modifyTime;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}
