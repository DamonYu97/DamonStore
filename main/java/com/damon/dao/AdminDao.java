package com.damon.dao;

import com.damon.dao.entity.Admin;
import com.damon.dao.entity.Role;
import com.damon.dao.entity.Permission;
import org.apache.ibatis.annotations.Param;

import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/08/01 10:20
 */

public interface AdminDao {
    /**
     * 通过用户名查询当前管理员对象
     * @param username
     * @return
     */
    Admin findValidAdminByUsername(String username);

    /**
     * 通过用户名查询当前管理员角色
     * @param adminId
     * @return
     */
    Role findRoleByAdminId(BigInteger adminId);

    /**
     * 通过用户名查询当前管理员拥有的权限
     * @param adminId
     * @return
     */
    List<Permission> findPermissionByAdminId(BigInteger adminId);

    /**
     * 插入管理员记录
     * @param admin
     * @return
     */
    Integer insert(Admin admin);

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
    Integer bindRole(@Param("adminId") BigInteger adminId, @Param("roleId") int roleId);

    /**
     * 更新管理员信息
     * @param admin
     * @return
     */
    Integer update(Admin admin);

    /**
     * 查询所有管理员对象
     * @return
     */
    List<Admin> findAllAdmin();

    /**
     * 查询所有管理员对象
     * @return
     */
    List<Role> findAllRole();

}
