package com.luckin.dao.entity;

import java.math.BigInteger;

/**
 * @author Lilin Yu
 * @Description 商品类别类
 * @since 2019/08/08 15:25
 */
public class ProductType {
    /**
     * id
     */
    private int id;
    /**
     * 类别名字
     */
    private String name;
    /**
     * 父级类别id
     */
    private int parentId;
    /**
     * 类别层级
     */
    private int level;
    /**
     * 是否为底级
     */
    private int isEnd;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public int getIsEnd() {
        return isEnd;
    }

    public void setIsEnd(int isEnd) {
        this.isEnd = isEnd;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }
}
