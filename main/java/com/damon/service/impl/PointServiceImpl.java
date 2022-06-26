package com.damon.service.impl;

import com.damon.dao.PointDao;
import com.damon.dao.entity.Point;
import com.damon.service.PointService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/11 20:32
 */

@Service
public class PointServiceImpl implements PointService {
    @Resource
    private PointDao pointDao;

    @Override
    public Integer create(Point point) {
        return pointDao.insert(point);
    }

    @Override
    public List<Point> findAllPoint() {
        return pointDao.findAllPoint();
    }

    @Override
    public List<Point> findAllPointByMemberId(BigInteger memberId) {
        return pointDao.findAllPointByMemberId(memberId);
    }
}
