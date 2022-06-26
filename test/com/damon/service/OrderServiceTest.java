package com.damon.service;

import com.alibaba.fastjson.JSONObject;
import com.damon.dao.entity.ItemDetail;
import com.damon.dao.entity.Order;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

import java.math.BigInteger;
import java.util.List;

import static org.junit.Assert.*;

/**
 * 订单服务测试类
 * @author Lilin Yu
 * @since 2019/08/11 16:48
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml"})
public class OrderServiceTest {
    @Resource
    private OrderService orderService;

    /*@Test
    public void findAllOrder() {
        List<Order> orders = orderService.findAllOrder();
        String orderInfo = JSONObject.toJSONString(orders);
        System.out.println(orderInfo);
    }
    @Test
    public void findOrderItemByID() {
        List<OrderItem> orderItems = orderService.findOrderItemByID(new BigInteger("1"));
        String orderInfo = JSONObject.toJSONString(orderItems);
        System.out.println(orderInfo);
    }*/
    /*@Test
    public void findAllOrderByMemberID() {
        List<Order> orders = orderService.findAllOrderByMemberID(new BigInteger("1"));
        String orderInfo = JSONObject.toJSONString(orders);
        System.out.println(orderInfo);
    }*/
    /*@Test
    public void findAllUnpaidOrderByMemberID() {
        List<Order> orders = orderService.findAllUnpaidOrderByMemberID(new BigInteger("1"));
        String orderInfo = JSONObject.toJSONString(orders);
        System.out.println(orderInfo);
    }*/

    /*@Test
    public void updateStatus() {
        int result = orderService.updateToDone(new BigInteger("3"));
        System.out.println(result);
    }*/

    /*@Test
    public void updateStock() {
        int result = orderService.updateStock(new BigInteger("20"),new BigInteger("1"));
        System.out.println(result);
    }*/
    @Test
    public void updateModifyTime() {
        int result = orderService.updateModifyTime(new BigInteger("1"),"2019-08-01 18:06:42");
        System.out.println(result);
    }
}