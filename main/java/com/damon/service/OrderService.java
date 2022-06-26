package com.damon.service;

import com.damon.dao.entity.ItemDetail;
import com.damon.dao.entity.Order;
import com.damon.dao.entity.OrderItem;

import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/11 16:30
 */

public interface OrderService {
    /**
     * 新建订单
     * @param order
     * @return 新订单的ID
     */
    Integer createOrder(Order order);

    /**
     * 更新订单
     * @param order
     * @return
     */
    Integer update(Order order);

    /**
     * 新建订单条目
     * @param orderItem
     * @return
     */
    Integer createOrderItem(OrderItem orderItem);

    /**
     * 更新库存
     * @param quantity
     * @param productId
     * @return
     */
    Integer updateStock(BigInteger quantity, BigInteger productId);

    /**
     * 更新订单到待发货状态
     * @param orderId
     * @return
     */
    Integer updateToUnshipped(BigInteger orderId);

    /**
     * 更新订单到待收货状态
     * @param orderId
     * @return
     */
    Integer updateToUnreceived(BigInteger orderId);

    /**
     * 更新订单到完成状态
     * @param orderId
     * @return
     */
    Integer updateToDone(BigInteger orderId);

    /**
     * 更新订单到取消状态
     * @param orderId
     * @return
     */
    Integer updateToCancel(BigInteger orderId);

    /**
     * 更新修改时间
     * @param orderId
     * @param currentTime
     * @return
     */
    Integer updateModifyTime(BigInteger orderId, String currentTime);

    /**
     * 通过会员ID查找所有订单
     * @param memberId
     * @return
     */
    List<Order> findAllOrderByMemberId(BigInteger memberId);

    /**
     * 通过会员ID查找所有未付款订单
     * @param memberId
     * @return
     */
    List<Order> findAllUnpaidOrderByMemberId(BigInteger memberId);

    /**
     * 通过会员ID查找所有待发货订单
     * @param memberId
     * @return
     */
    List<Order> findAllUnshippedOrderByMemberId(BigInteger memberId);

    /**
     * 通过会员ID查找所有待收货订单
     * @param memberId
     * @return
     */
    List<Order> findAllUnreceivedOrderByMemberId(BigInteger memberId);

    /**
     * 查找所有订单信息
     * @return
     */
    List<Order> findAllOrder();

    /**
     * 通过订单ID查找订订单信息
     * @param orderId
     * @return
     */
    Order findOrderByOrderId(BigInteger orderId);

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
