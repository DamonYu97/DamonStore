package com.damon.service.impl;

import com.damon.dao.CartDao;
import com.damon.dao.entity.CartItem;
import com.damon.dao.entity.ItemDetail;
import com.damon.service.CartService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/22 19:50
 */
@Service
public class CartServiceImpl  implements CartService {
    @Resource
    private CartDao cartDao;

    @Override
    public Integer insert(CartItem cartItem) {
        return cartDao.insert(cartItem);
    }

    @Override
    public List<CartItem> findCartItemByMemberId(BigInteger memberId) {
        return cartDao.selectCartItemByMemberId(memberId);
    }

    @Override
    public CartItem findCartItemById(BigInteger id) {
        return cartDao.selectCartItemById(id);
    }

    @Override
    public CartItem findCartItemByMemberProductId(BigInteger memberId, BigInteger productId) {
        return cartDao.selectCartItemByMemberProductId(memberId,productId);
    }

    @Override
    public Integer updateQuantity(BigInteger id, BigInteger quantity) {
        return cartDao.updateQuantity(id,quantity);
    }

    @Override
    public List<ItemDetail> findCartItemDetailByMemberId(BigInteger memberId) {
        return cartDao.selectCartItemDetailByMemberId(memberId);
    }

    @Override
    public Integer delete(BigInteger id) {
        return cartDao.delete(id);
    }
}
