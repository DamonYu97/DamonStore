package com.damon.dao.entity;

import java.math.BigInteger;

/**
 * @author Lilin Yu
 * @Description 收货地址类
 * @since 2019/11/11 17:21
 */

public class ReceiveAddress {
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
     * 收货人手机号码
     */
    private String receiverPhone;
    /**
     * 省份
     */
    private String province;
    /**
     * 城市
     */
    private String city;
    /**
     * 补充的地址详细信息
     */
    private String detail;
    /**
     * 是否为默认地址
     */
    private int isDefault;
    /**
     * 收货地址状态
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

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public int getIsDefault() {
        return isDefault;
    }

    public void setIsDefault(int isDefault) {
        this.isDefault = isDefault;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
