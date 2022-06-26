package com.damon.service.impl;

import com.damon.dao.ReceiveAddressDao;
import com.damon.dao.entity.ReceiveAddress;
import com.damon.service.ReceiveAddressService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/19 17:43
 */
@Service
public class ReceiveAddressServiceImpl implements ReceiveAddressService {
    @Resource
    private ReceiveAddressDao receiveAddressDao;

    @Override
    public Integer create(ReceiveAddress receiveAddress) {
        return receiveAddressDao.insert(receiveAddress);
    }

    @Override
    public ReceiveAddress findValidReceiveAddressById(BigInteger id) {
        return receiveAddressDao.selectValidReceiveAddressById(id);
    }

    @Override
    public List<ReceiveAddress> findAllValidReceiveAddress(BigInteger memberId) {
        return receiveAddressDao.selectAllValidReceiveAddress(memberId);
    }

    @Override
    public Integer update(ReceiveAddress receiveAddress) {
        return receiveAddressDao.update(receiveAddress);
    }
}
