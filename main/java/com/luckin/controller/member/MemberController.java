package com.luckin.controller.member;

import com.alibaba.fastjson.JSONObject;
import com.luckin.dao.entity.Member;
import com.luckin.service.MemberService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

/**
 * @author Lilin Yu
 * @since 2019/08/12 8:30
 */
@Controller
@RequestMapping("/member")
public class MemberController {
    private final Logger logger = Logger.getLogger(MemberController.class);
    private final String MEMBER_NAME = "memberName";
    private final String MEMBER = "member";
    private final String OLD_NAME = "oldName";
    private final String OLD_PASSWORD = "oldPassword";
    private final String NEW_PASSWORD = "newPassword";
    private final String NAME = "name";
    private final String GENDER = "gender";
    private final String PHONE_NUMBER = "phoneNumber";
    private final String EMAIL = "email";
    private final String PASSWORD = "password";
    private final String IS_VALID = "valid";
    private final int MAX_AGE = 3600;
    @Autowired
    private MemberService memberService;

    /**
     * DamonStore主页
     */
    @RequestMapping("/index")
    public String index() {
        return "member/index";
    }

    /**
     * 会员登录页面
     */
    @RequestMapping("/toLogin")
    public String toLogin() {
        return "member/login";
    }

    /**
     * 会员账号页面
     */
    @RequestMapping("/myAccount")
    public String myAccount(HttpServletRequest request, Model model) {
        //获取当前用户名
        HttpSession session = request.getSession();
        Member member = (Member)session.getAttribute(MEMBER);
        member = memberService.findMemberByName(member.getName());
        model.addAttribute(MEMBER,member);
        return "member/myAccount";
    }

    /**
     * 会员地址信息页面
     */
    @RequestMapping("/address")
    public String address() {
        return "member/address";
    }

    /**
     * 商品页面
     */
    @RequestMapping("/products")
    public String products() {
        return "member/products";
    }

    /**
     * 商品详情页面
     */
    @RequestMapping("/productDetail")
    public String productDetail() {
        return "member/productDetail";
    }

    /**
     * 会员登录
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter(NAME);
        String password = request.getParameter(PASSWORD);
        boolean result = memberService.login(name,password);
        Member member = memberService.findMemberByName(name);
        if (result == true) {
            //Session 保存登录状态
            recordLoginState(request, response, member);
            return "redirect:/member/index";
        } else {
            return "redirect:/member/toLogin?error=true";
        }
    }

    /**
     * 会员登录页面
     */
    @RequestMapping("/toRegister")
    public String toRegister() {
        return "member/register";
    }

    /**
     * 会员注册
     */
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter(NAME);
        String password = request.getParameter(PASSWORD);
        //加密密码
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encodedPassword = passwordEncoder.encode(password);
        //注册会员
        Member member = new Member();
        member.setName(name);
        member.setPassword(encodedPassword);
        memberService.createMember(member);
        //判断是否注册成功
        boolean result = memberService.login(name,password);
        if (result == true) {
            recordLoginState(request, response, member);
            return "redirect:/member/index";
        } else {
            return "redirect:/member/toRegister?error=true";
        }
    }

    private void recordLoginState(HttpServletRequest request, HttpServletResponse response, Member member) {
        //Session 保存登录状态
        HttpSession session = request.getSession();
        String sessionID = session.getId();
        Cookie cookie = new Cookie("JSESSIONID", sessionID);
        cookie.setMaxAge(MAX_AGE);
        cookie.setPath(request.getContextPath());
        response.addCookie(cookie);
        session.setAttribute(MEMBER, member);
        logger.info("Member login: " + member.getName());
    }

    /**
     * 判断管理员用户名是否已存在
     */
    @RequestMapping(value = "/checkUsername", method = RequestMethod.POST)
    public void checkUsername(HttpServletResponse response, HttpServletRequest request) throws IOException {
        String name = request.getParameter(NAME);
        JSONObject jsonObject = new JSONObject();
        if (!name.equals("") && memberService.findMemberByName(name) != null) {
            jsonObject.put(IS_VALID, false);
        } else {
            jsonObject.put(IS_VALID, true);
        }
        byte[] dataByte = jsonObject.toString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    /**
     * 退出当前登录
     */
    @RequestMapping(value = "/toLogout", method = RequestMethod.GET)
    public String toLogout(HttpServletRequest request) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(MEMBER_NAME);
        }
        return "redirect:/member/toLogin";
    }

    /**
     * 更新会员用户名
     */
    @RequestMapping(value = "/updateName", method = RequestMethod.POST)
    public String updateName(HttpServletRequest request) throws IOException {
        //获取当前用户名
        String name = request.getParameter(OLD_NAME);
        String newName = request.getParameter(NAME);
        Member member = memberService.findMemberByName(name);
        member.setName(newName);
        memberService.updateMember(member);
        return "redirect:/member/toLogout";
    }

    /**
     * 判断管理员密码是否正确
     */
    @RequestMapping(value = "/checkPassword", method = RequestMethod.POST)
    public void checkPassword(HttpServletResponse response, HttpServletRequest request) throws IOException {
        //输入的旧密码
        String oldPassword = request.getParameter(OLD_PASSWORD);
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        //原密码
        String password = request.getParameter(PASSWORD);
        JSONObject jsonObject = new JSONObject();
        if (passwordEncoder.matches(oldPassword,password)) {
            jsonObject.put(IS_VALID, true);
        } else {
            jsonObject.put(IS_VALID, false);
        }
        byte[] dataByte = jsonObject.toString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    /**
     * 更改管理员密码
     */
    @RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
    public String updatePassword(HttpServletRequest request) throws IOException {
        //加密新密码
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encodedPassword = passwordEncoder.encode(request.getParameter(NEW_PASSWORD));
        //当前用户名
        String name = request.getParameter(NAME);
        logger.info("update password of :" + name);
        Member member = memberService.findMemberByName(name);
        member.setPassword(encodedPassword);
        memberService.updateMember(member);
        return "redirect:/member/toLogout";
    }

    /**
     * 更改会员手机号
     */
    @RequestMapping(value = "/updatePhone", method = RequestMethod.POST)
    public String updatePhone( HttpServletRequest request) throws IOException {
        //新手机号
        String phone = request.getParameter(PHONE_NUMBER);
        //当前用户名
        String name = request.getParameter(NAME);
        Member member = memberService.findMemberByName(name);
        member.setPhoneNumber(phone);
        memberService.updateMember(member);
        //修改成功返回个人信息页面
        return "redirect:/member/myAccount";
    }

    /**
     * 更改会员手机号
     */
    @RequestMapping(value = "/updateEmail", method = RequestMethod.POST)
    public String updateEmail( HttpServletRequest request) throws IOException {
        //新邮箱
        String email = request.getParameter(EMAIL);
        //当前用户名
        String name = request.getParameter(NAME);
        Member member = memberService.findMemberByName(name);
        member.setEmail(email);
        memberService.updateMember(member);
        //修改成功后返回个人信息页面
        return "redirect:/member/myAccount";
    }

    /**
     * 设置会员性别
     */
    @RequestMapping(value = "/setGender", method = RequestMethod.POST)
    public String setGender( HttpServletRequest request) throws IOException {
        int gender = Integer.parseInt(request.getParameter(GENDER));
        logger.info("Gender: " + gender);
        //当前用户名
        String name = request.getParameter(NAME);
        Member member = memberService.findMemberByName(name);
        member.setGender(gender);
        memberService.updateMember(member);
        //修改成功后返回个人信息页面
        return "redirect:/member/myAccount";
    }


}
