package com.berlizz.domain;

public class UserVO {

	public String userId;
	public String userPw;
	public String userName;

	@Override
	public String toString() {
		return "UserVO [userId=" + userId + ", userPw=" + userPw + ", userName=" + userName + ", getClass()="
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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	};
	
	
}
