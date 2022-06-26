package com.damon.service;

import com.damon.dao.entity.Admin;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

import static org.junit.Assert.*;

/**
 * 管理员服务测试类
 * @author Lilin Yu
 * @since 2019/08/02 15:20
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml"})
public class AdminServiceTest {
    @Resource
    private AdminService adminService;

    @Test
    public void createMember() {
        Admin admin = new Admin();
        admin.setUsername("damon");
        admin.setRealName("Damon Yu");
        admin.setPhoneNumber("17859717123");
        //密码加密
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        admin.setPassword(passwordEncoder.encode("1204578616"));
        adminService.createAdmin(admin);
    }
}