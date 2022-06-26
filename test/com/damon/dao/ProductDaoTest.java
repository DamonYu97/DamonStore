package com.damon.dao;

import com.alibaba.fastjson.JSONObject;
import com.damon.dao.entity.Product;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

import java.util.List;

import static org.junit.Assert.*;

/**
 * 商品服务测试类
 * @author Lilin Yu
 * @since 2019/08/08 16.09
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml"})
public class ProductDaoTest {

    @Resource
    private ProductDao productDao;

    /*@Test
    public void findAllProduct() {
        List<Product> products = productDao.findAllProduct();
        String productsString = JSONObject.toJSONString(products);
        System.out.println("\n"+productsString);
    }*/
}