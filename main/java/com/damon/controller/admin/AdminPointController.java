package com.damon.controller.admin;

import com.alibaba.fastjson.JSONObject;
import com.damon.dao.entity.Point;
import com.damon.service.PointService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/11 21:23
 */

@Controller
@RequestMapping("/admin/point")
public class AdminPointController {
    private final Logger logger = Logger.getLogger(AdminPointController.class);
    @Autowired
    private PointService pointService;

    /**
     * 所有积分信息显示
     */
    @RequestMapping(value = "/showAllPoint", method = RequestMethod.POST)
    public void showAllPoint(HttpServletResponse response) throws IOException {
        List<Point> points = pointService.findAllPoint();
        String pointInfo = JSONObject.toJSONString(points);
        logger.info("All_point: "+ pointInfo);
        byte[] dataByte = pointInfo.getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

}
