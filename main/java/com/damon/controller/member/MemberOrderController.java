package com.damon.controller.member;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.damon.dao.entity.*;
import com.damon.service.*;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import static com.damon.common.Constant.*;

/**
 * @author Lilin Yu
 * @since 2019/11/23 17:23
 */
@Controller
@RequestMapping("/member/order")
public class MemberOrderController {
    private final Logger logger = Logger.getLogger(MemberOrderController.class);
    private final int EXCHANGE = 1;
    private final int CONSUMPTION = 0;
    private final String BUY = "buy";
    private final String CART = "cart";
    private final String STATUS = "status";
    private final String ITEMS = "items";
    private final String PRODUCT_ID = "productID";
    private final String PRICE = "price";
    private final String POINT = "point";
    private final String CART_ITEM_QUANTITY = "cartItemQuantity";
    private final String CART_ITEM_ID = "cartItemID";
    private final String ADDRESS_ID = "addressID";
    private final String QUANTITY = "quantity";
    private final String RESULT = "result";
    private final BigInteger DEFAULT_PRODUCT_ID = new BigInteger("-1");
    @Autowired
    private OrderService orderService;
    @Autowired
    private CartService cartService;
    @Autowired
    private ProductService productService;
    @Autowired
    private ReceiveAddressService receiveAddressService;
    @Autowired
    private PointService pointService;
    @Autowired
    private MemberService memberService;

