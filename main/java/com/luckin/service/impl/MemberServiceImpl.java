package com.luckin.service.impl;

import com.luckin.dao.MemberDao;
import com.luckin.dao.entity.MemberEntity;
import com.luckin.service.MemberService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class MemberServiceImpl implements MemberService {
    @Resource
    private MemberDao memberDao;

    @Override
    public Integer createMember(MemberEntity memberEntity) {
        return memberDao.insert(memberEntity);
    }

    @Override
    public Integer updateMember(MemberEntity memberEntity) {
        return memberDao.update(memberEntity);
    }

    @Override
    public Integer deleteMember(String name) {
        return memberDao.delete(name);
    }

    @Override
    public MemberEntity getUserByName(String name) {
        return memberDao.selectByName(name);
    }

    @Override
    public Boolean login(String name, String password) {
        MemberEntity memberEntity = memberDao.selectByName(name);
        if (memberEntity != null && memberEntity.getName().equals(name) && memberEntity.getPassword().equals(password)){
            return true;
        }
        return false;
    }

    @Override
    public Boolean register(String name, String password) {
        if (memberDao.selectByName(name) == null) {
            MemberEntity memberEntity = new MemberEntity();
            memberEntity.setName(name);
            memberEntity.setPassword(password);
            if (memberDao.insert(memberEntity) != null){
                return true;
            }
        }
        return false;
    }
}
