package com.luckin.service;

import com.luckin.dao.entity.Member;

import java.util.List;

public interface MemberService {
    /**
     * 创建会员
     *
     * @param member
     * @return
     */
    Integer createMember(Member member);

    /**
     * 更新会员
     *
     * @param
     * @return
     */
    Integer updateMember(Member member);

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
    Member findMemberByName(String name);

    /**
     * 查找所有会员信息
     * @return
     */
    List<Member> findAllMember();

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
