package com.berlizz.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.berlizz.domain.ListVO;
import com.berlizz.domain.UserVO;
import com.berlizz.persistence.ListDAO;

@Service
public class ListServiceImpl implements ListService {
	
	@Inject
	private ListDAO dao;

	@Override
	public List<ListVO> listAll() throws Exception {
		return dao.listAll();
	}

	@Override
	public List<ListVO> listSelect(String regDate, UserVO vo) throws Exception {
		return dao.listSelect(regDate, vo);
	}
	
	@Override
	public ListVO listSelectOne(Integer listNumber) throws Exception {
		return dao.listSelectOne(listNumber);
	}
	
	@Override
	public List<ListVO> uncompletedSelect(UserVO vo) throws Exception {
		return dao.uncompletedSelect(vo);
	}
	
	@Override
	public List<ListVO> completedSelect(UserVO vo) throws Exception {
		return dao.completedSelect(vo);
	}

	@Override
	public void createList(ListVO vo) throws Exception {
		dao.createList(vo);
	}

	@Override
	public void updateList(ListVO vo) throws Exception {
		dao.updateList(vo);
	}
	
	@Override
	public void completionUpdate(Integer listNumber) throws Exception {
		dao.completionUpdate(listNumber);
	}

	@Override
	public void deleteList(Integer listNumber) throws Exception {
		dao.deleteList(listNumber);
	}
	
	@Transactional
	@Override
	public void addAttach(String fullName, Integer listNumber) throws Exception {
		dao.addAttach(fullName, listNumber);
		dao.updateAttachCount(1, listNumber);
	}
	
	@Override
	public List<String> getAttach(Integer listNumber) throws Exception {
		return dao.getAttach(listNumber);
	}
	
	@Transactional
	@Override
	public void deleteAttach(String fullName, Integer listNumber) throws Exception {
		dao.deleteAttach(fullName);
		
		if(listNumber != null) {
			dao.updateAttachCount((-1), listNumber);
		}
	}
	

}
