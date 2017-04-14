package com.berlizz.service;

import java.util.Date;

import com.berlizz.domain.UserVO;
import com.berlizz.dto.SignInDTO;
import com.berlizz.dto.SignUpDTO;

public interface UserService {

	public UserVO signIn(SignInDTO dto) throws Exception;
	
	public void keepSignIn(String userId, String sessionId, Date sessionLimit) throws Exception;
	
	public UserVO checkUserWithSessionKey(String sessionKey) throws Exception;
	
	public void signUp(SignUpDTO dto) throws Exception;
	
}
