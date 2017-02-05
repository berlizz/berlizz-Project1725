package com.berlizz.test;

import java.sql.Connection;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class DataSourceTest {

	@Inject
	private DataSource ds;
	
	@Inject
	private SqlSession session;
	
	private final static Logger logger = LoggerFactory.getLogger(DataSourceTest.class);
	
	
	@Test
	public void dataSourceTest() throws Exception {
		try(Connection conn = ds.getConnection()) {
			logger.info("dataSourceTest() : " + conn.toString());
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test 
	public void sessionTest() throws Exception {
		logger.info("sessionTest() : " + session.toString());
	}
}
