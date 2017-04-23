package com.berlizz.security;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.core.userdetails.jdbc.JdbcDaoImpl;

import com.berlizz.domain.SecurityUserVO;

public class CustomJdbcDAOImpl extends JdbcDaoImpl {

	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		List<UserDetails> users = loadUsersByUsername(username);
		if(users.size() == 0) {
			throw new UsernameNotFoundException("CustomJdbcDAOImpl not found " + username);
		}
		
		SecurityUserVO vo = (SecurityUserVO) users.get(0);
		
		Set<GrantedAuthority> dbAuthSet = new HashSet<>();
		
		if(getEnableAuthorities()) {
			dbAuthSet.addAll(loadUserAuthorities(vo.getUsername()));
		}
		if(getEnableGroups()) {
			dbAuthSet.addAll(loadGroupAuthorities(vo.getUsername()));
		}
		
		List<GrantedAuthority> dbAuths = new ArrayList<>(dbAuthSet);
		vo.setAuthorities(dbAuths);
		
		if(dbAuths.size() == 0) {
			throw new UsernameNotFoundException("JdbcDaoImpl not found " + username);
		}
		
		return vo;
	}
	
	@Override
	protected List<UserDetails> loadUsersByUsername(String userId) {
		
		return getJdbcTemplate()
				.query(getUsersByUsernameQuery(),
					new String[]{userId},
					new RowMapper<UserDetails>() {
						public UserDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
							String userId = rs.getString(1);
							String userPw = rs.getString(2);
							String userName = rs.getString(3);
							return new SecurityUserVO(userId, userPw, userName, AuthorityUtils.NO_AUTHORITIES);
						}
					}
				);
	}
	
	@Override
	protected List<GrantedAuthority> loadUserAuthorities(String username) {
		
		return getJdbcTemplate()
				.query(getAuthoritiesByUsernameQuery(),
						new String[]{username},
						new RowMapper<GrantedAuthority>() {
							public GrantedAuthority mapRow(ResultSet rs, int rowNum) throws SQLException {
								String role = getRolePrefix() + rs.getString(1);
								
								return new SimpleGrantedAuthority(role);
							}
						}
				);
	}
	
	@Override
	protected List<GrantedAuthority> loadGroupAuthorities(String username) {
		
		return super.loadGroupAuthorities(username);
	}
}
