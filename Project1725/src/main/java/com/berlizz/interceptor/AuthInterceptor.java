package com.berlizz.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.berlizz.domain.UserVO;
import com.berlizz.service.UserService;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Inject
	private UserService service;
	
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		logger.info("preHandle()");
		
		HttpSession session = request.getSession();
		
		/* 세션이 없는 경우 */
		if(session.getAttribute("signIn") == null) {
			Cookie signInCookie = WebUtils.getCookie(request, "signInCookie");
			
			/* 세션이 없지만 자동로그인 쿠키를 가지고 있는 경우 */
			if(signInCookie != null) {
				UserVO userVO = service.checkUserWithSessionKey(signInCookie.getValue());
				
				/* 세션 생성 */
				if(userVO != null) {
					session.setAttribute("signIn", userVO);
					return true;
				}
			}
			
			response.sendRedirect("/");
			
			return false;
		}
		
		return true;
	}
}
