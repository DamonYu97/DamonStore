package com.luckin.service;

import com.luckin.dao.entity.MemberEntity;

public interface MemberService {
    /**
     * 创建会员
     *
     * @param memberEntity
     * @return
     */
    Integer createMember(MemberEntity memberEntity);

    /**
     * 更新会员
     *
     * @param
     * @return
     */
    Integer updateMember(MemberEntity memberEntity);

    /**
     * 删除会员
     *
     * @param name
     * @return
     */
    Integer deleteMember(String name);

    /**
     * 根据会员名查询会员
     *
     * @param name
     * @return
     */
    MemberEntity getUserByName(String name);

    /**
     * 登录验证
     *
     * @param name,password
     * @return
     */
    Boolean login(String name, String password);

    /**
     * 登录验证
     *
     * @param name,password
     * @return
     */
    Boolean register(String name, String password);
}
