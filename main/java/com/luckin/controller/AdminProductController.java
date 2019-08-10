package com.luckin.controller;


import com.alibaba.fastjson.JSONObject;
import com.luckin.dao.ProductTypeDao;
import com.luckin.dao.entity.Product;
import com.luckin.dao.entity.ProductImage;
import com.luckin.dao.entity.ProductType;
import com.luckin.service.ProductService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/08/08 16.29
 */

@Controller
@RequestMapping("/admin/product")
public class AdminProductController {
    private final Logger logger = Logger.getLogger(AdminProductController.class);
    private final String PRODUCT = "product";
    private final String TYPE = "type";
    private final String MAINIMAGEURL = "mainImageUrl";
    private final String IMAGEURLS = "imageUrls";

    @Autowired
    private ProductService productService;
    @Resource
    private ProductTypeDao productTypeDao;

    /**
     * 显示所有商品
     */
    @RequestMapping(value = "/showAllProduct", method = RequestMethod.POST)
    public void showAllProduct(HttpServletResponse response) throws IOException {
        List<JSONObject> jsonObjects = new ArrayList<>();
        List<Product> products = productService.findAllProduct();
        for (Product product:products) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put(PRODUCT,JSONObject.toJSON(product));
            BigInteger productID = product.getId();
            //获取主图Url
            ProductImage mainImage = productService.findMainImageByID(productID);
            jsonObject.put(MAINIMAGEURL,mainImage.getUrl());
            //获取商品类型信息
            ProductType productType = productTypeDao.findProductTypeByID(product.getTypeId());
            jsonObject.put(TYPE,JSONObject.toJSON(productType));
            //获取所有商品图片信息
            List<ProductImage> productImages = productService.findImageByID(productID);
            jsonObject.put(IMAGEURLS,productImages);
            jsonObjects.add(jsonObject);
        }
        logger.info("All Products_Type: "+ jsonObjects.toString());
        byte[] dataByte = jsonObjects.toString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

}