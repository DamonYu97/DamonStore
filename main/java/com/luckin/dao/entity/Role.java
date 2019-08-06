package com.luckin.dao.entity;

import java.math.BigInteger;

/**
 * @author Lilin Yu
 * @since 2019/08/01 10:10
 */

class Role {
    private BigInteger id;
    private String name;
    private String description;

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
