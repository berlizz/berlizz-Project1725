package com.berlizz.persistence;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.berlizz.domain.UserVO;
import com.berlizz.dto.SignInDTO;

@Repository
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession session;
	
	private static final String namespace = "com.berlizz.mapper.UserMapper";
	
	@Override
	public UserVO signIn(SignInDTO dto) throws Exception {
		return session.selectOne(namespace + ".signin", dto);
	}
	
	@Override
	public void keepSignIn(String userId, String sessionId, Date sessionLimit) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("sessionId", sessionId);
		map.put("sessionLimit", sessionLimit);
		
		session.update(namespace + ".keepSignIn", map);
	}
	
	@Override
	public UserVO checkUserWithSessionKey(String sessionKey) throws Exception {
		return session.selectOne(namespace + ".checkUserWithSessionKey", sessionKey);
	}

}
