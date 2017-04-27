package com.berlizz.controller;

import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.util.WebUtils;

import com.berlizz.domain.UserVO;
import com.berlizz.dto.SignInDTO;
import com.berlizz.dto.SignUpDTO;
import com.berlizz.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Inject
	private UserService service;
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	
	@RequestMapping(value = "/signIn", method = RequestMethod.POST)
	public void signIn(SignInDTO dto, Model model, HttpSession session) throws Exception {
		logger.info("signIn()");
		
		UserVO vo = service.signIn(dto);
		if(vo == null) {
			return;
		}
		
		model.addAttribute("userVO", vo);
		
		/* remember me 체크일 경우 */
		if(dto.isUseCookie()) {
			int amount = 60 * 60 * 24 * 7;	// 일주일
			Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));
			
			service.keepSignIn(vo.getUserId(), session.getId(), sessionLimit);
		}
	}
	
	@RequestMapping(value = "/signOut", method = RequestMethod.GET)
	public String signOut(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("signOut()");
		
		Object obj = session.getAttribute("signIn");
		if(obj != null) {
			session.removeAttribute("signIn");
			session.invalidate();
			
			UserVO userVO = (UserVO) obj;
			
			/* 로그아웃 시 자동로그인 쿠키 가지고 있으면 삭제 */
			Cookie signInCookie = WebUtils.getCookie(request, "signInCookie");
			if(signInCookie != null) {
				signInCookie.setPath("/");
				signInCookie.setMaxAge(0);
				response.addCookie(signInCookie);
				service.keepSignIn(userVO.getUserId(), session.getId(), new Date());
			}
		}
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/signUp", method = RequestMethod.POST)
	public void signUp(SignUpDTO dto, Model model) throws Exception {
		logger.info("signUp()");
		
		model.addAttribute("userId", dto.getSignUpUserId());
		model.addAttribute("userPw", dto.getSignUpUserPw());
		
		service.signUp(dto);
		
	}
	
}
