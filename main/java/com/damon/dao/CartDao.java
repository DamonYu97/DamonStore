package com.damon.dao;

import com.damon.dao.entity.CartItem;
import com.damon.dao.entity.ItemDetail;
import org.apache.ibatis.annotations.Param;
import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/22 19:36
 */

public interface CartDao {
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
    List<CartItem> selectCartItemByMemberId(BigInteger memberId);

    /**
     * 通过会员ID查看购物车条目详细记录
     * @param memberId
     * @return
     */
    List<ItemDetail> selectCartItemDetailByMemberId(BigInteger memberId);

    /**
     * 通过ID查看购物车条目记录
     * @param id
     * @return
     */
    CartItem selectCartItemById(BigInteger id);

    /**
     * 通过会员ID和产品ID查看购物车条目记录
     * @param memberId
     * @param productId
     * @return
     */
    CartItem selectCartItemByMemberProductId(@Param("memberId") BigInteger memberId, @Param("productId") BigInteger productId);

    /**
     * 通过ID和数量更新购物车条目数量记录
     * @param id
     * @param quantity
     * @return
     */
    Integer updateQuantity(@Param("id") BigInteger id, @Param("quantity") BigInteger quantity);

    /**
     * 根据ID删除购物车条目记录
     * @param id
     * @return
     */
    Integer delete(BigInteger id);
}
