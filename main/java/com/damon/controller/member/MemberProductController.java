package com.damon.controller.member;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.damon.dao.entity.Product;
import com.damon.dao.entity.ProductImage;
import com.damon.dao.entity.ProductType;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Lilin Yu
 * @since 2019/11/20 16:33
 */

@Controller
@RequestMapping("/member/product")
public class MemberProductController {
    private final Logger logger = Logger.getLogger(MemberProductController.class);
    private final BigInteger DEFAULT_PRODUCT_ID = new BigInteger("-1");
    private final int CAPACITY = 5;
    @Autowired
    private ProductService productService;

    /**
     * 显示所有商品类型
     */
    @RequestMapping(value = "/showAllProductType", method = RequestMethod.POST)
    public void showAllProductType(HttpServletResponse response) throws IOException {
        //获取每一层级包含的类型
        List<ProductType> levelOne = productService.findProductTypeByLevel(1);
        List<ProductType> levelTwo = productService.findProductTypeByLevel(2);
        List<ProductType> levelThree = productService.findProductTypeByLevel(3);
        //Map存储一个类型ID下所有的子级
        Map<Integer, JSONArray> jsonArrayMap = new HashMap<>(CAPACITY);
        //-1级是所有一级类型的父级
        jsonArrayMap.put(-1,new JSONArray());
        //初始化Map
        for (ProductType productType: levelOne) {
            if (productType.getIsEnd() == 0) {
                jsonArrayMap.put(productType.getId(),new JSONArray());
            }
        }
        for (ProductType productType: levelTwo) {
            if (productType.getIsEnd() == 0) {
                jsonArrayMap.put(productType.getId(),new JSONArray());
            }
        }
        //将子级加入到对应父级的JsonArray
        addToParent(levelThree, jsonArrayMap);
        addToParent(levelTwo, jsonArrayMap);
        addToParent(levelOne, jsonArrayMap);
        //-1级的子级为所有类别
        String typeString = JSONObject.toJSONString(jsonArrayMap.get(-1));
        logger.info("Product types: "+ typeString);
        byte[] dataByte = typeString.getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    private void addToParent(List<ProductType> level, Map<Integer, JSONArray> jsonArrayMap) {
        for (ProductType productType: level) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("type",productType);
            if (productType.getIsEnd() == 0) {
                jsonObject.put("children",jsonArrayMap.get(productType.getId()));
            }
            jsonArrayMap.get(productType.getParentId()).add(jsonObject);
        }
    }

    /**
     * 显示商品
     */
    @RequestMapping(value = "/showProduct", method = RequestMethod.POST)
    public void showProduct(HttpServletResponse response, HttpServletRequest request) throws IOException {
        String typeIdString = request.getParameter("typeID");
        JSONObject jsonObject = new JSONObject();
        List<Product> products = null;
        if (typeIdString == null){
            jsonObject.put("type","All product");
            products = productService.findAllValidProduct();
        } else {
            int typeId = Integer.parseInt(typeIdString);
            ProductType productType = productService.findProductTypeById(typeId);
            jsonObject.put("type",productType.getName());
            products = productService.findAllValidProductByTypeId(typeId);
        }
        List<JSONObject> jsonObjects = new ArrayList<>();
        for (Product product: products) {
            JSONObject productJson = new JSONObject();
            productJson.put("product",product);
            //获取主图Url, 如果没有设置图片则为默认图片
            ProductImage mainImage = productService.findMainImageById(product.getId());
            if (mainImage == null) {
                mainImage = productService.findMainImageById(DEFAULT_PRODUCT_ID);
            }
            productJson.put("mainImage",mainImage.getUrl());
            jsonObjects.add(productJson);
        }
        jsonObject.put("products",jsonObjects);
        String productsString = JSONObject.toJSONString(jsonObject);
        logger.info("Product : "+ productsString);
        byte[] dataByte = productsString.getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    /**
     * 显示商品详细信息
     */
    @RequestMapping(value = "/showProductDetail", method = RequestMethod.POST)
    public void showProductDetail(HttpServletResponse response, HttpServletRequest request) throws IOException {
        JSONObject jsonObject = new JSONObject();
        //获取商品ID
        String productIdString = request.getParameter("productID");
        if (productIdString != null) {
            BigInteger productId = new BigInteger(productIdString);
            //获取商品信息
            Product product = productService.findProductById(productId);
            jsonObject.put("product",product);
            //获取所有商品图片信息，如果没有设置图片则为默认图片
            List<ProductImage> productImages = productService.findImageById(productId);
            if (productImages.isEmpty()) {
                productImages = productService.findImageById(DEFAULT_PRODUCT_ID);
            }
            jsonObject.put("images",productImages);
        }
        logger.info("Product detail info: "+ jsonObject.toString());
        byte[] dataByte = jsonObject.toString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

}
