package com.luckin.service;

import com.luckin.dao.entity.Admin;
import com.luckin.dao.entity.Role;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/08/01 10:40
 */

public interface AdminService extends UserDetailsService{

    /**
     * 创建管理员
     * @param admin
     * @return
     */
    Integer createAdmin(Admin admin);

    /**
     * 修改管理员状态为失效
     * @param username
     * @return
     */
    Integer updateStatusToInvalid(String username);

    /**
     * 绑定管理员角色
     * @param adminId
     * @param roleId
     * @return
     */
    Integer bindRole(BigInteger adminId, int roleId);

    /**
     * 更新管理员
     * @param admin
     * @return
     */
    Integer updateAdmin(Admin admin);

    /**
     * 通过用户名查看管理员角色信息
     * @param adminId
     * @return
     */
    Role findRoleByAdminId(BigInteger adminId);

    /**
     * 通过用户名查看有效的管理员信息
     * @param username
     * @return
     */
    Admin findValidAdminByUsername(String username);

    /**
     * 查看所有管理员信息
     * @return
     */
    List<Admin> findAllAdmin();

    /**
     * 查看所有角色
     * @return
     */
    List<Role> findAllRole();
}
