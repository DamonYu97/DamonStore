package com.damon.controller.admin;

import com.alibaba.fastjson.JSONObject;
import com.damon.dao.entity.Member;
import com.damon.service.MemberService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/11 08:50
 */

@Controller
@RequestMapping("/admin/member")
public class AdminMemberController {
    private final Logger logger = Logger.getLogger(AdminMemberController.class);
    private final String PASSWORD = "password";
    private final String NAME = "name";
    @Autowired
    private MemberService memberService;

    /**
     * 所有会员信息显示
     */
    @RequestMapping(value = "/showAllMember", method = RequestMethod.POST)
    public void showAllMember(HttpServletResponse response) throws IOException {
        List<Member> members = memberService.findAllMember();
        String memberInfo = JSONObject.toJSONString(members);
        logger.info("All_member: "+ memberInfo);
        byte[] dataByte = memberInfo.getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    /**
     * 更改会员密码
     */
    @RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
    public String updatePassword(HttpServletRequest request) throws IOException {
        //加密新密码
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encodedPassword = passwordEncoder.encode(request.getParameter(PASSWORD));
        logger.info("encoded password :" + encodedPassword);
        //当前用户名
        String name = request.getParameter(NAME);
        logger.info("update password of :" + name);
        Member member = memberService.findMemberByName(name);
        member.setPassword(encodedPassword);
        memberService.updateMember(member);
        return "redirect:/admin/memberManage";
    }
}
