package com.damon.dao;

import com.damon.dao.entity.Point;

import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/11 20:20
 */

public interface PointDao {

    /**
     * 插入积分纪录
     * @param point
     * @return
     */
    Integer insert(Point point);

    /**
     * 查找所有积分信息
     * @return
     */
    List<Point> findAllPoint();

    /**
     * 通过会员ID查找积分信息
     * @param memberId
     * @return
     */
    List<Point> findAllPointByMemberId(BigInteger memberId);
}
