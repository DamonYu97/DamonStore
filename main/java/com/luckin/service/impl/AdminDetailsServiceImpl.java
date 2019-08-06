package com.luckin.service.impl;

import com.luckin.dao.AdminDao;
import com.luckin.dao.entity.Admin;
import com.luckin.dao.entity.Permission;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/08/01 11:12
 */

@Service(value = "adminDetailsService")
public class AdminDetailsServiceImpl implements UserDetailsService {
    private final Logger logger = Logger.getLogger(AdminDetailsServiceImpl.class);
    @Autowired
    private AdminDao adminDao;
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Admin admin = adminDao.findByUsername(username);
        List<Permission> permissions = adminDao.findPermissionByUsername(username);
        List<GrantedAuthority> authorities = new ArrayList<>();
        for (Permission permission: permissions) {
            GrantedAuthority authority = new SimpleGrantedAuthority(permission.getTag());
            authorities.add(authority);
        }
        admin.setAuthorities(authorities);
        //User user = new User("damon","{noop}1204578616",AuthorityUtils.commaSeparatedStringToAuthorityList("ROLE_USER"));
        logger.info("Admin:"+admin.getPassword());
        return admin;
    }
}
