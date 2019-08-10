package com.luckin.service.impl;

import com.luckin.dao.ProductDao;
import com.luckin.dao.entity.Product;
import com.luckin.dao.entity.ProductImage;
import com.luckin.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/08/08 16.24
 */
@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductDao productDao;

    @Override
    public Integer create(Product product) {
        return productDao.insert(product);
    }

    @Override
    public Product findProductByID(BigInteger id) {
        return productDao.findProductByID(id);
    }

    @Override
    public List<Product> findAllProduct() {
        return productDao.findAllProduct();
    }

    @Override
    public Integer update(Product product) {
        return productDao.update(product);
    }

    @Override
    public Integer updateStatusToInvalid(BigInteger id) {
        return productDao.updateStatusToInvalid(id);
    }

    @Override
    public List<ProductImage> findImageByID(BigInteger id) {
        return productDao.findImageByID(id);
    }

    @Override
    public ProductImage findMainImageByID(BigInteger id) {
        return productDao.findMainImageByID(id);
    }
}
