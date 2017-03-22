package com.berlizz.persistence;

import java.util.Date;

import com.berlizz.domain.UserVO;
import com.berlizz.dto.SignInDTO;

public interface UserDAO {

	public UserVO signIn(SignInDTO dto) throws Exception;
	
	public void keepSignIn(String userId, String sessionId, Date sessionLimit) throws Exception;
	
	public UserVO checkUserWithSessionKey(String sessionKey) throws Exception;
	
}
