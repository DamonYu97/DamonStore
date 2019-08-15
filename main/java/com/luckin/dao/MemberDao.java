package com.luckin.dao;

import com.luckin.dao.entity.Member;

import java.util.List;

public interface MemberDao {
    /**
     * 插入会员记录
     *
     * @param member
     * @return
     */
    Integer insert(Member member);

    /**
     * 删除会员记录
     *
     * @param name
     * @return
     */
    Integer delete(String name);

    /**
     * 更新会员记录
     *
     * @param member
     * @return
     */
    Integer update(Member member);

    /**
     * 根据会员名名查找会员
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
}
