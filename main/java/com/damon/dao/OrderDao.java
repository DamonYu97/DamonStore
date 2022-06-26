package com.damon.dao;

import com.damon.dao.entity.ItemDetail;
import com.damon.dao.entity.Order;
import com.damon.dao.entity.OrderItem;
import org.apache.ibatis.annotations.Param;

import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/11 16:27
 */

public interface OrderDao {

    /**
     * 插入新订单
     * @param order
     * @return 新订单的ID
     */
     Integer insertOrder(Order order);

    /**
     * 更新订单
     * @param order
     * @return
     */
     Integer update(Order order);

    /**
     * 插入订单条目
     * @param orderItem
     * @return
     */
    Integer insertOrderItem(OrderItem orderItem);

    /**
     * 更新库存
     * @param quantity
     * @param productId
     * @return
     */
    Integer updateStock(@Param("quantity") BigInteger quantity, @Param("productId") BigInteger productId);

    /**
     * 更新状态
     * @param orderId
     * @param status
     * @return
     */
    Integer updateStatus(@Param("orderId") BigInteger orderId, @Param("status") int status);

    /**
     * 更新修改时间
     * @param orderId
     * @param currentTime
     * @return
     */
    Integer updateModifyTime(@Param("orderId") BigInteger orderId, @Param("currentTime") String currentTime);

    /**
     * 通过会员ID查找所有订单
     * @param memberId
     * @return
     */
    List<Order> findAllOrderByMemberId(BigInteger memberId);

    /**
     * 通过会员ID和状态查找所有订单
     * @param memberId
     * @param status
     * @return
     */
    List<Order> findAllOrderByMemberIdStatus(@Param("memberId") BigInteger memberId, @Param("status") int status);


    /**
     * 查找所有订单信息
     * @return
     */
    List<Order> findAllOrder();

    /**
     * 通过订单ID查找所有订单条目
     * @param orderId
     * @return
     */
    List<OrderItem> findOrderItemById(BigInteger orderId);

    /**
     * 通过订单ID查找所有订单条目详情
     * @param orderId
     * @return
     */
    List<ItemDetail> findOrderItemDetailById(BigInteger orderId);

    /**
     * 通过订单ID查找订订单信息
     * @param orderId
     * @return
     */
     Order findOrderByOrderId(BigInteger orderId);

    /**
     * 通过商品ID查找条目详情
     * @param productId
     * @return
     */
     ItemDetail findItemDetailByProductId(BigInteger productId);

    /**
     * 通过购物车ID查找条目详情
     * @param cartItemId
     * @return
     */
    ItemDetail findItemDetailByCartItemId(BigInteger cartItemId);
}
