package com.damon.service;

import com.damon.dao.entity.ReceiveAddress;

import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/19 17:36
 */

public interface ReceiveAddressService {
    /**
     * 插入收货地址纪录
     * @param receiveAddress
     * @return
     */
    Integer create(ReceiveAddress receiveAddress);

    /**
     * 通过ID显示所有有效收货地址纪录
     * @param id
     * @return
     */
    ReceiveAddress findValidReceiveAddressById(BigInteger id);

    /**
     * 通过会员ID显示所有有效收货地址纪录
     * @param memberId
     * @return
     */
    List<ReceiveAddress> findAllValidReceiveAddress(BigInteger memberId);

    /**
     * 更新收货地址纪录
     * @param receiveAddress
     * @return
     */
    Integer update(ReceiveAddress receiveAddress);
}
