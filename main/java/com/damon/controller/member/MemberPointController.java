package com.damon.controller.member;

import com.alibaba.fastjson.JSONObject;
import com.damon.dao.entity.Member;
import com.damon.dao.entity.Point;
import com.damon.service.PointService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/25 19:20
 */
@Controller
@RequestMapping("/member/point")
public class MemberPointController {
    private final Logger logger = Logger.getLogger(MemberPointController.class);
    private final String MEMBER = "member";
    @Autowired
    private PointService pointService;

    /**
     * 查找当前会员积分纪录
     * @param request
     * @param response
     */
    @RequestMapping(value = "/checkPointRecord", method = RequestMethod.POST)
    public void checkPointRecord(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取当前用户ID
        HttpSession session = request.getSession();
        Member member = (Member)session.getAttribute(MEMBER);
        BigInteger memberId = member.getId();
        //获取积分纪录
        List<Point> pointRecord = pointService.findAllPointByMemberId(memberId);
        logger.info("point records: " + JSONObject.toJSONString(pointRecord));
        byte[] dataByte = JSONObject.toJSONString(pointRecord).getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }
}
