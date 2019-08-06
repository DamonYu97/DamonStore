package com.luckin.dao;

import com.luckin.dao.entity.MemberEntity;

public interface MemberDao {
    /**
     * 插入会员记录
     *
     * @param memberEntity
     * @return
     */
    Integer insert(MemberEntity memberEntity);

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
     * @param memberEntity
     * @return
     */
    Integer update(MemberEntity memberEntity);

    /**
     * 根据会员名名查找会员
     *
     * @param name
     * @return
     */
    MemberEntity selectByName(String name);
}
