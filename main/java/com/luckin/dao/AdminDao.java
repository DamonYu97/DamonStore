package com.luckin.dao;

import com.luckin.dao.entity.Admin;
import com.luckin.dao.entity.Role;
import com.luckin.dao.entity.Permission;

import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/08/01 10:20
 */

public interface AdminDao {
    /**
     * 通过用户名查询当前管理员对象
     */
    Admin findValidAdminByUsername(String username);

    /**
     * 通过用户名查询当前管理员角色
     */
    Role findRoleByUsername(String username);

    /**
     * 通过用户名查询当前管理员拥有的权限
     */
    List<Permission> findPermissionByUsername(String username);

    /**
     * 插入管理员记录
     * @param admin
     * @return
     */
    Integer insert(Admin admin);

    /**
     * 绑定管理员角色
     * @param adminID
     * @param roleID
     * @return
     */
    Integer bindRole(BigInteger adminID, int roleID);

    /**
     * 更新管理员信息
     * @param admin
     * @return
     */
    Integer update(Admin admin);

    /**
     * 查询所有管理员对象
     */
    List<Admin> findAllAdmin();

    /**
     * 查询所有管理员对象
     */
    List<Role> findAllRole();

}
