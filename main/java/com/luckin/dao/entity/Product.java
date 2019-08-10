package com.luckin.dao.entity;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Timestamp;

/**
 * @author Lilin Yu
 * @since 2019/08/08 15:22
 */
public class Product {
    private BigInteger id;
    private String name;
    private int typeId;
    private String description;
    private String brandName;
    private String stock;
    private BigDecimal price;
    private BigInteger point;
    private Timestamp createTime;
    private BigInteger createAdminId;
    private Timestamp modifyTime;
    private BigInteger modifyAdminId;
    private int status;

    public BigInteger getId() {
        return id;
    }

    public void setId(BigInteger id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getStock() {
        return stock;
    }

    public void setStock(String stock) {
        this.stock = stock;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigInteger getPoint() {
        return point;
    }

    public void setPoint(BigInteger point) {
        this.point = point;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public BigInteger getCreateAdminId() {
        return createAdminId;
    }

    public void setCreateAdminId(BigInteger createAdminId) {
        this.createAdminId = createAdminId;
    }

    public Timestamp getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Timestamp modifyTime) {
        this.modifyTime = modifyTime;
    }

    public BigInteger getModifyAdminId() {
        return modifyAdminId;
    }

    public void setModifyAdminId(BigInteger modifyAdminId) {
        this.modifyAdminId = modifyAdminId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
