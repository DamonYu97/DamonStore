package com.luckin.dao.entity;

import java.math.BigInteger;

/**
 * @author Lilin Yu
 * @Description 管理员权限类
 * @since 2019/08/01 10:15
 */

public class Permission {
    /**
     * id
     */
    private BigInteger id;
    /**
     * 权限名称
     */
    private String name;
    /**
     * 权限标签
     */
    private String tag;

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

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }
}
