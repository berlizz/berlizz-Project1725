package com.berlizz.dto;

public class SignUpDTO {

	private String signUpUserId;
	private String signUpUserPw;
	private String signUpUserName;
	
	@Override
	public String toString() {
		return "SignUpDTO [signUpUserId=" + signUpUserId + ", signUpUserPw=" + signUpUserPw + ", signUpUserName="
				+ signUpUserName + "]";
	}

	public String getSignUpUserId() {
		return signUpUserId;
	}

	public void setSignUpUserId(String signUpUserId) {
		this.signUpUserId = signUpUserId;
	}

	public String getSignUpUserPw() {
		return signUpUserPw;
	}

	public void setSignUpUserPw(String signUpUserPw) {
		this.signUpUserPw = signUpUserPw;
	}

	public String getSignUpUserName() {
		return signUpUserName;
	}

	public void setSignUpUserName(String signUpUserName) {
		this.signUpUserName = signUpUserName;
	}
	
	
}
