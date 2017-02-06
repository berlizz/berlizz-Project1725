package com.berlizz.test;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.berlizz.persistence.ListDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ListTest {
	
	@Inject
	private ListDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(ListTest.class);
	
	
	/*@Test
	public void listAllTest() throws Exception {
		List<ListVO> list = dao.listAll();
		for(ListVO listVO : list) {
			logger.info("listNumber : " + listVO.getListNumber());
		}
	}*/
	
	/*@Test
	public void listSelectTest() throws Exception {
		LocalDate now = LocalDate.now();
		String regDate = now.toString();
		List<ListVO> list = dao.listSelect(regDate);
		for(ListVO vo : list) {
			logger.info(vo.toString());
		}
		
		
		LocalDate targetDate = LocalDate.of(2017, 2, 7);
		regDate = targetDate.toString();
		list = dao.listSelect(regDate);
		for(ListVO vo : list) {
			logger.info(vo.toString());
		}
		
	}*/
	
	/*@Test
	public void createListTest() throws Exception {
		ListVO vo = new ListVO();
		vo.setTitle("test");
		vo.setWriter("tester");
		vo.setDescription("test");
		vo.setRegDate(LocalDate.now().toString());
		
		dao.createList(vo);
	}*/
	
	/*@Test
	public void updateListTest() throws Exception {
		ListVO vo = new ListVO();
		vo.setListNumber(4);
		vo.setTitle("update test");
		vo.setDescription("update tester");
		
		dao.updateList(vo);
	}*/
	
	@Test
	public void deleteListTest() throws Exception {
		dao.deleteList(5);
	}
}