    /**
     * 通过商品ID和数量查看条目详情
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/checkItem", method = RequestMethod.POST)
    public void checkItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取条目信息
        List<ItemDetail> itemDetails = new ArrayList<>();
        String itemString = request.getParameter(ITEMS);
        if (itemString != null) {
            JSONArray items = JSONArray.parseArray(itemString);
            //获取来源信息（直接购买还是购物车提交订单）
            String from = request.getParameter("from");
            if (BUY.equals(from)) {
                //如果购买则数组只有一组数据
                JSONObject item = items.getJSONObject(0);
                BigInteger productId = item.getBigInteger(PRODUCT_ID);
                BigInteger quantity = item.getBigInteger(QUANTITY);
                ItemDetail itemDetail = orderService.findItemDetailByProductId(productId);
                //获取主图Url, 如果没有设置图片则为默认图片
                ProductImage mainImage = productService.findMainImageById(productId);
                if (mainImage == null) {
                    mainImage = productService.findMainImageById(DEFAULT_PRODUCT_ID);
                }
                itemDetail.setUrl(mainImage.getUrl());
                itemDetail.setProductId(productId);
                itemDetail.setQuantity(quantity);
                itemDetails.add(itemDetail);
            } else if (CART.equals(from)){
                for (int i = 0; i < items.size(); i++) {
                    JSONObject item = items.getJSONObject(i);
                    BigInteger cartItemId = item.getBigInteger(CART_ITEM_ID);
                    ItemDetail itemDetail = orderService.findItemDetailByCartItemId(cartItemId);
                    BigInteger productId = itemDetail.getProductId();
                    //获取主图Url, 如果没有设置图片则为默认图片
                    ProductImage mainImage = productService.findMainImageById(productId);
                    if (mainImage == null) {
                        mainImage = productService.findMainImageById(DEFAULT_PRODUCT_ID);
                    }
                    itemDetail.setUrl(mainImage.getUrl());
                    itemDetails.add(itemDetail);
                }
            }
        }
        String items = JSONObject.toJSONString(itemDetails);
        logger.info("items: " + items);
        byte[] dataByte = items.getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    /**
     * 提交订单
     * @param request
     * @param response
     * @throws IOException
     */
    @Transactional(rollbackFor = Exception.class )
    @RequestMapping(value = "/submitOrder", method = RequestMethod.POST)
    public void submitOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
        JSONObject jsonObject = new JSONObject();
        boolean result = false;
        //获取参数信息
        List<ItemDetail> itemDetails = null;
        String itemString = request.getParameter(ITEMS);
        String totalPriceString = request.getParameter("totalPrice");
        String totalPointString = request.getParameter("totalPoint");
        String from = request.getParameter("from");
        String addressIdString = request.getParameter(ADDRESS_ID);
        if (itemString != null && totalPriceString!= null && totalPointString != null && from != null && addressIdString != null) {
            itemDetails = JSONObject.parseArray(itemString,ItemDetail.class);
            BigDecimal totalPrice = new BigDecimal(totalPriceString);
            BigInteger totalPoint = new BigInteger(totalPointString);
            BigInteger addressId = new BigInteger(addressIdString);
            //确认是否有现货，商品是否下架
            boolean available = true;
            if (itemDetails != null) {
                for (ItemDetail item: itemDetails) {
                    //获取此时商品的库存和状态
                    Product product = productService.findProductById(item.getProductId());
                    if (product.getStatus() == 0 || product.getStock().compareTo(item.getQuantity()) < 0)  {
                        jsonObject.put("message",product.getName() + " is not available !");
                        available = false;
                        break;
                    }
                }
                if (available == true) {
                    //获取当前用户ID
                    HttpSession session = request.getSession();
                    Member member = (Member)session.getAttribute(MEMBER);
                    BigInteger memberId = member.getId();
                    //获取选中的收货地址信息
                    ReceiveAddress receiveAddress = receiveAddressService.findValidReceiveAddressById(addressId);
                    //创建新订单表
                    BigInteger orderId = createOrder(memberId, receiveAddress, totalPrice, totalPoint);
                    //创建订单条目表
                    for (ItemDetail item: itemDetails) {
                        //更新库存
                        orderService.updateStock(item.getQuantity(),item.getProductId());
                        //创建新订单表
                        createOrderItem(orderId, item);
                    }
                    //如果是通过购物车购买的，删除对应购物车条目
                    if (CART.equals(from)) {
                        for (ItemDetail item: itemDetails) {
                            cartService.delete(item.getId());
                        }
                        //更改缓存中购物车条目数量
                        int cartItemQuantity = (int)session.getAttribute(CART_ITEM_QUANTITY);
                        cartItemQuantity -= itemDetails.size();
                        session.setAttribute(CART_ITEM_QUANTITY,cartItemQuantity);
                        jsonObject.put("count",cartItemQuantity);
                    }
                    //总积分大于0，则增加积分兑换纪录，更新用户总积分
                    if (totalPoint.compareTo(BIGINT_ZERO) > 0) {
                        createPointRecord(EXCHANGE,totalPoint, session, orderId);
                    }
                    jsonObject.put(ORDER_ID,orderId);
                    result = true;
                }
            }
        }
        jsonObject.put(RESULT,result);
        logger.info("order info: " + jsonObject);
        byte[] dataByte = jsonObject.toJSONString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    private void createPointRecord(int type, BigInteger totalPoint, HttpSession session, BigInteger orderId) {
        Member member = (Member)session.getAttribute(MEMBER);
        //增加积分兑换纪录
        Point point = new Point();
        point.setMemberId(member.getId());
        point.setType(type);
        point.setPoint(totalPoint);
        point.setOrderId(orderId);
        pointService.create(point);
        BigInteger newPoint = null;
        //更新用户总积分
        if (type == EXCHANGE){
           newPoint = member.getPoint().subtract(totalPoint);
        } else if (type == CONSUMPTION) {
            newPoint = member.getPoint().add(totalPoint);
        }
        if (newPoint != null) {
            member.setPoint(newPoint);
            memberService.updateMember(member);
            session.setAttribute(MEMBER,member);
        }
    }

    private void createOrderItem(BigInteger orderId, ItemDetail item) {
        //创建订单条目表
        OrderItem orderItem = new OrderItem();
        orderItem.setOrderId(new BigInteger(orderId.toString()));
        orderItem.setPrice(item.getPrice());
        orderItem.setProductId(item.getProductId());
        orderItem.setQuantity(item.getQuantity());
        orderService.createOrderItem(orderItem);
    }

    private BigInteger createOrder(BigInteger memberId, ReceiveAddress receiveAddress, BigDecimal totalPrice, BigInteger totalPoint) {
        //创建新订单表
        Order order = new Order();
        order.setMemberId(memberId);
        order.setReceiverName(receiveAddress.getReceiverName());
        order.setReceiverPhone(receiveAddress.getReceiverPhone());
        String address = receiveAddress.getProvince() + " Province, " + receiveAddress.getCity() +
                " City, " + receiveAddress.getDetail();
        order.setReceiverAddress(address);
        order.setTotalPrice(totalPrice);
        order.setTotalPoint(totalPoint);
        orderService.createOrder(order);
        return order.getId();
    }

