package com.berlizz.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {
	
	private String signInIdName;
	private String defaultFailureUrl;
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		String signInId = request.getParameter(getSignInIdName());
		
		HttpSession session = request.getSession();
		session.setAttribute("signInId", signInId);
		response.sendRedirect(getDefaultFailureUrl());
		
	}

	public String getSignInIdName() {
		return signInIdName;
	}

	public void setSignInIdName(String signInIdName) {
		this.signInIdName = signInIdName;
	}

	public String getDefaultFailureUrl() {
		return defaultFailureUrl;
	}

	public void setDefaultFailureUrl(String defaultFailureUrl) {
		this.defaultFailureUrl = defaultFailureUrl;
	}
	
}
