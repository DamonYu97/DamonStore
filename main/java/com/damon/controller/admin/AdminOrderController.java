package com.damon.controller.admin;

import com.alibaba.fastjson.JSONObject;
import com.damon.dao.entity.*;
import com.damon.service.MemberService;
import com.damon.service.OrderService;
import com.damon.service.PointService;
import com.damon.service.ProductService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import static com.damon.common.Constant.*;


/**
 * @author Lilin Yu
 * @since 2019/11/11 16:45
 */

@Controller
@RequestMapping("/admin/order")
public class AdminOrderController {
    private final Logger logger = Logger.getLogger(AdminOrderController.class);
    private final String ORDER_ID = "orderID";
    private final int RETURN = 2;
    private final String POINT = "point";
    private final String RECEIVER_NAME = "receiverName";
    private final String RECEIVER_PHONE = "receiverPhone";
    private final String RECEIVER_ADDRESS = "receiverAddress";


    @Autowired
    private OrderService orderService;
    @Autowired
    private ProductService productService;
    @Autowired
    private PointService pointService;
    @Autowired
    private MemberService memberService;

    /**
     * 所有订单信息显示
     */
    @RequestMapping(value = "/showAllOrder", method = RequestMethod.POST)
    public void showAllOrder(HttpServletResponse response) throws IOException {
        List<JSONObject> jsonOrders = new ArrayList<>();
        //获取所有订单
        List<Order> orders = orderService.findAllOrder();
        for (Order order: orders) {
            JSONObject jsonOrder = new JSONObject();
            BigInteger orderId = order.getId();
            jsonOrder.put("order",order);
            List<OrderItem> items = orderService.findOrderItemById(orderId);
            List<JSONObject> jsonItems = new ArrayList<>();
            for (OrderItem item: items) {
                //获取该条目对应的商品信息
                JSONObject jsonItem = new JSONObject();
                jsonItem.put("quantity",item.getQuantity());
                Product product = productService.findProductById(item.getProductId());
                product.setPrice(item.getPrice());
                jsonItem.put("product",product);
                jsonItems.add(jsonItem);
            }
            jsonOrder.put("item",jsonItems);
            jsonOrders.add(jsonOrder);
        }
        logger.info("All orders: "+ jsonOrders.toString());
        byte[] dataByte = jsonOrders.toString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    /**
     * 取消订单
     */
    @RequestMapping(value = "/cancelOrder", method = RequestMethod.POST)
    public void cancelOrder(HttpServletResponse response, HttpServletRequest request) throws IOException {
        JSONObject jsonObject = new JSONObject();
        boolean result = false;
        String orderIdString = request.getParameter(ORDER_ID);
        String pointString = request.getParameter(POINT);
        if (orderIdString != null && pointString != null) {
            BigInteger orderId = new BigInteger(orderIdString);
            BigInteger point = new BigInteger(pointString);
            //更改订单状态到已取消
            orderService.updateToCancel(orderId);
            //如果积分大于0，则返回积分
            if (point.compareTo(BIGINT_ZERO) > 0) {
                String memberIdString = request.getParameter(MEMBER_ID);
                if (memberIdString != null) {
                    BigInteger memberId = new BigInteger(memberIdString);
                    //添加用户积分
                    memberService.updatePoint(memberId,point);
                    //添加积分退回纪录
                    Point pointRecord = new Point();
                    pointRecord.setOrderId(orderId);
                    pointRecord.setPoint(point);
                    pointRecord.setType(RETURN);
                    pointRecord.setMemberId(memberId);
                    pointService.create(pointRecord);
                }
            }
            //获取当前时间
            SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_FORM);
            String currentTime = dateFormat.format(new Date());
            //更新修改时间
            orderService.updateModifyTime(orderId,currentTime);
            result = true;
        }
        jsonObject.put(RESULT,result);
        logger.info("Cancel order: " + orderIdString + " " + jsonObject.toString());
        byte[] dataByte = jsonObject.toString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    /**
     * 发货
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/shipped", method = RequestMethod.POST)
    public void shipped(HttpServletRequest request, HttpServletResponse response) throws IOException {
        JSONObject jsonObject = new JSONObject();
        boolean result = false;
        //获取订单ID
        String orderIdString = request.getParameter(ORDER_ID);
        if (orderIdString != null) {
            BigInteger orderId = new BigInteger(orderIdString);
            //更新订单状态到待收货
            orderService.updateToUnreceived(orderId);
            //获取当前时间
            SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_FORM);
            String currentTime = dateFormat.format(new Date());
            //更新修改时间
            orderService.updateModifyTime(orderId,currentTime);
            result = true;
        }
        jsonObject.put(RESULT,result);
        byte[] dataByte = jsonObject.toString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    /**
     * 修改收货信息
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/updateAddress", method = RequestMethod.POST)
    public String updateAddress(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String orderIdString = request.getParameter(ORDER_ID);
        String receiverName = request.getParameter(RECEIVER_NAME);
        String receiverPhone = request.getParameter(RECEIVER_PHONE);
        String receiverAddress = request.getParameter(RECEIVER_ADDRESS);
        if (orderIdString != null && receiverName != null && receiverPhone != null && receiverAddress != null) {
            BigInteger orderId = new BigInteger(orderIdString);
            Order order = orderService.findOrderByOrderId(orderId);
            order.setReceiverName(receiverName);
            order.setReceiverPhone(receiverPhone);
            order.setReceiverAddress(receiverAddress);
            //更新订单收货信息
            orderService.update(order);
        }
        return "redirect:/admin/orderManage";
    }
}