    /**
     * 查看当前会员订单
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/checkOrder", method = RequestMethod.POST)
    public void checkOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<JSONObject> ordersJson = new ArrayList<>();
        //获取当前用户ID
        HttpSession session = request.getSession();
        Member member = (Member)session.getAttribute(MEMBER);
        BigInteger memberId = member.getId();
        //获取订单的类型
        String statusString = request.getParameter(STATUS);
        if (statusString != null) {
            int status = Integer.parseInt(statusString);
            //获取订单信息
            List<Order> orders = new ArrayList<>();
            switch (status) {
                case 1:
                    orders = orderService.findAllUnpaidOrderByMemberId(memberId);
                    break;
                case 2:
                    orders = orderService.findAllUnshippedOrderByMemberId(memberId);
                    break;
                case 3:
                    orders = orderService.findAllUnreceivedOrderByMemberId(memberId);
                    break;
                default:
                    orders = orderService.findAllOrderByMemberId(memberId);
            }
            ordersJson = getOrdersJson(orders);
        }

        logger.info("order info: " + ordersJson);
        byte[] dataByte = ordersJson.toString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    /**
     * 查看当前会员所有未支付订单
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/checkUnpaidOrder", method = RequestMethod.POST)
    public void checkUnpaidOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取当前用户ID
        HttpSession session = request.getSession();
        Member member = (Member)session.getAttribute(MEMBER);
        BigInteger memberId = member.getId();
        //获取订单信息
        List<Order> orders = orderService.findAllUnpaidOrderByMemberId(memberId);
        List<JSONObject> ordersJson = getOrdersJson(orders);
        logger.info("order info: " + ordersJson);
        byte[] dataByte = ordersJson.toString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }


    private List<JSONObject> getOrdersJson(List<Order> orders) {
        List<JSONObject> ordersJson = new ArrayList<>();
        for (Order order: orders) {
            BigInteger orderId = order.getId();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("order",order);
            //查询订单条目信息
            List<ItemDetail> itemDetails = orderService.findOrderItemDetailById(orderId);
            if (itemDetails != null) {
                for (ItemDetail item: itemDetails) {
                    BigInteger productId = item.getProductId();
                    //获取主图Url, 如果没有设置图片则为默认图片
                    ProductImage mainImage = productService.findMainImageById(productId);
                    if (mainImage == null) {
                        mainImage = productService.findMainImageById(DEFAULT_PRODUCT_ID);
                    }
                    item.setUrl(mainImage.getUrl());
                }
            }
            jsonObject.put("orderItem",itemDetails);
            ordersJson.add(jsonObject);
        }
        return ordersJson;
    }

    /**
     * 支付
     * @param request
     * @param response
     * @throws IOException
     */
    @Transactional(rollbackFor = Exception.class)
    @RequestMapping(value = "/pay", method = RequestMethod.POST)
    public void pay(HttpServletRequest request, HttpServletResponse response) throws IOException {
        JSONObject jsonObject = new JSONObject();
        boolean result = false;
        //获取订单ID
        String orderIdString = request.getParameter(ORDER_ID);
        //获取付款信息
        String priceString = request.getParameter("price");
        String paymentString = request.getParameter("payment");
        if (orderIdString != null && priceString!= null && paymentString!= null) {
            BigDecimal price = new BigDecimal(priceString);
            BigInteger orderId = new BigInteger(orderIdString);
            //调用支付接口......
            //如果付款成功更新订单状态到待发货
            orderService.updateToUnshipped(orderId);
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
     * 确认收货
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/received", method = RequestMethod.POST)
    public void received(HttpServletRequest request, HttpServletResponse response) throws IOException {
        JSONObject jsonObject = new JSONObject();
        boolean result = false;
        //获取订单ID
        String orderIdString = request.getParameter(ORDER_ID);
        //获取订单总价
        String priceString = request.getParameter(PRICE);
        //获取订单消耗积分
        String pointString = request.getParameter(POINT);
        if (orderIdString != null && priceString != null && pointString != null) {
            BigInteger orderId = new BigInteger(orderIdString);
            BigInteger totalPoint = new BigInteger(pointString);
            BigDecimal totalPrice = new BigDecimal(priceString);
            //更新订单状态到已完成
            orderService.updateToDone(orderId);
            //如果消耗积分等于0，则添加相应用户积分
            if (totalPoint.compareTo(BIGINT_ZERO) == 0) {
                //根据支付的金额直接取整为添加的积分数
                BigInteger newPoint = totalPrice.toBigInteger();
                HttpSession session = request.getSession();
                createPointRecord(CONSUMPTION,newPoint,session,orderId);
            }
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
}
