package com.damon.service.impl;

import com.damon.dao.OrderDao;
import com.damon.dao.entity.ItemDetail;
import com.damon.dao.entity.Order;
import com.damon.dao.entity.OrderItem;
import com.damon.service.OrderService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/11 16:35
 */
@Service
public class OrderServiceImpl implements OrderService {
    private final int CANCEL = 0;
    private final int UNPAID = 1;
    private final int UNSHIPPED = 2;
    private final int UNRECEIVED = 3;
    private final int DONE = 4;
    @Resource
    private OrderDao orderDao;

    @Override
    public Integer createOrder(Order order) {
        return orderDao.insertOrder(order);
    }

    @Override
    public Integer update(Order order) {
        return orderDao.update(order);
    }

    @Override
    public Integer createOrderItem(OrderItem orderItem) {
        return orderDao.insertOrderItem(orderItem);
    }

    @Override
    public Integer updateStock(BigInteger stock, BigInteger productId) {
        return orderDao.updateStock(stock,productId);
    }

    @Override
    public Integer updateToUnshipped(BigInteger orderId) {
        return orderDao.updateStatus(orderId,UNSHIPPED);
    }

    @Override
    public Integer updateToUnreceived(BigInteger orderId) {
        return orderDao.updateStatus(orderId,UNRECEIVED);
    }

    @Override
    public Integer updateToDone(BigInteger orderId) {
        return orderDao.updateStatus(orderId,DONE);
    }

    @Override
    public Integer updateToCancel(BigInteger orderId) {
        return orderDao.updateStatus(orderId,CANCEL);
    }

    @Override
    public Integer updateModifyTime(BigInteger orderId, String currentTime) {
        return orderDao.updateModifyTime(orderId, currentTime);
    }

    @Override
    public List<Order> findAllOrderByMemberId(BigInteger memberId) {
        return orderDao.findAllOrderByMemberId(memberId);
    }

    @Override
    public List<Order> findAllUnpaidOrderByMemberId(BigInteger memberId) {
        return orderDao.findAllOrderByMemberIdStatus(memberId,UNPAID);
    }

    @Override
    public List<Order> findAllUnshippedOrderByMemberId(BigInteger memberId) {
        return orderDao.findAllOrderByMemberIdStatus(memberId,UNSHIPPED);
    }

    @Override
    public List<Order> findAllUnreceivedOrderByMemberId(BigInteger memberId) {
        return orderDao.findAllOrderByMemberIdStatus(memberId,UNRECEIVED);
    }

    @Override
    public List<Order> findAllOrder() {
        return orderDao.findAllOrder();
    }

    @Override
    public Order findOrderByOrderId(BigInteger orderId) {
        return orderDao.findOrderByOrderId(orderId);
    }

    @Override
    public List<OrderItem> findOrderItemById(BigInteger orderId) {
        return orderDao.findOrderItemById(orderId);
    }

    @Override
    public List<ItemDetail> findOrderItemDetailById(BigInteger orderId) {
        return orderDao.findOrderItemDetailById(orderId);
    }

    @Override
    public ItemDetail findItemDetailByProductId(BigInteger productId) {
        return orderDao.findItemDetailByProductId(productId);
    }

    @Override
    public ItemDetail findItemDetailByCartItemId(BigInteger cartItemId) {
        return orderDao.findItemDetailByCartItemId(cartItemId);
    }
}
