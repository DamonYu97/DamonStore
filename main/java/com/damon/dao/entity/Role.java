package com.damon.dao.entity;

/**
 * @author Lilin Yu
 * @Description 管理员角色类
 * @since 2019/11/01 10:10
 */

public class Role {
    /**
     * 角色id
     */
    private int id;
    /**
     * 角色名称
     */
    private String name;
    /**
     * 角色描述
     */
    private String description;

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
