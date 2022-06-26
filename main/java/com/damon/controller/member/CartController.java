package com.damon.controller.member;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.damon.dao.entity.CartItem;
import com.damon.dao.entity.ItemDetail;
import com.damon.dao.entity.Member;
import com.damon.dao.entity.ProductImage;
import com.damon.service.CartService;
import com.damon.service.ProductService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/22 19:55
 */
@Controller
@RequestMapping("/member/cart")
public class CartController {
    private final Logger logger = Logger.getLogger(CartController.class);
    private final String MEMBER = "member";
    private final String ITEMS = "items";
    private final String ID = "id";
    private final String PRODUCT_ID = "productID";
    private final String QUANTITY = "quantity";
    private final String CART_ITEM_QUANTITY = "cartItemQuantity";
    private final String RESULT = "result";
    private final BigInteger DEFAULT_PRODUCT_ID = new BigInteger("-1");
    @Autowired
    private CartService cartService;
    @Autowired
    private ProductService productService;

    /**
     * 添加商品到购物车
     */
    @RequestMapping(value = "/addToCart", method = RequestMethod.POST)
    public void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        JSONObject jsonObject = new JSONObject();
        boolean result = false;
        //获取当前会员ID
        HttpSession session = request.getSession();
        Member member = (Member)session.getAttribute(MEMBER);
        BigInteger memberId = member.getId();
        //获取商品ID
        String productIdString = request.getParameter(PRODUCT_ID);
        if (productIdString == null) {
            logger.info("Cart addToCart error: null productID");
        } else {
            BigInteger productId = new BigInteger(productIdString);
            //获取此商品加入购物车的数量
            String quantityString = request.getParameter(QUANTITY);
            if (quantityString == null) {
                logger.info("Cart addToCart error: null quantity");
            } else {
                BigInteger quantity = new BigInteger(quantityString);
                CartItem cartItem = cartService.findCartItemByMemberProductId(memberId,productId);
                //加入购物车
                if (cartItem != null) {
                    //1.如果购物车已有此商品，则直接更新此条目数量
                    BigInteger oldQuantity = cartItem.getQuantity();
                    BigInteger total = oldQuantity.add(quantity);
                    cartService.updateQuantity(cartItem.getId(),total);
                } else {
                    //2.如果购物车无此商品，则直接添加此商品到购物车
                    cartItem = new CartItem();
                    cartItem.setMemberId(memberId);
                    cartItem.setProductId(productId);
                    cartItem.setQuantity(quantity);
                    cartService.insert(cartItem);
                    //更改缓存中购物车条目数量
                    int cartItemQuantity = (int)session.getAttribute(CART_ITEM_QUANTITY);
                    cartItemQuantity ++;
                    session.setAttribute(CART_ITEM_QUANTITY,cartItemQuantity);
                    jsonObject.put("count",cartItemQuantity);
                }
                result = true;
            }
        }
        jsonObject.put(RESULT,result);
        byte[] dataByte = jsonObject.toString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    /**
     * 查找会员的购物车条目信息
     */
    @RequestMapping(value = "/checkCartItem", method = RequestMethod.POST)
    public void checkCartItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取当前会员ID
        HttpSession session = request.getSession();
        Member member = (Member)session.getAttribute(MEMBER);
        BigInteger memberId = member.getId();
        //获取会员购物车信息
        List<ItemDetail> cartItems = cartService.findCartItemDetailByMemberId(memberId);
        for (ItemDetail item: cartItems) {
            //获取主图Url, 如果没有设置图片则为默认图片
            ProductImage mainImage = productService.findMainImageById(item.getProductId());
            if (mainImage == null) {
                mainImage = productService.findMainImageById(DEFAULT_PRODUCT_ID);
            }
            item.setUrl(mainImage.getUrl());
        }
        String itemString = JSONObject.toJSONString(cartItems);
        logger.info("itemString: " + itemString);
        byte[] dataByte = itemString.getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    /**
     * 删除购物车条目
     */
    @RequestMapping(value = "/deleteCartItem", method = RequestMethod.POST)
    public void deleteCartItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        JSONObject jsonObject = new JSONObject();
        boolean result = false;
        //获取需要删除的条目ID
        String itemIdString = request.getParameter(ITEMS);
        if (itemIdString != null) {
            JSONArray itemIds = JSONArray.parseArray(itemIdString);
            for (int i = 0; i < itemIds.size(); i++) {
                BigInteger id = new BigInteger((String)itemIds.get(i));
                cartService.delete(id);
            }
            //更改缓存中购物车条目数量
            HttpSession session = request.getSession();
            int cartItemQuantity = (int)session.getAttribute(CART_ITEM_QUANTITY);
            cartItemQuantity -= itemIds.size();
            session.setAttribute(CART_ITEM_QUANTITY,cartItemQuantity);
            jsonObject.put("count",cartItemQuantity);
            result = true;
        }
        jsonObject.put(RESULT,result);
        byte[] dataByte = jsonObject.toString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    /**
     * 更新购物车中条目的数量
     */
    @RequestMapping(value = "/updateCartItemQuantity", method = RequestMethod.POST)
    public void updateCartItemQuantity(HttpServletRequest request, HttpServletResponse response) throws IOException {
        JSONObject jsonObject = new JSONObject();
        boolean result = false;
        //获取需要更新的条目ID和更新的数量
        String itemString = request.getParameter(ITEMS);
        if (itemString != null) {
            JSONArray items = JSONArray.parseArray(itemString);
            for (int i = 0; i < items.size(); i++) {
                JSONObject item = items.getJSONObject(i);
                BigInteger id = item.getBigInteger(ID);
                BigInteger quantity = item.getBigInteger(QUANTITY);
                logger.info("update item : id:" + id + " quantity:" + quantity);
                cartService.updateQuantity(id,quantity);
            }
            result = true;
        }
        jsonObject.put(RESULT,result);
        byte[] dataByte = jsonObject.toString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }
}
