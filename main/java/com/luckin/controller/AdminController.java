package com.luckin.controller;

import com.luckin.dao.AdminDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Lilin Yu
 * @since 2019/08/01 14:12
 */

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AdminDao adminDao;

    /**
     * 主页
     */
    @RequestMapping("/index")
    public String index() {
        return "admin/index";
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
    public String userManage() {
        return "admin/userManage";
    }

}
