package com.damon.service.impl;

import com.damon.dao.ProductDao;
import com.damon.dao.ProductTypeDao;
import com.damon.dao.entity.Product;
import com.damon.dao.entity.ProductImage;
import com.damon.dao.entity.ProductType;
import com.damon.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/08 16.24
 */
@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductDao productDao;
    @Autowired
    private ProductTypeDao productTypeDao;

    @Override
    public Integer create(Product product) {
        return productDao.insert(product);
    }

    @Override
    public Product findProductById(BigInteger id) {
        return productDao.findProductById(id);
    }

    @Override
    public List<Product> findAllProduct() {
        return productDao.findAllProduct();
    }

    @Override
    public List<Product> findAllValidProduct() {
        return productDao.findAllValidProduct();
    }

    @Override
    public List<Product> findAllValidProductByTypeId(int typeId) {
        return productDao.findAllValidProductByTypeId(typeId);
    }

    @Override
    public Integer update(Product product) {
        return productDao.update(product);
    }

    @Override
    public List<ProductImage> findImageById(BigInteger id) {
        return productDao.findImageById(id);
    }

    @Override
    public ProductImage findMainImageById(BigInteger id) {
        return productDao.findMainImageById(id);
    }

    @Override
    public ProductType findProductTypeById(int id) {
        return productTypeDao.findProductTypeById(id);
    }

    @Override
    public List<ProductType> findProductTypeByLevel(int level) {
        return productTypeDao.findProductTypeByLevel(level);
    }


}
