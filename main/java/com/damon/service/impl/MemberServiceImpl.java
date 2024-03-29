package com.damon.service.impl;

import com.damon.dao.MemberDao;
import com.damon.dao.entity.Member;
import com.damon.service.MemberService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.util.List;

/**
 * @author damonyu
 * @since 2019/11/01 09:32
 */
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
    public Integer updatePoint(BigInteger memberId, BigInteger point) {
        return memberDao.updatePoint(memberId,point);
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
