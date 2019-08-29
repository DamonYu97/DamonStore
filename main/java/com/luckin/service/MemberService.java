package com.luckin.service;

import com.luckin.dao.entity.Member;

import java.math.BigInteger;
import java.util.List;

/**
 * @author damonyu
 * @since 2019/08/01 09:20
 */
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
     * @param member
     * @return
     */
    Integer updateMember(Member member);

    /**
     * 更新会员积分
     * @param memberId
     * @param point
     * @return
     */
    Integer updatePoint(BigInteger memberId, BigInteger point);

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
     * @param name
     * @param password
     * @return
     */
    Boolean login(String name, String password);

    /**
     * 登录验证
     *
     * @param name
     * @param password
     * @return
     */
    Boolean register(String name, String password);
}
