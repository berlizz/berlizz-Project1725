package com.berlizz.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.berlizz.domain.ListVO;
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
	public List<ListVO> listSelect(String regDate) throws Exception {
		return dao.listSelect(regDate);
	}
	
	@Override
	public ListVO listSelectOne(Integer listNumber) throws Exception {
		return dao.listSelectOne(listNumber);
	}
	
	@Override
	public List<ListVO> uncompletedSelect() throws Exception {
		return dao.uncompletedSelect();
	}
	
	@Override
	public List<ListVO> completedSelect() throws Exception {
		return dao.completedSelect();
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
	
	@Override
	public void addAttach(String fullName, Integer listNumber) throws Exception {
		dao.addAttach(fullName, listNumber);
	}
	
	@Override
	public List<String> getAttach(Integer listNumber) throws Exception {
		return dao.getAttach(listNumber);
	}
	
	@Override
	public void deleteAttach(String fullName) throws Exception {
		dao.deleteAttach(fullName);
	}

}
