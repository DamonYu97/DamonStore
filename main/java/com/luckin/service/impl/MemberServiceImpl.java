package com.luckin.service.impl;

import com.luckin.dao.MemberDao;
import com.luckin.dao.entity.Member;
import com.luckin.service.MemberService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {
    @Resource
    private MemberDao memberDao;

    @Override
    public Integer createMember(Member member) {
        return memberDao.insert(member);
    }

    @Override
    public Integer updateMember(Member member) {
        return memberDao.update(member);
    }

    @Override
    public Integer deleteMember(String name) {
        return memberDao.delete(name);
    }

    @Override
    public Member findMemberByName(String name) {
        return memberDao.findMemberByName(name);
    }

    @Override
    public List<Member> findAllMember() {
        return memberDao.findAllMember();
    }

    @Override
    public Boolean login(String name, String password) {
        Member member = memberDao.findMemberByName(name);
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        if (member != null && passwordEncoder.matches(password,member.getPassword())){
            return true;
        }
        return false;
    }

    @Override
    public Boolean register(String name, String password) {
        if (memberDao.findMemberByName(name) == null) {
            Member member = new Member();
            member.setName(name);
            member.setPassword(password);
            if (memberDao.insert(member) != null){
                return true;
            }
        }
        return false;
    }
}
