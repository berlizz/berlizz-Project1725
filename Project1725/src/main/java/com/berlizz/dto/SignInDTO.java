package com.berlizz.dto;

public class SignInDTO {

	private String userId;
	private String userPw;
	private boolean useCookie;
	
	@Override
	public String toString() {
		return "SigninDTO [userId=" + userId + ", userPw=" + userPw + ", useCookie=" + useCookie + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public boolean isUseCookie() {
		return useCookie;
	}

	public void setUseCookie(boolean useCookie) {
		this.useCookie = useCookie;
	}
	
}
