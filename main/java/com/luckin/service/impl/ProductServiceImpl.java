package com.luckin.service.impl;

import com.luckin.dao.ProductDao;
import com.luckin.dao.ProductTypeDao;
import com.luckin.dao.entity.Product;
import com.luckin.dao.entity.ProductImage;
import com.luckin.dao.entity.ProductType;
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
    @Autowired
    private ProductTypeDao productTypeDao;

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
    public List<Product> findAllValidProduct() {
        return productDao.findAllValidProduct();
    }

    @Override
    public List<Product> findAllValidProductByTypeID(int typeID) {
        return productDao.findAllValidProductByTypeID(typeID);
    }

    @Override
    public Integer update(Product product) {
        return productDao.update(product);
    }

    @Override
    public List<ProductImage> findImageByID(BigInteger id) {
        return productDao.findImageByID(id);
    }

    @Override
    public ProductImage findMainImageByID(BigInteger id) {
        return productDao.findMainImageByID(id);
    }

    @Override
    public ProductType findProductTypeByID(int id) {
        return productTypeDao.findProductTypeByID(id);
    }

    @Override
    public List<ProductType> findProductTypeByLevel(int level) {
        return productTypeDao.findProductTypeByLevel(level);
    }


}
