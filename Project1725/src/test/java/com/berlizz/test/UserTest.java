package com.berlizz.test;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.berlizz.dto.SignUpDTO;
import com.berlizz.persistence.UserDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml", 
									"file:src/main/webapp/WEB-INF/spring/**/database-context.xml"})
public class UserTest {

	@Inject
	private UserDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(UserTest.class);
	
	@Test
	public void signUpTest() {
		logger.info("signUpTest()");
		SignUpDTO dto = new SignUpDTO();
		dto.setSignUpUserId("tester5");
		dto.setSignUpUserPw("tester5");
		dto.setSignUpUserName("tester5");
		
		try {
			dao.signUp(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
