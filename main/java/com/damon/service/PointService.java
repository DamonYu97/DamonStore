package com.damon.service;

import com.damon.dao.entity.Point;

import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/11 20:30
 */

public interface PointService {

    /**
     * 插入积分纪录
     * @param point
     * @return
     */
    Integer create(Point point);

    /**
     * 查找所有积分信息
     * @return
     */
    List<Point> findAllPoint();

    /**
     * 通过会员ID查找所有积分信息
     * @param memberId
     * @return
     */
    List<Point> findAllPointByMemberId(BigInteger memberId);
}
