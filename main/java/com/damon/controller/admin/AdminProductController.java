package com.damon.controller.admin;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.damon.dao.entity.Admin;
import com.damon.dao.entity.Product;
import com.damon.dao.entity.ProductImage;
import com.damon.dao.entity.ProductType;
import com.damon.service.ProductService;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.WebResource;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/08 16.29
 */

@Controller
@RequestMapping("/admin/product")
public class AdminProductController {
    private final Logger logger = Logger.getLogger(AdminProductController.class);
    private final String ID ="id";
    private final String PRODUCT = "product";
    private final String STOCK = "stock";
    private final String PRICE = "price";
    private final BigInteger DEFAULT_PRODUCT_ID = new BigInteger("-1");
    private final String TYPE = "type";
    private final String MAIN_IMAGE_URL = "mainImageUrl";
    private final String IMAGE_URLS = "imageUrls";
    private final String DATE_FORM = "yyyy-MM-dd HH:mm:ss";

    @Autowired
    private ProductService productService;

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
            BigInteger productId = product.getId();
            //获取商品类型信息
            ProductType productType = productService.findProductTypeById(product.getTypeId());
            jsonObject.put(TYPE,JSONObject.toJSON(productType));
            //获取主图Url, 如果没有设置图片则为默认图片
            ProductImage mainImage = productService.findMainImageById(productId);
            if (mainImage == null) {
                mainImage = productService.findMainImageById(DEFAULT_PRODUCT_ID);
            }
            jsonObject.put(MAIN_IMAGE_URL,mainImage.getUrl());
            //获取所有商品图片信息，如果没有设置图片则为默认图片
            List<ProductImage> productImages = productService.findImageById(productId);
            if (productImages.isEmpty()) {
                productImages = productService.findImageById(DEFAULT_PRODUCT_ID);
            }
            jsonObject.put(IMAGE_URLS,productImages);
            jsonObjects.add(jsonObject);
        }
        logger.info("All Products_Type: "+ jsonObjects.toString());
        byte[] dataByte = jsonObjects.toString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    /**
     * 删除商品（状态设为0，即无效）
     */
    @RequestMapping(value = "/deleteProduct", method = RequestMethod.GET)
    public String deleteProduct(HttpServletRequest request) throws IOException {
        BigInteger productId = new BigInteger(request.getParameter(ID));
        Product product = productService.findProductById(productId);
        //更改商品状态为无效
        product.setStatus(0);
        //纪录修改时间和修改人ID
        updateModifyInfo(product);
        updateModifyInfo(product);
        productService.update(product);
        //返回商品管理界面
        return "redirect:/admin/productManage";
    }

    /**
     * 更新商品
     */
    @RequestMapping(value = "/updateProduct", method = RequestMethod.POST)
    public String updateProduct(HttpServletRequest request) throws IOException {
        BigInteger productId = new BigInteger(request.getParameter(ID));
        BigInteger stock = new BigInteger(request.getParameter(STOCK));
        BigDecimal price = new BigDecimal(request.getParameter(PRICE));
        Product product = productService.findProductById(productId);
        product.setStock(stock);
        product.setPrice(price);
        //纪录修改时间和修改人ID
        updateModifyInfo(product);
        productService.update(product);
        //返回商品管理界面
        return "redirect:/admin/productManage";
    }

    private void updateModifyInfo(Product product) {
        //1.获取当前用户信息
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal != null) {
            if (principal instanceof Admin) {
                Admin admin = (Admin) principal;
                //2.获取当前时间
                SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_FORM);
                String currentTime = dateFormat.format(new Date());
                //3.更新修改时间和修改人ID
                product.setModifyTime(currentTime);
                product.setModifyAdminId(admin.getId());
            }
        }
    }

    @RequestMapping(value = "/uploadImage", method = RequestMethod.POST)
    public void uploadImage(HttpServletResponse response, @RequestParam("images") MultipartFile[] images) throws IOException {
        JSONArray fileNames = new JSONArray();
        for (MultipartFile image: images) {
            if (image.getSize() > 0) {
                String path = "http://47.106.104.159:8080/images/product/";
                String fileName = image.getOriginalFilename();
                Client client = Client.create();
                WebResource resource = client.resource(path + fileName);
                resource.put(String.class,image.getBytes());
                fileNames.add(fileName);
            }
        }
        logger.info("uploaded file: " + fileNames);
        byte[] dataByte = fileNames.toString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

}