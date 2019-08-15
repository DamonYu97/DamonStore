package com.luckin.controller.member;

import com.alibaba.fastjson.JSONObject;
import com.luckin.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

@RestController
@RequestMapping("/member")
public class MemberController {
    @Autowired
    private MemberService memberService;

    /**
     * 会员登录
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public void login(HttpServletResponse response, HttpServletRequest request) throws IOException {
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", memberService.login(name,password));
        byte[] dataByte = jsonObject.toString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

}
