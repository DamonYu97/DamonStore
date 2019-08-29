package com.luckin.dao.entity;

import java.math.BigInteger;

/**
 * @author Lilin Yu
 * @Description 会员类
 * @since 2019/08/01 09:01
 */

public class Member {
    /**
     * id
     */
    private BigInteger id;
    /**
     * 会员登录名称
     */
    private String name;
    /**
     * 会员登录密码
     */
    private String password;
    /**
     * 会员头像URL
     */
    private String imageUrl;
    /**
     * 性别
     */
    private int gender;
    /**
     * 手机号
     */
    private String phoneNumber;
    /**
     * 邮箱
     */
    private String email;
    /**
     * 总积分
     */
    private BigInteger point;
    /**
     * 会员账号状态
     */
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public BigInteger getPoint() {
        return point;
    }

    public void setPoint(BigInteger point) {
        this.point = point;
    }
}
