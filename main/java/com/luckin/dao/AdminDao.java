package com.luckin.dao;

import com.luckin.dao.entity.Admin;
import com.luckin.dao.entity.Permission;

import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/08/01 10:20
 */

public interface AdminDao {
    /**
     * 查询当前管理员对象
     */
    Admin findByUsername(String username);

    /**
     * 查询当前管理员拥有的权限
     */
    List<Permission> findPermissionByUsername(String username);
}
