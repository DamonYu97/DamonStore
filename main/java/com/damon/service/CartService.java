package com.damon.service;

import com.damon.dao.entity.CartItem;
import com.damon.dao.entity.ItemDetail;

import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/22 19:48
 */

public interface CartService {
    /**
     * 插入购物车条目记录
     * @param cartItem
     * @return
     */
    Integer insert(CartItem cartItem);

    /**
     * 通过会员ID查看购物车条目记录
     * @param memberId
     * @return
     */
    List<CartItem> findCartItemByMemberId(BigInteger memberId);

    /**
     * 通过ID查看购物车条目记录
     * @param id
     * @return
     */
    CartItem findCartItemById(BigInteger id);

    /**
     * 通过会员ID和产品ID查看购物车条目记录
     * @param memberId
     * @param productId
     * @return
     */
    CartItem findCartItemByMemberProductId(BigInteger memberId, BigInteger productId);

    /**
     * 通过ID和数量更新购物车条目数量记录
     * @param id
     * @param quantity
     * @return
     */
    Integer updateQuantity(BigInteger id, BigInteger quantity);

    /**
     * 通过会员ID查看购物车条目详细记录
     * @param memberId
     * @return
     */
    List<ItemDetail> findCartItemDetailByMemberId(BigInteger memberId);

    /**
     * 根据ID删除购物车条目记录
     * @param id
     * @return
     */
    Integer delete(BigInteger id);
}
