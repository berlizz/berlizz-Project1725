package com.berlizz.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SignInInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(SignInInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("preHandle()");
		
		HttpSession session = request.getSession();
		if(session.getAttribute("signIn") != null) {
			session.removeAttribute("signIn");
		}
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		logger.info("postHandle()");
		
		HttpSession session = request.getSession();
		ModelMap modelMap = modelAndView.getModelMap();
		
		Object userVO = modelMap.get("userVO");
		
		/* 로그인 성공 시 세션 생성 */
		if(userVO != null) {
			session.setAttribute("signIn", userVO);
			
			/* 자동 로그인 쿠키 생성 */
			if(request.getParameter("useCookie") != null) {
				Cookie signInCookie = new Cookie("signInCookie", session.getId());
				signInCookie.setPath("/");
				signInCookie.setMaxAge(60 * 60 * 24 * 7);	// 일주일
				response.addCookie(signInCookie);
			}
			
			response.sendRedirect("/board/list");
			
		} else {
			response.sendRedirect("/");
		}
	}
}
