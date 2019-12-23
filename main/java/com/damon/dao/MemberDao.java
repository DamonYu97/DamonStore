package com.damon.dao;

import com.damon.dao.entity.Member;
import org.apache.ibatis.annotations.Param;

import java.math.BigInteger;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/08/01 09:10
 */
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
     * 更新会员积分
     * @param memberId
     * @param point
     * @return
     */
    Integer updatePoint(@Param("memberID") BigInteger memberId, @Param("point") BigInteger point);

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
