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
	public void createList(ListVO vo) throws Exception {
		dao.createList(vo);
	}

	@Override
	public void updateList(ListVO vo) throws Exception {
		dao.updateList(vo);
	}

	@Override
	public void deleteList(Integer listNumber) throws Exception {
		dao.deleteList(listNumber);
	}

}
