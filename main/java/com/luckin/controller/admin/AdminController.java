package com.luckin.controller.admin;

import com.alibaba.fastjson.JSONObject;
import com.luckin.dao.entity.Admin;
import com.luckin.dao.entity.Role;
import com.luckin.service.AdminService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/08/01 14:12
 */

@Controller
@RequestMapping("/admin")
public class AdminController {
    private final Logger logger = Logger.getLogger(AdminController.class);
    private final String USERNAME = "username";
    private final String REAL_NAME = "realName";
    private final String PASSWORD = "password";
    private final String OLD_PASSWORD = "oldPassword";
    private final String NEW_PASSWORD = "newPassword";
    private final String PHONE_NUMBER ="phoneNumber";
    private final String ADMIN = "admin";
    private final String ROLE = "role";
    private final String NAME = "name";
    private final String IS_VALID = "valid";
    private final String TYPE = "type";
    private final String USER_MANAGE = "userManage";

    @Autowired
    private AdminService adminService;
    /**
     * 主页
     */
    @RequestMapping("/index")
    public String index() {
        return "admin/index";
    }

    /**
     * 个人信息
     */
    @RequestMapping("/profile")
    public String profile(Model model) {
        //获取当前用户信息
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal != null) {
            if (principal instanceof Admin) {
                Admin admin = adminService.findValidAdminByUsername(((Admin) principal).getUsername());
                model.addAttribute(ADMIN,admin);
            }
        }
        return "admin/profile";
    }

    /**
     * 商品管理页面
     */
    @RequestMapping("/productManage")
    public String productManage() {
        return "admin/productManage";
    }

    /**
     * 会员信息管理页面
     */
    @RequestMapping("/memberManage")
    public String memberManage() {
        return "admin/memberManage";
    }

    /**
     * 订单管理页面
     */
    @RequestMapping("/orderManage")
    public String orderManage() {
        return "admin/orderManage";
    }

    /**
     * 积分管理页面
     */
    @RequestMapping("/pointManage")
    public String pointManage() {
        return "admin/pointManage";
    }

    /**
     * 判断管理员用户名是否已存在
     */
    @RequestMapping(value = "/checkUsername", method = RequestMethod.POST)
    public void checkUsername(HttpServletResponse response, HttpServletRequest request) throws IOException {
        String username = request.getParameter(USERNAME);
        JSONObject jsonObject = new JSONObject();
        if (username != null && !username.equals("") && adminService.findValidAdminByUsername(username) != null) {
            jsonObject.put(IS_VALID, false);
        } else {
            jsonObject.put(IS_VALID, true);
        }
        byte[] dataByte = jsonObject.toString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    /**
     * 更改用户名
     */
    @RequestMapping(value = "/updateUsername", method = RequestMethod.POST)
    public String updateUsername( HttpServletRequest request) throws IOException {
        //输入的用户名
        String username = request.getParameter(USERNAME);
        //原用户名
        String name = request.getParameter(NAME);
        Admin admin = adminService.findValidAdminByUsername(name);
        admin.setUsername(username);
        adminService.updateAdmin(admin);
        //修改成功后登出
        return "redirect:/logout.do";
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
        String username = request.getParameter(USERNAME);
        logger.info("update password of :" + username);
        Admin admin = adminService.findValidAdminByUsername(username);
        admin.setPassword(encodedPassword);
        adminService.updateAdmin(admin);
        //根据操作界面的类型确定返回位置
        String type = request.getParameter(TYPE);
        if (USER_MANAGE.equals(type)) {
            return "redirect:/admin/userManage";
        } else {
            return "redirect:/logout.do";
        }
    }

    /**
     * 更改管理员手机号
     */
    @RequestMapping(value = "/updatePhone", method = RequestMethod.POST)
    public String updatePhone( HttpServletRequest request) throws IOException {
        //新手机号
        String phone = request.getParameter(PHONE_NUMBER);
        //当前用户名
        String name = request.getParameter(NAME);
        Admin admin = adminService.findValidAdminByUsername(name);
        admin.setPhoneNumber(phone);
        adminService.updateAdmin(admin);
        //修改成功后登出
        return "redirect:/admin/profile";
    }

    /**
     * 管理员登录
     */
    @RequestMapping("/adminLogin")
    public String login() {
        return "admin/login";
    }

    /**
     * 用户管理
     */
    @RequestMapping("/userManage")
    public String userManage(Model model) {
        //获取当前用户信息
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal != null) {
            if (principal instanceof Admin) {
                Admin admin = adminService.findValidAdminByUsername(((Admin) principal).getUsername());
                model.addAttribute(ADMIN,admin);
            }
        }
        return "admin/userManage";
    }

    /**
     * 所有管理员信息显示
     */
    @RequestMapping(value = "/showAllAdmin", method = RequestMethod.POST)
    public void showAllAdmin(HttpServletResponse response) throws IOException {
        List<JSONObject> jsonObjects = new ArrayList<>();
        List<Admin> admins = adminService.findAllAdmin();
        for (Admin admin: admins) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put(ADMIN, JSONObject.toJSON(admin));
            //获取管理员角色名称
            String roleName = adminService.findRoleByUsername(admin.getUsername()).getName();
            jsonObject.put(ROLE, JSONObject.toJSON(roleName));
            jsonObjects.add(jsonObject);
        }
        logger.info("Admin_Role: "+ jsonObjects.toString());
        byte[] dataByte = jsonObjects.toString().getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    /**
     * 显示所有角色
     */
    @RequestMapping(value = "/showAllRole", method = RequestMethod.POST)
    public void showAllRole(HttpServletResponse response) throws IOException {
        List<Role> roles = adminService.findAllRole();
        String roleString = JSONObject.toJSONString(roles);
        logger.info("All Roles: "+ roleString);
        byte[] dataByte = roleString.getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    /**
     * 新增管理员
     */
    @RequestMapping(value = "/createAdmin", method = RequestMethod.POST)
    public String createAdmin(HttpServletRequest request) throws IOException {
       //获取表单数据
        String username = request.getParameter(USERNAME);
        String password = request.getParameter(PASSWORD);
        String realName = request.getParameter(REAL_NAME);
        String phoneNumber = request.getParameter(PHONE_NUMBER);
        //加密新密码
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encodedPassword = passwordEncoder.encode(password);
        //创建新的管理员
        Admin admin = new Admin();
        admin.setUsername(username);
        admin.setPhoneNumber(phoneNumber);
        admin.setRealName(realName);
        admin.setPassword(encodedPassword);
        adminService.createAdmin(admin);
        //绑定管理员角色
        //1.获取新的管理员的id
        BigInteger adminID = adminService.findValidAdminByUsername(username).getId();
        logger.info("adminID: " + adminID);
        //2.获取角色id
        int roleID = Integer.parseInt(request.getParameter(ROLE));
        logger.info("roleID: " + roleID);
        adminService.bindRole(adminID, roleID);
        //返回用户管理界面
        return "redirect:/admin/userManage";
    }

    /**
     * 删除管理员（状态设为0，即无效）
     */
    @RequestMapping(value = "/deleteAdmin", method = RequestMethod.GET)
    public String deleteAdmin(HttpServletRequest request) throws IOException {
        String username = request.getParameter(USERNAME);
        logger.info("All Roles: "+ username);
        adminService.updateStatusToInvalid(username);
        //返回用户管理界面
        return "redirect:/admin/userManage";
    }

}
