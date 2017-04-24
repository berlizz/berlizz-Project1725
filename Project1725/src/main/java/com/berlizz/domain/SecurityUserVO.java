package com.berlizz.domain;

import java.io.Serializable;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.Assert;

public class SecurityUserVO implements UserDetails {

	private static final long serialVersionUID = 1L;
	
	private String userId;	// 유저 아이디
	private String userPw;	// 유저 패스워드
	private String name;	// 유저 이름
	private Set<GrantedAuthority> authorities;
	
	public SecurityUserVO(String userId, String userPw, String userName, Collection<? extends GrantedAuthority> authorities) {
		this.userId = userId;
		this.userPw = userPw;
		this.name = userName;
		this.authorities = Collections.unmodifiableSet(sortAuthorities(authorities));
	}
	
	@Override
	public String toString() {
		return "SecurityUserVO [userId=" + userId + ", userPw=" + userPw + ", name=" + name + "]";
	}
	
	@Override	// 유저 아이디 getter 호출
	public String getUsername() {
		return getUserId();
	}
	
	@Override
	public String getPassword() {
		return getUserPw();
	}

	@Override
	public Set<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}
	
	/* 
	 *	계정만료, 잠김, 패스워드만료, 사용가능 여부기능 모두 사용하지 않아 return true
	 *  */
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	
	@Override
	public boolean isEnabled() {
		return true;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public void setAuthorities(Collection<? extends GrantedAuthority> authorities) {
		this.authorities = Collections.unmodifiableSet(sortAuthorities(authorities));
	}
	
	private SortedSet<GrantedAuthority> sortAuthorities(Collection<? extends GrantedAuthority> authorities) {
		Assert.notNull(authorities, "cannot pass a null grantedAuthority collection");
		SortedSet<GrantedAuthority> sortedAuthorities = new TreeSet<>(new AuthorityComparator());
		
		for(GrantedAuthority grantedAuthority : authorities) {
			Assert.notNull(grantedAuthority, "GrantedAuthority list cannot contain any null elements");
			sortedAuthorities.add(grantedAuthority);
		}
		
		return sortedAuthorities;
	}
	
	
	private static class AuthorityComparator implements Comparator<GrantedAuthority>, Serializable {
		
		private static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;

		@Override
		public int compare(GrantedAuthority g1, GrantedAuthority g2) {
			if(g2.getAuthority() == null) {
				return -1;
			}
			
			if(g1.getAuthority() == null) {
				return 1;
			}
			
			return g1.getAuthority().compareTo(g2.getAuthority());
		}
	}
	
	
}
