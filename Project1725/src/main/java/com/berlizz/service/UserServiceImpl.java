package com.berlizz.service;

import java.util.Date;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.berlizz.domain.UserVO;
import com.berlizz.dto.SignInDTO;
import com.berlizz.dto.SignUpDTO;
import com.berlizz.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO dao;
	
	@Override
	public UserVO signIn(SignInDTO dto) throws Exception {
		return dao.signIn(dto);
	}
	
	@Override
	public void keepSignIn(String userId, String sessionId, Date sessionLimit) throws Exception {
		dao.keepSignIn(userId, sessionId, sessionLimit);
	}
	
	@Override
	public UserVO checkUserWithSessionKey(String sessionKey) throws Exception {
		return dao.checkUserWithSessionKey(sessionKey);
	}
	
	@Override
	public void signUp(SignUpDTO dto) throws Exception {
		dao.signUp(dto);
	}

}
